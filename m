Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289950AbSAPOa0>; Wed, 16 Jan 2002 09:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289952AbSAPOaR>; Wed, 16 Jan 2002 09:30:17 -0500
Received: from mail2.alcatel.fr ([212.208.74.132]:43500 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S289950AbSAPOaA> convert rfc822-to-8bit;
	Wed, 16 Jan 2002 09:30:00 -0500
Message-ID: <3C458E61.DE349425@col.bsf.alcatel.fr>
Date: Wed, 16 Jan 2002 15:29:53 +0100
From: Eric Lamarque <eric.lamarque@col.bsf.alcatel.fr>
Organization: Alcatel Business System France
X-Mailer: Mozilla 4.7 [en] (X11; I; SunOS 5.8 sun4u)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: serial console and kernel 2.4
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: christophe barbé (christophe.barbe@lineo.fr)
Date: Mon Jul 30 2001 - 09:54:53 EST 
> I recently upgraded a linux box to the kernel 2.4.4 .
> Since the upgrade I can see the boot output on the remote console
> but I can't use the keyboard

It seems that I experiment the same problem: I've some Compaq machine
that I control remotely with the serial console.

It always runs 2.4.x kernel and all runs fine.

I just replace the machine by a newer one and experiment the same problem
as you. It seems to me that Linux send CTRL-S on the serial line.

To check that this is the real problem, I use rlogin to access the machine
and send CTRL-Q to the Linux console: it does the trick.
( # echo -e "\021" > /dev/console )

I trace the problem to be the arch/i386/kernel/dmi_scan.c function:
DMI is a set of structures to get information about the machine.
It is the one that print "Board Version:.." at boot time.

I'll check at http://www.ibm.com/products/surepath/other/smbios.html to
know the type of such data. "Board Version" must be a string (I assume with
printable character).

My problem is that "Board Version" is printed as "Board Version: 0x14 0x13 *."
where 0x13 is CTRL-S.

Does the kernel contains a mechanism to avoid console printing of DMI information?
(If not, we could maybe add it in function dmi_scan.c:dmi_save_ident()).

Eric.
