Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUKETYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUKETYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKETYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:24:47 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:25198 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261168AbUKETYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:24:45 -0500
Date: Fri, 5 Nov 2004 21:26:01 +0100
From: Sam Ravnborg <sam@mars.opasia.dk>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3: (fix for make xconfig)
Message-ID: <20041105202601.GA8785@mars.opasia.dk>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051907.19008.rjw@sisk.pl> <200411051948.32936.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411051948.32936.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 07:48:32PM +0100, Rafael J. Wysocki wrote:
> >   HOSTCXX scripts/kconfig/qconf.o
> >   HOSTLD  scripts/kconfig/qconf
> > scripts/kconfig/qconf arch/x86_64/Kconfig
> > ./scripts/kconfig/libkconfig.so: cannot open shared object file: No such 
> file 
> > or directory
> > make[1]: *** [xconfig] Error 1
> > make: *** [xconfig] Error 2
> 
> I did this to fix it:
> 
> --- scripts/kconfig/Makefile.orig	2004-11-05 19:16:23.000000000 +0100
> +++ scripts/kconfig/Makefile	2004-11-05 19:18:08.000000000 +0100
> @@ -70,9 +70,11 @@
>  #         Based on GTK which needs to be installed to compile it
>  # object files used by all kconfig flavours
>  
> +libkconfig-objs := zconf.tab.o
> +
>  hostprogs-y	:= conf mconf qconf gconf
> -conf-objs	:= conf.o  zconf.tab.o
> -mconf-objs	:= mconf.o zconf.tab.o
> +conf-objs	:= conf.o  libkconfig.so
> +mconf-objs	:= mconf.o libkconfig.so
>  
>  ifeq ($(MAKECMDGOALS),xconfig)
>  	qconf-target := 1

Wrong fix.
I will look into it later tonight.

	Sam
