Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSFYMwU>; Tue, 25 Jun 2002 08:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSFYMwT>; Tue, 25 Jun 2002 08:52:19 -0400
Received: from 89dyn229.com21.casema.net ([62.234.20.229]:30082 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S315456AbSFYMwS>; Tue, 25 Jun 2002 08:52:18 -0400
Message-Id: <200206251251.OAA11370@cave.bitwizard.nl>
Subject: IDE Promise hang on 2.4.19-pre2. 
To: linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2002 14:51:39 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We just test-installed a Promise controller in a machine, and tried to
get it probed. Turns out that crashed the machine.

/root# lspci -v -s 00:09.0
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. 20268
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 9
        I/O ports at e000 [size=8]
        I/O ports at d800 [size=4]
        I/O ports at d400 [size=8]
        I/O ports at d000 [size=4]
        I/O ports at c800 [size=16]
        Memory at fb000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1


We then went into the bios (install video card, grab a monitor,
etcetc.)  and told it to assign interrupts automatically, rather than
IRQ9 for all slots.... 

So then the VGA card, ethernet card, scsi card all got assigned
different IRQs than 9.

Now when we insmod the IDE, the machine doesn't crash. 


Hypothesis: The Promise driver enables IRQs on the chip first, then
grabs its IRQ. This leads to an interrupt storm, provided that any
other device is using that IRQ. 

This is on our testing machine: 
	Pentium PRO 150. 
	96Mb RAM. 
	Linux-2.4.19-pre2. 

We've got our system running. We only have the hardware for a day, so
we're running our tests, and won't have time to test stuff (like
upgrading the kernel. Sorry)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
