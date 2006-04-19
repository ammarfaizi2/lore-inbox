Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWDSJfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWDSJfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDSJfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:35:19 -0400
Received: from av1.karneval.cz ([81.27.192.107]:58555 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1750831AbWDSJfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:35:17 -0400
Message-ID: <4446045E.7070208@gmail.com>
Date: Wed, 19 Apr 2006 11:35:26 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Thayumanavar Sachithanantham <thayumk@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, info-linux@geode.amd.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: [PATCH]drivers/char/cs5535_gpio.c:call cdev_del during module_exit
 to unmap kobject references and other cleanups.
References: <3b8510d80604182352v11fea186lde1b9987447a3318@mail.gmail.com>	 <20060419001547.320684bf.akpm@osdl.org> <3b8510d80604190051v78c8757fibd30a5abf3efa24f@mail.gmail.com>
In-Reply-To: <3b8510d80604190051v78c8757fibd30a5abf3efa24f@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thayumanavar Sachithanantham napsal(a):
> During module unloading, cdev_del be called to unmap cdev related
> kobject references and other cleanups(such as inode->i_cdev being set
> to NULL) which prevents the OOPS upon subsequent loading ,usage and
> unloading of modules(as seen in the mail thread:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114533640609018&w=2).
> 
> Removed test of gpio_base as it is unneeded and will not be zero at
> module unload time.
> 
> Signed-off-by: Thayumanavar Sachithanantham <thayumk@gmail.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> --- linux-2.6/drivers/char/cs5535_gpio.c.orig	2006-04-17
> 21:37:25.000000000 -0700
> +++ linux-2.6/drivers/char/cs5535_gpio.c	2006-04-17 23:05:49.000000000 -0700
> @@ -241,9 +241,9 @@ static int __init cs5535_gpio_init(void)
>  static void __exit cs5535_gpio_cleanup(void)
>  {
>  	dev_t dev_id = MKDEV(major, 0);
> +        cdev_del(&cs5535_gpio_cdev);
Spaces, again.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFERgReMsxVwznUen4RArG+AKCBJTe9mOLLXXHPyrzpt3Fm52ZA2gCcCcL3
duNa3zAPb2D0u/z8oWvvh+8=
=atPm
-----END PGP SIGNATURE-----
