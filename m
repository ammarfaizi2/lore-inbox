Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUJFRmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUJFRmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUJFRmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:42:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:28338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269286AbUJFRmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:42:11 -0400
Date: Wed, 6 Oct 2004 10:38:23 -0700
From: Greg KH <greg@kroah.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006173823.GA26740@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005185214.GA3691@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 08:52:14PM +0200, J?rn Engel wrote:
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

Your printk() calls need the proper KERN_* level.

And what happens if you can't open /dev/null?  (hint, udev enabled boxes
usually do not have a /dev/null this early in the boot process).  Does
this mean we should add a /dev/null to the initramfs image, like the
/dev/console node we currently have there?

thanks,

greg k-h
