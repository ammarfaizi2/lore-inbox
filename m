Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTKWUHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 15:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTKWUHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 15:07:07 -0500
Received: from fmr01.intel.com ([192.55.52.18]:3475 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263435AbTKWUHC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 15:07:02 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.4.22 SMP kernel build for hyper threading P4
Date: Sun, 23 Nov 2003 15:06:56 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC886E@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.22 SMP kernel build for hyper threading P4
Thread-Index: AcOrqBEMv8jFX4FZRmefPdNSbpLKEQGUv6cA
From: "Brown, Len" <len.brown@intel.com>
To: "Job 317" <job317@mailvault.com>, "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Nov 2003 20:06:57.0789 (UTC) FILETIME=[59336AD0:01C3B1FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am I missing a step to build a smp kernel for hyper threading?

Yes -- below.

> Hmm... Let's have a look. I started by loading the
> kernel-2.4.20-i686-smp.config file that came with the RH9 distro into
> xconfig. I just turned on ntfs and a couple of other things and saved.
> The comparision is strange. My new config file has:
> 
> # CONFIG_ACPI is not set
> 
> however the RH9 config file has:
> 
> # CONFIG_ACPI is not set
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_ACPI_HT_ONLY is not s
> CONFIG_ACPI_BUSMGR=m
> CONFIG_ACPI_SYS=m
> CONFIG_ACPI_CPU=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_EC=m
> CONFIG_ACPI_CMBATT=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_RELAXED_AML=y

Use "make oldconfig" to re-write your .config and delete stale junk and
options whose depencencies make no sense.  For example, the ACPI drivers
will go away if CONFIG_ACPI is not enabled.

For 2.4.22, try this:

CONFIG_ACPI=y

By itself for full ACPI -- which includes HT.

And this way to limit it to just HT:

CONFIG_ACPI=y
CONFIG_ACPI_HT_ONLY=y

Note that this config scheme proved too confusing and in 2.4.23 and
2.6.0 CONFIG_ACPI_HT_ONLY goes away, and you'll get enough HT to enable
ACPI even without CONFIG_ACPI, as long as you specify CONFIG_SMP in 2.4
or CONFIG_X86_HT=y in 2.6.

> So am I wasting my time with HT?

Measure the performance of something that matters to you before/after
and then you can decide based on objective information.

Cheers,
-Len

Ps. If you run ACPI on 2.4.22 -- we support a patch supplying the latest
ACPI code for that release here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
2.4.22/  This includes the 2.4.23 config changes above, among other
fixes.



