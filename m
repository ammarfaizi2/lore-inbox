Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318903AbSH1S74>; Wed, 28 Aug 2002 14:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318905AbSH1S74>; Wed, 28 Aug 2002 14:59:56 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:25335 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318903AbSH1S7z>; Wed, 28 Aug 2002 14:59:55 -0400
Date: Wed, 28 Aug 2002 11:58:07 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: David Gibson <david@gibson.dropbear.id.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL] Compile fix for magic sysrq and !CONFIG_VT
In-Reply-To: <20020827020855.GW18818@zax>
Message-ID: <Pine.LNX.4.33.0208281153290.1459-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus, please apply.  This fixes compilation of the magic sysrq code
> when compiled without CONFIG_VT.

Ug. I have had this fix for awhile in the console BK tree. That and
several other ones. I'm merging my tree with 2.5.32 right now and I will
push it to linus as soon as I'm done tetsing.


> diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/char/sysrq.c linux-bluefish/drivers/char/sysrq.c
> --- /home/dgibson/kernel/linuxppc-2.5/drivers/char/sysrq.c	2002-07-16 09:13:58.000000000 +1000
> +++ linux-bluefish/drivers/char/sysrq.c	2002-08-02 16:36:30.000000000 +1000
> @@ -76,7 +76,7 @@
>  };
>  #endif
>
> -
> +#ifdef CONFIG_VT
>  /* unraw sysrq handler */
>  static void sysrq_handle_unraw(int key, struct pt_regs *pt_regs,
>  			       struct tty_struct *tty)
> @@ -91,7 +91,7 @@
>  	help_msg:	"unRaw",
>  	action_msg:	"Keyboard mode set to XLATE",
>  };
> -
> +#endif /* CONFIG_VT */
>
>  /* reboot sysrq handler */
>  static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
> @@ -371,7 +371,11 @@
>  		 as 'Off' at init time */
>  /* p */	&sysrq_showregs_op,
>  /* q */	NULL,
> +#ifdef CONFIG_VT
>  /* r */	&sysrq_unraw_op,
> +#else
> +/* r */ NULL,
> +#endif
>  /* s */	&sysrq_sync_op,
>  /* t */	&sysrq_showstate_op,
>  /* u */	&sysrq_mountro_op,
>
>
> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.
> http://www.ozlabs.org/people/dgibson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

