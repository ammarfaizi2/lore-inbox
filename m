Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVD2Ogx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVD2Ogx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVD2OgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:36:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:16346 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262751AbVD2Oeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:34:50 -0400
Date: Fri, 29 Apr 2005 16:34:50 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, ruben@puettmann.net,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org, ak@suse.de
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429143450.GF21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain> <20050429031027.62d17bfa.akpm@osdl.org> <1114775159.497.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114775159.497.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 01:45:59PM +0200, Alexander Nyberg wrote:
> fre 2005-04-29 klockan 03:10 -0700 skrev Andrew Morton:
> > Alexander Nyberg <alexn@telia.com> wrote:
> > >
> > > >                                                                                                            
> > > > I'm trying to install linux on an HP DL385 but directly on boot I got                                           
> > > > this kernel panic:
> > > > 
> > > >         http://www.puettmann.net/temp/panic.jpg
> > > 
> > > 
> > > This is bogus appending stuff to the saved_command_line and at the same
> > > time in Rubens case it touches the late_time_init() which breakes havoc.
> > 
> > -ETOOTERSE.  Do you meen that the user's command line was so long that this
> > strcat wandered off the end of the buffer and corrupted late_time_init?
> 
> Yes indeed, 256 chars has now really been proven to not be long enough.

So the user had really 256 characters command line? That is hard to 
believe because afaik most boot loaders cannot even pass that much.

> 
> > 
> > > Signed-off-by: Alexander Nyberg <alexn@telia.com>
> > > 
> > > Index: linux-2.6/arch/x86_64/kernel/head64.c
> > > ===================================================================
> > > --- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
> > > +++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
> > > @@ -93,9 +93,6 @@
> > >  #ifdef CONFIG_SMP
> > >  	cpu_set(0, cpu_online_map);
> > >  #endif
> > > -	/* default console: */
> > > -	if (!strstr(saved_command_line, "console="))
> > > -		strcat(saved_command_line, " console=tty0"); 
> > 
> > Wasn't that code there for a reason?
> 
> Appending console=tty0 is from what I can see redundant. And if it
> really has a reason it needs a comment and a check to see if there
> really is room in saved_command_line for it. We'll see what Andi has to
> say...

It was needed long ago (in 2.5) to work around bugs in the console subsystem.
It is probably not needed anymore. It can be dropped.

> 
> btw x64 is seemingly the only architecture that actually uses
> saved_command_line as the real working command line and not
> command_line, this is a bit confusing.

I have no problem with changing it if someone sends a patch.

-Andi
