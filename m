Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267811AbTAMEZn>; Sun, 12 Jan 2003 23:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267815AbTAMEZn>; Sun, 12 Jan 2003 23:25:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267811AbTAMEZm>;
	Sun, 12 Jan 2003 23:25:42 -0500
Date: Sun, 12 Jan 2003 20:30:27 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alexander Puchmayr <alexander.puchmayr@jku.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: USB-Printer status flags question
In-Reply-To: <200301121117.41856.alexander.puchmayr@jku.at>
Message-ID: <Pine.LNX.4.33L2.0301121928220.32468-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Sun, 12 Jan 2003, Alexander Puchmayr wrote:

| After looking at cups (1.1.18) backend/usb.c and the kernel's
| (2.4.19-gentoo-r10) drivers/usb/printer.c I've found some different
| interpretations of the LP_* flags from linux/lp.h
|
| While the kernel seems to use the 8255 status port definitions, which use
| (amongst others) the flags,
|
| #define LP_PSELECD      0x10  /* unchanged input, active high */
| #define LP_PERRORP      0x08  /* unchanged input, active low */
|
| the same bits are defined by POSIX guidelines a few lines above in
| linux/lp.h:
|
| #define LP_OFFL  0x0008
| #define LP_NOPA  0x0010

Does anyone know where I can find these POSIX guidelines?
I tried SUSv3 but didn't see them there.
I'm not sure if the comment about POSIX guidelines is referring
only to the LP* and lp* namespace (prefixes) or to the bit
definitions also.

Are you saying that there are apps that depend on the POSIX bit
definitions?

| Obviously, this leads the cups usb-backend to incorrectly report an empty
| media tray when the printer is online, idle and has enough paper.
|
| This doesn't seem to be something serious, its just a wrong message in cups
| log-file.

The (Linux 2.4.20) kernel drivers/char/lp.c and drivers/usb/printer.c
modules use the 8255 parallel port definitions to read/test the status
port.  This matches the USB printer spec (I'm looking at the USB
v1.1 printer spec).
USB & parport then return that 8-bit value to userspace via an
ioctl (LPGETSTATUS).  Is CUPS using a different ioctl, possibly
LPGETFLAGS?

| PS: Since two different specifications are mixed up, this problem could also
| be a kernel problem.

Um, it would have been a good thing if a "standard" interface were used
for this instead of one that just matches some device's registers,
as long as the standard interface weren't severe overkill.

-- 
~Randy

