Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVD2Opy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVD2Opy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVD2OpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:45:07 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:31889 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262762AbVD2Ooh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:44:37 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
From: Alexander Nyberg <alexn@telia.com>
To: Andi Kleen <ak@suse.de>
Cc: Ruben Puettmann <ruben@puettmann.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org
In-Reply-To: <20050429143215.GE21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net>
	 <1114769162.874.4.camel@localhost.localdomain>
	 <20050429143215.GE21080@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:44:27 +0200
Message-Id: <1114785867.497.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm? saved_command_Line should have enough space to add a simple string.
> It is a 1024bytes. Unless you already have a 1k command line it should
> be quite ok.

init/main.c:
char saved_command_line[COMMAND_LINE_SIZE];

inclide/asm-x86-64/setup.h:
#define COMMAND_LINE_SIZE	256

Rubens command line is a total of 251 chars, adding "console=tty0" will
exceed it.

> Why do you think it is bogus?
> 

I thought that saved_command_line on x64 was like the other archs, an
untouched copy and it wouldn't have made sense to apply another string
to it then, but I was wrong as it is the working line.

I still don't understand why console=tty0 is to be appended however.

> > This is bogus appending stuff to the saved_command_line and at the same
> > time in Rubens case it touches the late_time_init() which breakes havoc.
> 
> I dont agree with this patch.
> 
> -Andi
> 
> > 
> > Signed-off-by: Alexander Nyberg <alexn@telia.com>
> > 
> > Index: linux-2.6/arch/x86_64/kernel/head64.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
> > +++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
> > @@ -93,9 +93,6 @@
> >  #ifdef CONFIG_SMP
> >  	cpu_set(0, cpu_online_map);
> >  #endif
> > -	/* default console: */
> > -	if (!strstr(saved_command_line, "console="))
> > -		strcat(saved_command_line, " console=tty0"); 
> >  	s = strstr(saved_command_line, "earlyprintk=");
> >  	if (s != NULL)
> >  		setup_early_printk(s);
> > 
> > 
-- 
Alexander Nyberg <alexn@telia.com>

