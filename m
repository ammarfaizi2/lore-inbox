Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTK3HJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 02:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264871AbTK3HJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 02:09:28 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:11917 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S264870AbTK3HJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 02:09:25 -0500
Message-ID: <13d401c3b710$d6c17bf0$11ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andries Brouwer" <aebr@win.tue.nl>, "Andrew Clausen" <clausen@gnu.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Date: Sun, 30 Nov 2003 16:08:22 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer replied to Andrew Clausen:

> I am happy with that description.
> "Disk geometry is: some numbers that your BIOS invents".

I'm happy with that too.  Now, since the Linux kernel has no fantasies about
disk geometry, it is fine to refuse to provide such non-existent fantasies
to user space.  However, it remains necessary to provide the BIOS's
fantasies to user space.  Sometimes user space does something (via the
kernel) that will later be interpreted by the BIOS.  User space has to be
able to do it in the manner that the BIOS wants.

> > (i.e. have you got any evidence that, say, that 99.x% of Windows XP
> > installations use LBA to bootstrap?)
>
> Just ask yourself this question: does Windows XP require a bootable
> partition to start below the 1024 cylinder mark?
> Windows NT4 has such a restriction. Not Windows 2000 or XP.

The answer is still yes.  Not on sufficiently modern BIOSes but yes in the
way that the booter uses the BIOS to load the kernel.  I think that a
computer dating from 1998 is not terribly old to expect Linux to run,
especially when Linux does run and Windows XP does run.  I have to keep the
following partitions under the 8 GB mark:
C:  (NTLDR, NTDETECT.COM, BOOT.INI, BOOTSECT.LNX, etc.)
D: (WINNT\whatever the names are for kernel, drivers, etc.)
/boot (grub files and vmlinuz-whatever versions)

Windows NT4 SP4 partly overcame the 8GB mark, but of course SP4 was so badly
broken that it is fortunate that the relevant ATAPI.SYS file is downloadable
separately.  This ATAPI.SYS (when renamed to C:\NTBOOTDD.SYS) can load a
kernel for NT4, 2000, or XP even past the 8GB mark, but this file itself and
NTLDR and BOOT.INI etc. must remain below the 8GB mark.  To do this you have
to keep all of C: below the 8GB mark.  If you install Windows 2000 or XP on
such a machine then you have to take a separate download of this specific
version of ATAPI.SYS again, and you have to manually hack BOOT.INI partway
through the installation sequence.  If you don't do things right then
Windows 2000 or XP becomes unbootable, sometimes during the installation
process (if lucky), sometimes years after the install (when a file needed
during booting gets updated and moved).

Anyway, regardless of which OS you're running, the OS isn't running until
it's running.  The MBR depends on BIOS functions (e.g. the infamous INT13)
to read in the boot loader and the boot loader depends on BIOS functions to
read in the kernel.  Yes Dr. Brouwer, I know you know this.  The question is
why you think that commands such as parted don't have to know this?

