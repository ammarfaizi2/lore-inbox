Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUILNsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUILNsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUILNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:48:16 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:11276 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S268724AbUILNsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:48:08 -0400
Date: Sun, 12 Sep 2004 15:44:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.28-pre3] I2C driver core gcc-3.4 fixes
Message-Id: <20040912154429.0f9b228b.khali@linux-fr.org>
In-Reply-To: <200409121125.i8CBPUNI015192@harpo.it.uu.se>
References: <200409121125.i8CBPUNI015192@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
> kernel's I2C driver core. The i2c-core.c change is from the 2.6
> kernel, the i2c-proc.c changes are new since the 2.6 code is
> different.
> (...)
> --- linux-2.4.28-pre3/drivers/i2c/i2c-proc.c.~1~	2004-02-18 15:16:22.000000000 +0100
> +++ linux-2.4.28-pre3/drivers/i2c/i2c-proc.c	2004-09-12 01:56:20.000000000 +0200
> (...)
> @@ -287,7 +287,7 @@
>  			if(copy_to_user(buffer, BUF, buflen))
>  				return -EFAULT;
>  			curbufsize += buflen;
> -			(char *) buffer += buflen;
> +			buffer += buflen;
>  		}
>  	*lenp = curbufsize;
>  	filp->f_pos += curbufsize;

Looks like arithmetics on void* to me, so while removing a warning you
add a different one. Same for all other "fixes" later in the patch.

It doesn't look to me like you are fixing the code, only hiding the
warnings. I am not really confident you aren't breaking things while
doing this.

After a quick look at the code I'd say that the buffer-like parameters
involved should be declared as char* instead of void* in the first
place, which would effectively make all further casts unnecessary, and
still work exactly as before.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
