Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752159AbWCJGsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbWCJGsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 01:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWCJGsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 01:48:33 -0500
Received: from fmr20.intel.com ([134.134.136.19]:52636 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750805AbWCJGsb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 01:48:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Fri, 10 Mar 2006 14:46:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B280323@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZEC/aKWokeB/77Riq5d19D3Cgp9gAAgLnA
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
X-OriginalArrivalTime: 10 Mar 2006 06:46:32.0334 (UTC) FILETIME=[5DF70AE0:01C6440E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>>> width) Address=00000000000000B2
>>>
>>> repeated endlessly.
>
>> I need calltrace for this 
>
>Looking at /proc/acpi/debug_level, I see several debugging choices
>that might give the calltrace you want.  Let me know which ones are
>essential (I'd turn all of them on; however, I found when trying to
>track this down earlier that the bug would slither away if I had too
>much debugging turned on):

What do you mean of "slither away" ? 
bug go away?

>
>ACPI_LV_DISPATCH	       0x00000100 [ ]
>ACPI_LV_EXEC		       0x00000200 [ ]
>ACPI_LV_NAMES		       0x00000400 [ ]
>ACPI_LV_FUNCTIONS	       0x00200000 [ ]
>
>By the way, a long standing buglet for me is that 'cat
>/proc/acpi/debug_level' truncates the output to 1024 bytes.  So I have
>to do 'cat /proc/acpi/debug_level | cat' so that the first cat doesn't
>find that its stdout is a tty and try to reduce its buffer size from
>4096 (big enough) to 1024.  A patch is available at
><http://bugzilla.kernel.org/show_bug.cgi?id=5076>

let's start from:

echo -n 0x10 > /proc/acpi/debug_layer
echo -n 0x10 > /proc/acpi/debug_level

>
>> BTW, do you still think this is a regression?
>
>I'm 95% sure, because booting with ec_intr=0 avoids the problem, so
>the commit that made ec_intr=1 the default almost certainly also makes
>this bug appear.

why NOT 100% sure? :-)
