Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQLERa4>; Tue, 5 Dec 2000 12:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLERaq>; Tue, 5 Dec 2000 12:30:46 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:56842 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129210AbQLERae>; Tue, 5 Dec 2000 12:30:34 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Serial Console
Date: 5 Dec 2000 17:00:06 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <90j6um$cji$1@enterprise.cistron.net>
In-Reply-To: <Pine.LNX.4.30.0012051506030.31704-100000@rossi.itg.ie> <200012051625.RAA02860@cave.bitwizard.nl>
X-Trace: enterprise.cistron.net 976035606 12914 195.64.65.201 (5 Dec 2000 17:00:06 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200012051625.RAA02860@cave.bitwizard.nl>,
Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:
>Paul Jakma wrote:
>> perhaps linux-mips is just different? or i386 serial-console is
>> incorrect?
>
>No. serial console on i386 doesn't and should not block. 
>We're constantly using serial consoles here, so I really think I've 
>seen this work... .

It can block.

Funny, no message on this list has been quite right ;)

/dev/console can block
/dev/ttyS0   can block
printk()     never blocks

init(8) reads the tty settings from /etc/ioctl.save at startup.
After it leaves single user mode it writes that file again. So
mods made in single user mode are saved to /etc/ioctl.save.
Every time init executes a program, it restores the console
settings to those from /etc/ioctl.save.
[Perhaps I should rip that stuff out]

However a getty on /dev/ttyS0 which you usually have running in
runlevels [12345789] can change the tty settings and they will
take effect immidiately. So if you run a getty that turns on
hardware handshaking (like mgetty) - you're fscked.

The only things in which /dev/console is special are:

- it's an alias for the current console
- it's always opened with O_NOCTTY

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
