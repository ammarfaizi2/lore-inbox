Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130166AbRBZUpa>; Mon, 26 Feb 2001 15:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130221AbRBZUpU>; Mon, 26 Feb 2001 15:45:20 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:35161 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130166AbRBZUpG>; Mon, 26 Feb 2001 15:45:06 -0500
Message-ID: <3A9AC033.9A2EA1F6@cleggies.freeserve.co.uk>
Date: Mon, 26 Feb 2001 20:44:35 +0000
From: Mark Clegg <mark@cleggies.freeserve.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: rubini@vision.unipv.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x kernel keyboard fix for Digital HiNote Ultra 2000
In-Reply-To: <E14X5Qf-0003jD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried adding mdelay(1) before and after but
this doesn't help. However, increasing the delay
does, and the minimum I've got to work is mdelay(2)
before, with no delay afterwards. I don't know what
the delay rules for the controller are, so it may
be necessary to add one afterwards as well. It
certainly doesn't seem to hurt the HiNote whether
there is or not.

Regards
Mark

Revised patch....

--- drivers/char/pc_keyb.c.orig Mon Feb 26 20:22:45 2001
+++ drivers/char/pc_keyb.c      Mon Feb 26 20:15:48 2001
@@ -909,6 +909,7 @@
        aux_write_ack(AUX_ENABLE_DEV); /* Enable aux device */
        kbd_write_cmd(AUX_INTS_ON); /* Enable controller ints */

+       mdelay(2);
        send_data(KBD_CMD_ENABLE);      /* try to workaround toshiba4030cdt
problem */

        return 0;

Akan Cox wrote.

> > drivers/char/pc_keyb.c related to fixing problems on a Toshiba 4030cdt.
> > It would appear that the fix for the Tosh, breaks the HiNote. (I don't
> > have a Tosh to experiment with).
>
> Reading the pc_keyb.c code two things strike me. The first is to wonder how
> the hell Linus let that code get submitted ;) and the second is that the
> delay rules are totally violated, and thats something we know the hinote's
> hate.
>
> > --- drivers/char/pc_keyb.c.orig Sat Feb 24 20:01:46 2001
> > +++ drivers/char/pc_keyb.c      Sat Feb 24 20:02:03 2001
> > @@ -909,7 +909,7 @@
> >         aux_write_ack(AUX_ENABLE_DEV); /* Enable aux device */
> >         kbd_write_cmd(AUX_INTS_ON); /* Enable controller ints */
> >
> > -       send_data(KBD_CMD_ENABLE);      /* try to workaround
> > toshiba4030cdt problem */
> > +//     send_data(KBD_CMD_ENABLE);      /* try to workaround
> > toshiba4030cdt problem */
>
> Instead of commenting it put
>
>         mdelay(1);
>
> before and after, and let me know if that helps
>
> Alan

--
+-------------------------------------------------------------------+
| Mark Clegg                           www.cleggies.freeserve.co.uk |
| 38th Rossendale (Open) Scout Group          www.the38thrsg.org.uk |
+-------------------------------------------------------------------+



