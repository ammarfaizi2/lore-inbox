Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbRG3PeM>; Mon, 30 Jul 2001 11:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268946AbRG3PeA>; Mon, 30 Jul 2001 11:34:00 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:10513 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S268958AbRG3Pdp>; Mon, 30 Jul 2001 11:33:45 -0400
Date: Mon, 30 Jul 2001 17:33:46 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: baettig@scs.ch
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: serial console and kernel 2.4
Message-ID: <20010730173346.A19605@pc8.lineo.fr>
In-Reply-To: <20010730165453.A19255@pc8.lineo.fr> <200107301518.f6UFICd25941@rage.scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <200107301518.f6UFICd25941@rage.scs.ch>; from baettig@scs.ch on lun, jui 30, 2001 at 17:18:12 +0200
X-Mailer: Balsa 1.1.7-cvs20010726
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thank you very much.
It solves my problem.
I'm going to look in it to understand what is CREAD.
certainly a patch need to be proposed here.

Christophe

Le lun, 30 jui 2001 17:18:12, baettig@scs.ch a écrit :
> Hi! 
> 
> I had the same problem and I attached you a patch how I'm working
> around this problem.
> 
> 	Reto
> 
> --- drivers/char/serial.c.orig  Thu May  3 09:29:00 2001
> +++ drivers/char/serial.c       Thu May  3 09:29:34 2001
> @@ -1764,8 +1764,8 @@
>         /*
>          * !!! ignore all characters if CREAD is not set
>          */
> -       if ((cflag & CREAD) == 0)
> -               info->ignore_status_mask |= UART_LSR_DR;
> +//     if ((cflag & CREAD) == 0)
> +//             info->ignore_status_mask |= UART_LSR_DR;
>         save_flags(flags); cli();
>         if (uart_config[info->state->type].flags & UART_STARTECH) {
>                 serial_outp(info, UART_LCR, 0xBF);
> 
> > 
> > I recently upgraded a linux box to the kernel 2.4.4 (from 2.2.18). This
> box
> > has no display and use the serial console. Since the upgrade I can see
> the
> > boot output on the remote console but I can't use the keyboard. Each
> time I
> > press a key, an interrupt is seen by the no-display machine but no char
> > appears in the console. 
> > Today I've upgraded an another box to 2.4.7 with a similar setup and
> I've
> > the same problem.
> > 
> > Is there something that I'm missing ? (something new with the kernel
> 2.4
> > that is required for a serial console that was not required with the
> 2.2 ?)
> > 
> > Is sombody else experienciong the same problem ?
> > 
> > Christophe
> > 
> > 
> > -- 
> > Christophe Barbé
> > Software Engineer - christophe.barbe@lineo.fr
> > Lineo France - Lineo High Availability Group
> > 42-46, rue Médéric - 92110 Clichy - France
> > phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
> > http://www.lineo.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
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
