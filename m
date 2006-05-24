Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWEXFQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWEXFQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWEXFQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:16:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:12660 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932592AbWEXFQB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:16:01 -0400
X-IronPort-AV: i="4.05,163,1146466800"; 
   d="scan'208"; a="40752405:sNHT18235147"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: APIC error on CPUx
Date: Wed, 24 May 2006 01:15:55 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB68AD7E5@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC error on CPUx
Thread-Index: AcZ+qMfP9BA5i7RjTPiYFodgrK/UhwAN1Vrw
From: "Brown, Len" <len.brown@intel.com>
To: "Vladimir Dvorak" <dvorakv@vdsoft.org>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2006 05:15:56.0471 (UTC) FILETIME=[22EB6C70:01C67EF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir's SCB2/Serverworks boots with and without "acpi=off",
and in both cases the IOAPICS are set up properly,
the device work, and there are the following messages:

APIC error on CPU1: 00(40)
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)

These are the now infamous "Receive illegal vector" messages.
I expect this chipset has a physical APIC bus (rather than
the FSB delivery used today) which is mis-behaving.

I've never heard of this being associated with an actual
failure (such as a lost interrupt).  This message is already
KERN_DEBUG -- can't get any lower priority than that.
Maybe we should put this message under apic_printk()?

Since acpi=off doesn't make any difference, I recommend
running in the default configuration without this parameter.
----
Jan's system has

APIC error on CPU0: 02(02)

Also seems to be receiving junk on the APIC bus.

> The problem goes away with noapic or acpi=off, but of course that also

> means you don't have IRQs > 15.

My comment about PIC-mode probably being okay applies to this
motherboard
but not Vladimir's above.

>>>Usually a crappy/broken/misdesigned motherboard.

>Elitegroup L7S7A2 here.

This is a SiS746 motherboard.
This kind of error seems to be relatively common on SiS.

-Len
