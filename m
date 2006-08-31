Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWHaXCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWHaXCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWHaXCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:02:21 -0400
Received: from xenotime.net ([66.160.160.81]:46770 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750802AbWHaXCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:02:20 -0400
Date: Thu, 31 Aug 2006 16:05:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp with PAE
Message-Id: <20060831160546.3309d745.rdunlap@xenotime.net>
In-Reply-To: <20060831225232.GE31125@elf.ucw.cz>
References: <20060831135336.GL3923@elf.ucw.cz>
	<20060831104304.e3514401.akpm@osdl.org>
	<20060831223521.GB31125@elf.ucw.cz>
	<20060831154828.4313327c.akpm@osdl.org>
	<20060831225232.GE31125@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 00:52:34 +0200 Pavel Machek wrote:

> On Thu 2006-08-31 15:48:28, Andrew Morton wrote:
> > On Fri, 1 Sep 2006 00:35:21 +0200
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > > > diff --git a/include/asm-i386/suspend.h b/include/asm-i386/suspend.h
> > > > > index 08be1e5..01cd812 100644
> > > > > --- a/include/asm-i386/suspend.h
> > > > > +++ b/include/asm-i386/suspend.h
> > > > > @@ -16,6 +16,15 @@ arch_prepare_suspend(void)
> > > > >  		printk(KERN_ERR "PSE is required for swsusp.\n");
> > > > >  		return -EPERM;
> > > > >  	}
> > > > > +
> > > > > +#ifdef CONFIG_X86_PAE
> > > > > +	printk(KERN_ERR "swsusp is incompatible with PAE.\n");
> > > > > +	/* This is actually instance of the same problem. We need
> > > > > +	   identity mapping self-contained in swsusp_pg_dir, and PAE
> > > > > +	   prevents that. Solution could be copied from x86_64. */
> > > > > +	return -EPERM;
> > > > > +#endif
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > 
> > > > Why not do this in Kconfig??
> > > 
> > > Well, Kconfig does not provide natural place for comments, and
> > > disappearing config option is sure to confuse people. But of course I
> > > can do it.
> > 
> > It would be more conventional.
> 
> Well, I have very similar check few lines above, and this is both i386
> specific, so I slightly prefer to do it in the code, but...

If we can prevent a non-working build in Kconfig, that's what
we should do.

> > I think what this really points at is a weakness in the menuconfig/xconfig/etc
> > user interfaces.  It should be possible to navigate to the presently-disabled
> > config option and ask it "why can't I turn you on?".
> 
> Yes, but I'll still have users asking me "why I can't turn it on" ;-).

menuconfig and xconfig both have Help and Search that can aid
with that, but I would still use the "comment" keyword also.

---
~Randy
