Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRBYRzk>; Sun, 25 Feb 2001 12:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRBYRzb>; Sun, 25 Feb 2001 12:55:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129444AbRBYRzW>; Sun, 25 Feb 2001 12:55:22 -0500
Subject: Re: [PATCH] 2.4.x kernel keyboard fix for Digital HiNote Ultra 2000
To: mark@cleggies.freeserve.co.uk (Mark Clegg)
Date: Sun, 25 Feb 2001 17:57:50 +0000 (GMT)
Cc: rubini@vision.unipv.it, linux-kernel@vger.kernel.org
In-Reply-To: <3A98F047.733D7131@cleggies.freeserve.co.uk> from "Mark Clegg" at Feb 25, 2001 11:45:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X5Qf-0003jD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/pc_keyb.c related to fixing problems on a Toshiba 4030cdt.
> It would appear that the fix for the Tosh, breaks the HiNote. (I don't
> have a Tosh to experiment with).

Reading the pc_keyb.c code two things strike me. The first is to wonder how
the hell Linus let that code get submitted ;) and the second is that the
delay rules are totally violated, and thats something we know the hinote's
hate.

> --- drivers/char/pc_keyb.c.orig Sat Feb 24 20:01:46 2001
> +++ drivers/char/pc_keyb.c      Sat Feb 24 20:02:03 2001
> @@ -909,7 +909,7 @@
>         aux_write_ack(AUX_ENABLE_DEV); /* Enable aux device */
>         kbd_write_cmd(AUX_INTS_ON); /* Enable controller ints */
> 
> -       send_data(KBD_CMD_ENABLE);      /* try to workaround
> toshiba4030cdt problem */
> +//     send_data(KBD_CMD_ENABLE);      /* try to workaround
> toshiba4030cdt problem */

Instead of commenting it put

	mdelay(1);

before and after, and let me know if that helps

Alan

