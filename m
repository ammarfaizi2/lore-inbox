Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268889AbRG3PNa>; Mon, 30 Jul 2001 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268894AbRG3PNU>; Mon, 30 Jul 2001 11:13:20 -0400
Received: from mail.scs.ch ([212.254.229.5]:59398 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S268889AbRG3PNG>;
	Mon, 30 Jul 2001 11:13:06 -0400
Message-Id: <200107301518.f6UFICd25941@rage.scs.ch>
Subject: Re: serial console and kernel 2.4
To: christophe.barbe@lineo.fr (christophe =?iso-8859-1?Q?barb=E9?=)
Date: Mon, 30 Jul 2001 17:18:12 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20010730165453.A19255@pc8.lineo.fr> from "christophe =?iso-8859-1?Q?barb=E9?=" at Jul 30, 2001 04:54:53 PM
From: baettig@scs.ch
Reply-To: baettig@scs.ch
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi! 

I had the same problem and I attached you a patch how I'm working
around this problem.

	Reto

--- drivers/char/serial.c.orig  Thu May  3 09:29:00 2001
+++ drivers/char/serial.c       Thu May  3 09:29:34 2001
@@ -1764,8 +1764,8 @@
        /*
         * !!! ignore all characters if CREAD is not set
         */
-       if ((cflag & CREAD) == 0)
-               info->ignore_status_mask |= UART_LSR_DR;
+//     if ((cflag & CREAD) == 0)
+//             info->ignore_status_mask |= UART_LSR_DR;
        save_flags(flags); cli();
        if (uart_config[info->state->type].flags & UART_STARTECH) {
                serial_outp(info, UART_LCR, 0xBF);

> 
> I recently upgraded a linux box to the kernel 2.4.4 (from 2.2.18). This box
> has no display and use the serial console. Since the upgrade I can see the
> boot output on the remote console but I can't use the keyboard. Each time I
> press a key, an interrupt is seen by the no-display machine but no char
> appears in the console. 
> Today I've upgraded an another box to 2.4.7 with a similar setup and I've
> the same problem.
> 
> Is there something that I'm missing ? (something new with the kernel 2.4
> that is required for a serial console that was not required with the 2.2 ?)
> 
> Is sombody else experienciong the same problem ?
> 
> Christophe
> 
> 
> -- 
> Christophe Barbé
> Software Engineer - christophe.barbe@lineo.fr
> Lineo France - Lineo High Availability Group
> 42-46, rue Médéric - 92110 Clichy - France
> phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
> http://www.lineo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

