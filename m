Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbTCHOm3>; Sat, 8 Mar 2003 09:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbTCHOm2>; Sat, 8 Mar 2003 09:42:28 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:28546 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262037AbTCHOmZ>; Sat, 8 Mar 2003 09:42:25 -0500
Subject: Re: 2.5.64-mm2
From: Shawn <core@enodev.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <1047131942.3759.1.camel@localhost.localdomain>
References: <20030307185116.0c53e442.akpm@digeo.com>
	 <1047095352.3483.0.camel@localhost.localdomain>
	 <1047096331.727.14.camel@phantasy.awol.org>
	 <1047096093.3483.4.camel@localhost.localdomain>
	 <1047097353.727.18.camel@phantasy.awol.org>
	 <1047131942.3759.1.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047134733.5968.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Mar 2003 08:45:34 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate initrd (eliminate using it, not support for it) and oops goes
away. Weird.

On Sat, 2003-03-08 at 07:59, Shawn wrote:
> Now I oops on boot justt when it trys to mount root (reiserfs),
> unfortunately, I cannot page up to see the oops text.
> 
> I'll try booting with vesa fbcon to see if I can't see more.
> 
> On Fri, 2003-03-07 at 22:22, Robert Love wrote:
> > On Fri, 2003-03-07 at 23:01, Shawn wrote:
> > > Here's my .config. I am not SMP.
> > > 
> > > I suspected the distclean thing, but I made "Mr. Proper" too just in
> > > case.
> > 
> > Oh.  Its those damn modules.  The bane of my existence.
> > 
> > Problem is, ksyms.c is exporting kernel_flag under PREEMPT.  Now we just
> > need it exported under SMP.
> > 
> > Andrew, would you mind appending this to the current patch? Sorry.
> > 
> > Everyone else, you need this if you are UP+PREEMPT+MODULES.
> > 
> > 	Robert Love
> > 
> > 
> >  kernel/ksyms.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > diff -urN linux-2.5.64-mm2/kernel/ksyms.c linux/kernel/ksyms.c
> > --- linux-2.5.64-mm2/kernel/ksyms.c	2003-03-07 22:08:04.000000000 -0500
> > +++ linux/kernel/ksyms.c	2003-03-07 23:19:32.098500176 -0500
> > @@ -488,7 +488,7 @@
> >  #if CONFIG_SMP
> >  EXPORT_SYMBOL_GPL(set_cpus_allowed);
> >  #endif
> > -#if CONFIG_SMP || CONFIG_PREEMPT
> > +#if CONFIG_SMP
> >  EXPORT_SYMBOL(kernel_flag);
> >  #endif
> >  EXPORT_SYMBOL(jiffies);
> > 
> > 
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
