Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282948AbRLDJZO>; Tue, 4 Dec 2001 04:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282958AbRLDJY6>; Tue, 4 Dec 2001 04:24:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42256 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283000AbRLDJYs>; Tue, 4 Dec 2001 04:24:48 -0500
Subject: Re: [PATCH] 2.4.16: kmalloc tidying
To: ragnar@ragnar-hojland.com (Ragnar Hojland Espinosa)
Date: Tue, 4 Dec 2001 09:33:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011203193751.A10125@ragnar-hojland.com> from "Ragnar Hojland Espinosa" at Dec 03, 2001 07:37:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BBxS-0001Pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ linux-2.4.16/drivers/sbus/char/envctrl.c	Tue Nov 13 05:31:02 2001
> @@ -897,10 +897,6 @@ static void envctrl_init_i2c_child(struc
>  		}
> =20
>                  pchild->tables =3D kmalloc(tbls_size, GFP_KERNEL);
> -		if (!pchild->tables) {
> -			printk("envctrl: Failed to get table, not enough memory.\n");

Why are you removing the checks here ?

>  	current->mm->rss =3D 0;
> -	setup_arg_pages(bprm); /* XXX: check error */
> +	retval =3D setup_arg_pages(bprm);
> +	if (retval)=20
> +		goto out_free_dentry;

At this point you need to do more drastic things - see the last -ac patch
for a possible solution
