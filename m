Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUJEV7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUJEV7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJEV7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:59:14 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:3083 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266163AbUJEV7E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:59:04 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Date: Wed, 6 Oct 2004 00:58:57 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
In-Reply-To: <20041005185214.GA3691@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> More computing sins are committed in the name of efficiency (without
> necessarily achieving it) than for any other single reason - including
> blind stupidity.
> -- W. A. Wulf 
> 
> Some userspace applications rely on the assumption that fd's 0, 1 and
> 2 are always open and function as raw stdin, stdout and stderr,
> respectively.
> 
> With no console registered, init get's called without those fd's
> already open.  Arguably, init should know better, handle that case and
> fix things before forking other processed.  But what about
> init=/bin/bash?  Ok, bash could be fixed as well, as could...
> 
> Instead, this patch opens /dev/null when /dev/console doesn't work.
> It swallows all output and doesn't give much input, but programs can
> handle that just fine.
> 
> Signed-off-by: JÃrn Engel <joern@wohnheim.fh-wedel.de>
> ---
> 
>  main.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.8cow/init/main.c~console	2004-10-05 20:46:40.000000000 +0200
> +++ linux-2.6.8cow/init/main.c	2004-10-05 20:46:08.000000000 +0200
> @@ -695,8 +695,11 @@
>  	system_state = SYSTEM_RUNNING;
>  	numa_default_policy();
>  
> -	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> +	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0) {
>  		printk("Warning: unable to open an initial console.\n");
> +		if (open("/dev/null", O_RDWR, 0) == 0)
> +			printk("         Falling back to /dev/null.\n");
> +	}

What will happen if /dev is totally empty?
--
vda

