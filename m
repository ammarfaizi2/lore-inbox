Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSHSMcj>; Mon, 19 Aug 2002 08:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318744AbSHSMcj>; Mon, 19 Aug 2002 08:32:39 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:28379 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S318742AbSHSMci>;
	Mon, 19 Aug 2002 08:32:38 -0400
Date: Mon, 19 Aug 2002 14:36:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org
Subject: Re: Little console problem in 2.5.30
In-Reply-To: <20020819023731.C316@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.4.21.0208191433430.23654-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Pete Zaitcev wrote:
> I would appreciate if someone would explain me if the attached patch
> does the right thing. The problem is that I do not use the framebuffer,
> and use a serial console. Whenever a legacy /sbin/init tries to
> open /dev/tty0, the system oopses dereferencing conswitchp in
> visual_init().

And this worked before?

conswitchp must never be NULL, say `conswitchp = &dummy_con;' in your setup.c
if you have a serial console.

>From looking at arch/sparc/kernel/setup.c, perhaps you have
CONFIG_DUMMY_CONSOLE=n?

> -- Pete
> 
> diff -ur -X dontdiff linux-2.5.30-sp_pbk/drivers/char/console.c linux-2.5.30-sparc/drivers/char/console.c
> --- linux-2.5.30-sp_pbk/drivers/char/console.c	Thu Aug  1 14:16:34 2002
> +++ linux-2.5.30-sparc/drivers/char/console.c	Sun Aug 18 23:14:20 2002
> @@ -652,7 +652,7 @@
>  
>  int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  {
> -	if (currcons >= MAX_NR_CONSOLES)
> +	if (currcons >= MAX_NR_CONSOLES || conswitchp == NULL)
>  		return -ENXIO;
>  	if (!vc_cons[currcons].d) {
>  	    long p, q;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

