Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVD2KMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVD2KMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVD2KMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:12:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:59048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262264AbVD2KLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:11:46 -0400
Date: Fri, 29 Apr 2005 03:10:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: ruben@puettmann.net, linux-kernel@vger.kernel.org, rddunlap@osdl.org,
       ak@suse.de
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-Id: <20050429031027.62d17bfa.akpm@osdl.org>
In-Reply-To: <1114769162.874.4.camel@localhost.localdomain>
References: <20050427140342.GG10685@puettmann.net>
	<1114769162.874.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> >                                                                                                            
> > I'm trying to install linux on an HP DL385 but directly on boot I got                                           
> > this kernel panic:
> > 
> >         http://www.puettmann.net/temp/panic.jpg
> 
> 
> This is bogus appending stuff to the saved_command_line and at the same
> time in Rubens case it touches the late_time_init() which breakes havoc.

-ETOOTERSE.  Do you meen that the user's command line was so long that this
strcat wandered off the end of the buffer and corrupted late_time_init?


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

Wasn't that code there for a reason?

