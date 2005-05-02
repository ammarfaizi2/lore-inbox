Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVEBQtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVEBQtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVEBQqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:46:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:52407 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261516AbVEBQmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:42:53 -0400
Date: Mon, 2 May 2005 18:42:43 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Andi Kleen <ak@suse.de>, Ruben Puettmann <ruben@puettmann.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050502164243.GH7342@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain> <20050429143215.GE21080@wotan.suse.de> <20050429144103.GK18972@puettmann.net> <20050429144501.GH21080@wotan.suse.de> <1114805516.7659.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114805516.7659.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:11:56PM +0200, Alexander Nyberg wrote:
> > Ok. If you really had such a overlong command line it is ok.
> > 
> > We should probably check this condition better too and error out.
> > 
> 
> How about something like this then (I was thinking making it a panic but
> not sure). I think it's a good idea to give some kind of indication so
> that there is at least some message when the user discovers that some
> things specified on cmdline don't start/work.

Looks good.  Thanks.

At some point should also figure out how to make it bigger.
I tried it once, but it broke lilo with EDID.

-Andi

> 
> 
> Check if the user specified a too long kernel command line and warn
> about it being truncated. 
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: linux-2.6/init/main.c
> ===================================================================
> --- linux-2.6.orig/init/main.c	2005-04-26 11:41:57.000000000 +0200
> +++ linux-2.6/init/main.c	2005-04-29 20:28:44.000000000 +0200
> @@ -456,6 +456,8 @@
>  	build_all_zonelists();
>  	page_alloc_init();
>  	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
> +	if (strlen(saved_command_line) == COMMAND_LINE_SIZE-1)
> +		printk(KERN_ALERT "WARNING: Too long command line! Truncated.\n");
>  	parse_early_param();
>  	parse_args("Booting kernel", command_line, __start___param,
>  		   __stop___param - __start___param,
> 
> 
> 
> 
