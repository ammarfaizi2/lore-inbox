Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSEQV6n>; Fri, 17 May 2002 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316718AbSEQV6n>; Fri, 17 May 2002 17:58:43 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:41732
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S316709AbSEQV6l>; Fri, 17 May 2002 17:58:41 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: Athanasius@miggy.org.uk
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020517174702.02292d20@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 May 2002 17:52:35 -0400
To: Athanasius <Athanasius@miggy.org.uk>, lkml <linux-kernel@vger.kernel.org>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Just an offer
In-Reply-To: <20020517163024.GB17483@miggy.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:30 PM 5/17/2002 +0100, Athanasius wrote:

>   It strikes me that this is also in part a LILO 'problem'.  We could
>use some way to tell LILO to only boot a given image _once_ as the
>default, and thence reboot to the normal default.  Combine this with any
>of the methods for remote reboot (hardware watchdog, other machine wired
>to reset, whatever) and you can easily recover from a futzed new kernel.
>   I'm sure LILO can find room for a single byte 'flag' for such things
>and an extra per-config option in /etc/lilo.conf.

Erm, this *IS* possible.

excerpt from `man lilo`:
---
       /sbin/lilo -R - set default command line for next reboot

-R command line
   This option sets the default command for the boot loader the next time it executes. The boot loader will then
   erase  this  line: this is a once-only command. It is typically used in reboot scripts, just before 
    calling  shutdown -r'.

---

/etc/lilo.conf:

image = /vmlinuz-stable
        label = Stable_Kernel
        root = /dev/hda1
        read-only

image = /vmlinuz-test
        label = Test_Kernel
        root = /dev/hda1
        read-only

---

test_kernel.sh:

#!/bin/sh

lilo -R 'default=Test_Kernel' && reboot

---------------------

Normally, LILO will boot the first image listed (in this case, the Stable_Kernel) by default.
However, running 'test_kernel.sh' will -- for one time only -- make the default kernel be the Test_Kernel.

The only thing left is to make the kernel (or, if something goes wrong there, userspace) reboot if something isn't working okay.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

