Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266897AbRGHOmO>; Sun, 8 Jul 2001 10:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266901AbRGHOmE>; Sun, 8 Jul 2001 10:42:04 -0400
Received: from roc-24-93-23-46.rochester.rr.com ([24.93.23.46]:26871 "HELO
	devbox.kroptech.com") by vger.kernel.org with SMTP
	id <S266894AbRGHOlv>; Sun, 8 Jul 2001 10:41:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adam Kropelin <akropel1@rochester.rr.com>
Reply-To: akropel1@rochester.rr.com
Organization: KropTech
To: linux-kernel@vger.kernel.org
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
Date: Sun, 8 Jul 2001 10:41:49 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01070810414900.10858@devbox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Roland said:
>I expect someone will rebut my comments about the kernel (which is fine, I'm 
>not a Kernel hacker

Okay, I'll take the bait, but I'm not a kernel hacker, either, so someone 
should feel free to rebut *my* comments as well.

>but it is my understanding that the kernel uses your system BIOS for actual 
>reads/writes at the hardware level, 

No. There are many reasons this isn't done, but a big one is:

BIOS = real mode
Kernel = protected mode

The kernel makes use of some BIOS *tables* (which are coped to known 
locations before the Big Switch), but actual BIOS interrupt routines are used 
only during the early stages of boot. Aside from the RM/PM issue, the BIOS 
isn't used because it is 16-bit, slow, and generally buggy.

See Alan Cox's paper on kernel BIOS usage posted back on 6/22/01 for a nice 
discussion of what use the kernel has for the BIOS.

>When you turn BIOS to <NONE> the OS does what it can, but 
>the BIOS in your system *SHOULD* refuse to process the call, instead it's 
>doing the read/writes, but not the same way as if IDE was turned on. 

An interesting theory, but off the mark.

That said, I don't know what the Right Answer for Martin is, but here are a 
few ideas:

* I notice the boot log shows a CMD646 IDE controller. Make sure the CMD640 
bug-fix support is enabled in your kernel (assuming this applies to 64x 
chips). If you're using a vendor's kernel it almost certainly is already, but 
if you built your own, make sure.

* It is possible that when a drive is assigned in the BIOS, the BIOS will do 
some configuration of the controller or the drive itself which the kernel is 
not doing on its own. I don't know what the state of kernel support for that 
646 chipset is.

* That's a pretty old drive, so I wouldn't rule out hardware problems. 
Strange that it only fails when not configured in the BIOS, though.

Regards,
Adam

