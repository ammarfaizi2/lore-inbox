Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTLJC5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTLJC5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:57:06 -0500
Received: from fmr06.intel.com ([134.134.136.7]:5048 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263441AbTLJC5B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:57:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
Date: Wed, 10 Dec 2003 10:56:55 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
Thread-Index: AcO+M+wWoMk0cVXGQi2lrEY3RRWaRAAk82lg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Ryan Underwood" <nemesis-lists@icequake.net>,
       <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 10 Dec 2003 02:56:56.0022 (UTC) FILETIME=[457FE760:01C3BEC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found " evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful". So ACPI seems to work on your machine. 
Since you previous email complain transition to acpi mode failed, could you please tell me what kind of kernel could result in acp mode transition failure on your box?

Regarding IO-APIC issue, I didn't find MADT. Please try acpi=off to verify IO-APCI can work on your box.

Thanks 
Luming

-----Original Message-----
From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-admin@lists.sourceforge.net]On Behalf Of Ryan Underwood
Sent: 2003?12?9? 17:07
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?



Hello,

Not sure if this is appropriate for ACPI or kernel list so I Cc: both.

On my MS-6163 v3.0 (BX Master) board, the IO-APIC was previously being
used before a blacklist was incorrectly added last year.  Now that the
blacklist is removed when I upgraded to 2.4.23, ACPI doesn't seem to
want to enable IO-APIC usage (dmesg attached).  I don't remember whether
or not I had ACPI enabled when the IO-APIC was working a long time ago.

I added some debug statements to arch/i386/kernel/acpi.c/acpi_boot_init()
to try to diagnose the code flow.  However, when recompiling, almost the entire
kernel must be rebuilt for dependencies, which takes forever on my poor
machine... :(  So I didn't want to spend much more time without some outside
opinion of the situation.

But, as you can see from dmesg, it gets here:
|
===>        printk(KERN_INFO PREFIX "past blacklist\n");

#ifdef CONFIG_X86_LOCAL_APIC

        /* 
         * MADT
         * ----
         * Parse the Multiple APIC Description Table (MADT), if exists.
         * Note that this table provides platform SMP configuration 
         * information -- the successor to MPS tables.
         */

XXX     result = acpi_table_parse(ACPI_APIC, acpi_parse_madt);
        if (!result) {
                return 0;
        }
        else if (result < 0) {
                printk(KERN_ERR PREFIX "Error parsing MADT\n");
                return result;
        }
        else if (result > 1)
                printk(KERN_WARNING PREFIX "Multiple MADT tables exist\n");

===>        printk(KERN_INFO PREFIX "past MADT\n")
|
but not here.  There are no other kernel messages printed, so I think XXX is the
failing part.  Why would that happen?  Is it because this is a UP machine and
the call only works for SMP?  (CONFIG_X86_LOCAL_APIC is definitely enabled)

Is it possible that IO-APIC and ACPI can work individually but be mutually
exclusive on a system if the ACPI tables don't correctly describe the IO-APIC?

I have only a shallow understanding of how this works (from reading www.acpi.info
and kernel source) so please bear with me if I am overlooking something obvious.

thanks,

-- 
Ryan Underwood, <nemesis@icequake.net>
