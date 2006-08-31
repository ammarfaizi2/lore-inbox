Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWHaWws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWHaWws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHaWws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:52:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59540 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932472AbWHaWws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:52:48 -0400
Date: Fri, 1 Sep 2006 00:52:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp with PAE
Message-ID: <20060831225232.GE31125@elf.ucw.cz>
References: <20060831135336.GL3923@elf.ucw.cz> <20060831104304.e3514401.akpm@osdl.org> <20060831223521.GB31125@elf.ucw.cz> <20060831154828.4313327c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831154828.4313327c.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-08-31 15:48:28, Andrew Morton wrote:
> On Fri, 1 Sep 2006 00:35:21 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > > > diff --git a/include/asm-i386/suspend.h b/include/asm-i386/suspend.h
> > > > index 08be1e5..01cd812 100644
> > > > --- a/include/asm-i386/suspend.h
> > > > +++ b/include/asm-i386/suspend.h
> > > > @@ -16,6 +16,15 @@ arch_prepare_suspend(void)
> > > >  		printk(KERN_ERR "PSE is required for swsusp.\n");
> > > >  		return -EPERM;
> > > >  	}
> > > > +
> > > > +#ifdef CONFIG_X86_PAE
> > > > +	printk(KERN_ERR "swsusp is incompatible with PAE.\n");
> > > > +	/* This is actually instance of the same problem. We need
> > > > +	   identity mapping self-contained in swsusp_pg_dir, and PAE
> > > > +	   prevents that. Solution could be copied from x86_64. */
> > > > +	return -EPERM;
> > > > +#endif
> > > > +
> > > >  	return 0;
> > > >  }
> > > 
> > > Why not do this in Kconfig??
> > 
> > Well, Kconfig does not provide natural place for comments, and
> > disappearing config option is sure to confuse people. But of course I
> > can do it.
> 
> It would be more conventional.

Well, I have very similar check few lines above, and this is both i386
specific, so I slightly prefer to do it in the code, but...

> I think what this really points at is a weakness in the menuconfig/xconfig/etc
> user interfaces.  It should be possible to navigate to the presently-disabled
> config option and ask it "why can't I turn you on?".

Yes, but I'll still have users asking me "why I can't turn it on" ;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
