Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbVHVWoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbVHVWoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVHVWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:44:07 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21388 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751485AbVHVWnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:43:39 -0400
Date: Mon, 22 Aug 2005 13:41:47 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] make loglevels in init/main.c a little more sane.
Message-ID: <20050822054147.GA20546@localhost.localdomain>
References: <Pine.LNX.4.61.0501222229210.3073@dragon.hygekrogen.localhost> <2cd57c900508212217c0465a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900508212217c0465a3@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:17:59PM +0800, Coywolf Qi Hunt wrote:
> On 1/23/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > 
> > This patch modifies a few of the printk() loglevels used in init/main.c in
> > an attempt to make them a bit more appropriate.
> > 
> > The default loglevel is KERN_WARNING, but a few printk's without explicit
> > loglevel are not (in my oppinion) warnings, so add proper warning levels -
> > for instance; telling the user how many CPU's were brought up is hardly a
> > warning, make it KERN_INFO instead. The initial printing of linux_banner
> > is not a warning condition, I'd say it's more of a NOTICE or even INFO
> > condition - I've made it KERN_NOTICE just as the printing of the kernel
> > command line. A few printk's without explicit loglevel do match the
> > default one, but I've made them explicit (the default could change in the
> > future, and if it does then explicitly setting the proper loglevel is a
> > nice thing).
> > Please consider applying.
> > 
> > Patch compiles and boots fine on my box.
> > 
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> > diff -up linux-2.6.11-rc2-orig/init/main.c linux-2.6.11-rc2/init/main.c
> > --- linux-2.6.11-rc2-orig/init/main.c   2005-01-22 22:00:02.000000000 +0100
> > +++ linux-2.6.11-rc2/init/main.c        2005-01-22 22:45:23.000000000 +0100
> > @@ -347,7 +347,7 @@ static void __init smp_init(void)
> >         }
> > 
> >         /* Any cleanup work */
> > -       printk("Brought up %ld CPUs\n", (long)num_online_cpus());
> > +       printk(KERN_INFO "Brought up %ld CPUs\n", (long)num_online_cpus());
> >         smp_cpus_done(max_cpus);
> >  #if 0
> >         /* Get other processors into their bootup holding patterns. */
> > @@ -428,6 +428,7 @@ asmlinkage void __init start_kernel(void
> >   */
> >         lock_kernel();
> >         page_address_init();
> > +       printk(KERN_NOTICE);
> >         printk(linux_banner);
> 
> Why not merge it to the same line?
> 
> >         setup_arch(&command_line);
> >         setup_per_cpu_areas();

Hi,

I'm not sure if this is cleaner. The original 2-line implementation seems
convenient. All up to you. 

	Coywolf

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>

--- 2.6.13-rc6-mm1-cy/init/main.c~printk-linux_banner-cleanup	2005-08-22 08:09:47.000000000 +0800
+++ 2.6.13-rc6-mm1-cy/init/main.c	2005-08-22 13:29:48.000000000 +0800
@@ -450,8 +450,7 @@ asmlinkage void __init start_kernel(void
  */
 	lock_kernel();
 	page_address_init();
-	printk(KERN_NOTICE);
-	printk(linux_banner);
+	printk(KERN_NOTICE "%s", linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
 
