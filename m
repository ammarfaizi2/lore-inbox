Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSJ3AdJ>; Tue, 29 Oct 2002 19:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSJ3AdJ>; Tue, 29 Oct 2002 19:33:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46351 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262498AbSJ3AdI>; Tue, 29 Oct 2002 19:33:08 -0500
Date: Tue, 29 Oct 2002 16:39:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp from eating disks
In-Reply-To: <20021029231402.GA134@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0210291637440.1205-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Oct 2002, Pavel Machek wrote:
> 
> Patrick broke IDE so it wanted to eat data, again. Fixed, please
> apply,

This is too ugly for words.

> --- clean/drivers/ide/ide-disk.c	2002-10-18 23:41:15.000000000 +0200
> +++ linux-swsusp/drivers/ide/ide-disk.c	2002-10-21 14:36:36.000000000 +0200
> @@ -1891,8 +1891,10 @@
>  
>  static int idedisk_init (void)
>  {
> -	ide_register_driver(&idedisk_driver);
> -	return 0;
> +	int status = ide_register_driver(&idedisk_driver);
> +	idedisk_driver.gen_driver.suspend = idedisk_suspend;
> +	idedisk_driver.gen_driver.resume = idedisk_resume;
> +	return status;
>  }

Why aren't those fields initialized explicitly in the static declaration
of idedisk_driver? And what are the do_idedisk_suspend/do_idedisk_resume
functions, that _are_ initialized explicitly?

I want to understand the madness, not add to it.

		Linus

