Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVD2OcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVD2OcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVD2OcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:41688 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262723AbVD2OcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:32:16 -0400
Date: Fri, 29 Apr 2005 16:32:15 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Ruben Puettmann <ruben@puettmann.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org, ak@suse.de
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429143215.GE21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114769162.874.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 12:06:02PM +0200, Alexander Nyberg wrote:
> >                                                                                                            
> > I'm trying to install linux on an HP DL385 but directly on boot I got                                           
> > this kernel panic:
> > 
> >         http://www.puettmann.net/temp/panic.jpg
> 
> 

Hmm? saved_command_Line should have enough space to add a simple string.
It is a 1024bytes. Unless you already have a 1k command line it should
be quite ok.

Why do you think it is bogus?

> This is bogus appending stuff to the saved_command_line and at the same
> time in Rubens case it touches the late_time_init() which breakes havoc.

I dont agree with this patch.

-Andi

> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: linux-2.6/arch/x86_64/kernel/head64.c
> ===================================================================
> --- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
> +++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
> @@ -93,9 +93,6 @@
>  #ifdef CONFIG_SMP
>  	cpu_set(0, cpu_online_map);
>  #endif
> -	/* default console: */
> -	if (!strstr(saved_command_line, "console="))
> -		strcat(saved_command_line, " console=tty0"); 
>  	s = strstr(saved_command_line, "earlyprintk=");
>  	if (s != NULL)
>  		setup_early_printk(s);
> 
> 
