Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262257AbRENHCx>; Mon, 14 May 2001 03:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbRENHCm>; Mon, 14 May 2001 03:02:42 -0400
Received: from mail.scs.ch ([212.254.229.5]:35088 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S262257AbRENHCc>;
	Mon, 14 May 2001 03:02:32 -0400
Message-ID: <3AFF8405.D2F5F74F@scs.ch>
Date: Mon, 14 May 2001 09:06:45 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Konstantin Boldyshev <konst@linuxassembly.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: serial console broken in 2.4.4?
In-Reply-To: <Pine.LNX.4.33L.0105111659530.536-100000@alpha.linuxassembly.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a real patch but it works fine for me:

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

This stuff got changed between 2.4.3 and 2.4.4 but I don't know why and
it broke my serial console. Please let me know when you know the "real"
fix for this problem.

	Reto

Konstantin Boldyshev wrote:
> 
> Hello,
> 
> I have noticed strange serial console behaviour in 2.4.4.
> I have system with gettys on ttyS0 and tty1.
> When I boot with usual console (set to tty1), getty on ttyS0 works.
> When I boot with console set to ttyS0 ("console=ttyS0,9600n8"),
> getty on ttyS0 doesnot respond on input (although ps shows it running);
> all kernel messages are showed on ttyS0, but it seems that _input_ is
> disallowed/broken. Things were okay somewhere around (AFAIR) 2.4.0pre..
> Is this a known 2.4 bug? Any patch to fix this?
> 
> --
> Regards,
> Konstantin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
