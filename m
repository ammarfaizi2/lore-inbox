Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUJEXai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUJEXai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJEXaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:30:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:16064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266324AbUJEX1I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:27:08 -0400
Date: Tue, 5 Oct 2004 16:30:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
Message-Id: <20041005163052.305f0d88.akpm@osdl.org>
In-Reply-To: <20041005185214.GA3691@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
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
>  
>  	(void) sys_dup(0);
>  	(void) sys_dup(0);

/usr/src/25/init/main.c:183: undefined reference to `open'

I assume this worked for you because it's against 2.6.8 and we were still
supporting kernel syscalls then.

Please always test patches against current kernels.

I'll fix it up.
