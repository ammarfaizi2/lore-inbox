Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTI2RB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbTI2RB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:01:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:39556 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263782AbTI2RB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:01:57 -0400
Date: Mon, 29 Sep 2003 09:57:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Pavel Machek <pavel@ucw.cz>
cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Make software resume be called at resume
In-Reply-To: <20030928222404.GA227@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309290955050.968-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [Yes, software_suspend needs to return int and do some error
> handling. But not today, and this is better than random bit flips.]

Random bit flips? I have no idea what you're talking about. 

> --- clean/kernel/power/swsusp.c	2003-09-28 22:06:45.000000000 +0200
> +++ linux/kernel/power/swsusp.c	2003-09-29 00:19:37.000000000 +0200
> @@ -5,7 +5,10 @@
>   * machine suspend feature using pretty near only high-level routines
>   *
>   * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
> - * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
> + * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
> + * Copyright (C) 2003 Patrick Mochel <mochel@osdl.org>

Please remove this. I want as little correlation between my name and 
swsusp as possible. 

>  static void do_software_suspend(void)
>  {
> -	arch_prepare_suspend();
> +	if (arch_prepare_suspend())
> +		panic("Architecture failed to prepare\n");

For crying out loud, why? WTF is wrong with:


		printk("Architecture failed to prepare\n");
		return;

? Why do that to your users? 



	Pat

