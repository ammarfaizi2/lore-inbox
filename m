Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbRG3PV3>; Mon, 30 Jul 2001 11:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268903AbRG3PVU>; Mon, 30 Jul 2001 11:21:20 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:51278
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268898AbRG3PVE>; Mon, 30 Jul 2001 11:21:04 -0400
Message-Id: <200107301520.f6UFKtT06867@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: serial console and kernel 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 10:20:55 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> I recently upgraded a linux box to the kernel 2.4.4 (from 2.2.18).
> This box has no display and use the serial console. Since the upgrade
> I can see the boot output on the remote console but I can't use the
> keyboard. Each time I press a key, an interrupt is seen by the
> no-display machine but no char appears in the console.  Today I've
> upgraded an another box to 2.4.7 with a similar setup and I've the
> same problem.

> Is there something that I'm missing ? (something new with the kernel
> 2.4 that is required for a serial console that was not required with
> the 2.2 ?)

I hate to send an email which says "it works for me", but it does (all the way 
up to 2.4.7).

However, one of the things to remember about the serial console is that it is 
primarily designed for *output*.  If you see the boot messages, then it's 
doing its job correctly.  Things like kdb and sysrq can accept input from the 
serial console, but usually only if something else (like getty) has opened it 
first.

My setup (on RedHat 7.1) looks like this

In /etc/lilo.conf

# make lilo output to serial console
serial=0,9600n8

# for each kernel add this line
        append="console=ttyS0,9600n8 console=tty0"

Note, the above append causes /dev/console to be /dev/tty0 (the virtual 
console).  If you want to see all the boot messages you need /dev/ttyS0 to be 
/dev/console and you should reverse the two console statements in this line.

In /etc/inittab:

S:0123456:respawn:/sbin/mingetty --noclear ttyS0

With this setup I can activate sysrq and kdb from the serial console.

Note also that different distributions have different ways of handling the 
system console; you might also have to disable the special distribution 
handling on a non-RedHat system.

James Bottomley


