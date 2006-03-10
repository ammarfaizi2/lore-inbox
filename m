Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWCJGOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWCJGOD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 01:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbWCJGOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 01:14:03 -0500
Received: from fmr19.intel.com ([134.134.136.18]:27523 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751726AbWCJGOA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 01:14:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Fri, 10 Mar 2006 14:12:06 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B2802AD@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
thread-index: AcZEA8J8E4YH5c2MTVe2mB6lwuMG4QABIpJg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       <v4l-dvb-maintainer@linuxtv.org>, <video4linux-list@redhat.com>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       <linux-input@atrey.karlin.mff.cuni.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 10 Mar 2006 06:12:09.0137 (UTC) FILETIME=[90342A10:01C64409]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "Yu, Luming" <luming.yu@intel.com>
>> I suggest you to retest, and post dmesg with UN-modified BIOS.
>
>I'm now running/testing an unmodified DSDT with 2.6.16-rc5.  
>For a while
>I had no S3 hangs, but I just noticed them again.  The error 
>is the same
>as with the modified DSDT (with slightly different offsets):

I assume you have tested ec_intr=0 and ec_intr=1.

>
>exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 
>width) Address=0000000023FDFFC0
>exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 
>width) Address=0000000023FDFFC0
>exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>width) Address=00000000000000B2
>
>repeated endlessly.

I need calltrace for this 

>
>I think the problem resurfaced once I decided to let my sleep.sh script
>leave the thermal driver loaded before going into S3 (suspecting that
>the bug might come back if I did that).

Clealy, it's thermal related. We need to narrow down here.

>
>So I susect that my modified DSDT didn't cause the S3 problems, it
>merely exposed one even in the minimal configuration discussed in the
>#5989 report.

The ground rule is Don't use modified DSDT.
If you do that,  the results won't be trusted.

>
>Which makes me wonder about another bug that disappeared when 
>I switched
>to the vanilla DSDT: While printing (via gs+hpijs to an HP photosmart
>2710 via the wireless card), the system makes double-beeps as 
>if it were
>having the AC adapter plugged and unplugged.  These noises happen when
>printing via the wireless card or via USB (to a different HP inkjet),

Interesting, open bug for this.

>but not when printing via the parallel port to a Lexmark laserprinter
>(using just gs).  Since I didn't do anything to the battery code in the
>DSDT, I now wonder whether changing the DSDT merely exposed the issue
>but didn't create it.
>
>[From an earlier msg:]
>> I think the truth is, for 5989, we need to fix thermal and processor
>> driver issue.
>
>I agree, although I think the processor driver is not the culprit.  My
>earlier testing with the (with the modified DSDT) worked fine with the
>processor module loaded, but hung with processor + thermal loaded.
>

ok, we need to start from thermal.  

BTW, do you still think this is a regression?

Thanks,
Luming

