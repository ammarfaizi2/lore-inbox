Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268986AbRG3Ph3>; Mon, 30 Jul 2001 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268983AbRG3PhT>; Mon, 30 Jul 2001 11:37:19 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:11793 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S268982AbRG3PhD>; Mon, 30 Jul 2001 11:37:03 -0400
Date: Mon, 30 Jul 2001 17:37:02 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: serial console and kernel 2.4
Message-ID: <20010730173702.C19605@pc8.lineo.fr>
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain>; from James.Bottomley@SteelEye.com on lun, jui 30, 2001 at 17:20:55 +0200
X-Mailer: Balsa 1.1.7-cvs20010726
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"it works for me" is better that no answer for me. So Thank you for your
answer.
Reto give me a solution : because of a flag all incomming char are ignored.
So now I need to find why this flag is ok for you and not for me.

Christophe


Le lun, 30 jui 2001 17:20:55, James Bottomley a écrit :
> > I recently upgraded a linux box to the kernel 2.4.4 (from 2.2.18).
> > This box has no display and use the serial console. Since the upgrade
> > I can see the boot output on the remote console but I can't use the
> > keyboard. Each time I press a key, an interrupt is seen by the
> > no-display machine but no char appears in the console.  Today I've
> > upgraded an another box to 2.4.7 with a similar setup and I've the
> > same problem.
> 
> > Is there something that I'm missing ? (something new with the kernel
> > 2.4 that is required for a serial console that was not required with
> > the 2.2 ?)
> 
> I hate to send an email which says "it works for me", but it does (all
> the way 
> up to 2.4.7).
> 
> However, one of the things to remember about the serial console is that
> it is 
> primarily designed for *output*.  If you see the boot messages, then it's
> 
> doing its job correctly.  Things like kdb and sysrq can accept input from
> the 
> serial console, but usually only if something else (like getty) has
> opened it 
> first.
> 
> My setup (on RedHat 7.1) looks like this
> 
> In /etc/lilo.conf
> 
> # make lilo output to serial console
> serial=0,9600n8
> 
> # for each kernel add this line
>         append="console=ttyS0,9600n8 console=tty0"
> 
> Note, the above append causes /dev/console to be /dev/tty0 (the virtual 
> console).  If you want to see all the boot messages you need /dev/ttyS0
> to be 
> /dev/console and you should reverse the two console statements in this
> line.
> 
> In /etc/inittab:
> 
> S:0123456:respawn:/sbin/mingetty --noclear ttyS0
> 
> With this setup I can activate sysrq and kdb from the serial console.
> 
> Note also that different distributions have different ways of handling
> the 
> system console; you might also have to disable the special distribution 
> handling on a non-RedHat system.
> 
> James Bottomley
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
