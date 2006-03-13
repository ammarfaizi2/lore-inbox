Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751971AbWCMCCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWCMCCh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 21:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWCMCCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 21:02:37 -0500
Received: from fmr18.intel.com ([134.134.136.17]:14791 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750753AbWCMCCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 21:02:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Mon, 13 Mar 2006 10:00:37 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B2DACA5@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZER8A/swjAM9LtQzSiW/rZjPvnCwB9/cdw
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
X-OriginalArrivalTime: 13 Mar 2006 02:00:41.0718 (UTC) FILETIME=[EEA3F960:01C64641]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>width) Address=0000000023FDFFC0
>exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>width) Address=00000000000000B2
>exregion-0185 [35] ex_system_memory_space: system_memory 0 (32 
>width) Address=0000000023FDFFC0
>exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 
>width) Address=0000000023FDFFC0
>exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 
>width) Address=0000000023FDFFC0
>exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 
>width) Address=00000000000000B2
>
>And then these above four lines (exregion-0185, -0185, -0185, -0290)
>repeat until I reboot.
>

If I understand correctly, it was due to  LEqual(S_AH, 0xA6) awlays
true.
SMM bios code didn't  respond , or respond correctly 
to the request by "store 0x81, APMD"  due to thermal module caused
issue?
I need the acpi trace log before _PTS to see what kind of thermal
related methods got called.

    Method (SMPI, 1, NotSerialized)
    {
        Store (S_AX, Local0)
        Store (0x81, APMD)
        While (LEqual (S_AH, 0xA6))
        {
            Sleep (0x64)
            Store (Local0, S_AX)
            Store (0x81, APMD)
        }
    }

