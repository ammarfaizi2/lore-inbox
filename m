Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWHaWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWHaWfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHaWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:35:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14031 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932465AbWHaWff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:35:35 -0400
Date: Fri, 1 Sep 2006 00:35:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp with PAE
Message-ID: <20060831223521.GB31125@elf.ucw.cz>
References: <20060831135336.GL3923@elf.ucw.cz> <20060831104304.e3514401.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831104304.e3514401.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel Machek <pavel@suse.cz> wrote:
> 
> > If HIGHMEM64G and swsusp are used at the same time, nasty random
> > crashes happen during resume. Cause is known; prevent that
> > combination.
> > 
> > I guess I'd like to see this one in 2.6.18...
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > ---
> > commit acb3b411ec93f827b25b8481d53670c5c9195d89
> > tree f52cd5518e34af16fe5ae28064717bcc95929f28
> > parent cd03e183c58e6e7073e054a7fe335cf50c61fe2f
> > author <pavel@amd.ucw.cz> Thu, 31 Aug 2006 15:52:34 +0200
> > committer <pavel@amd.ucw.cz> Thu, 31 Aug 2006 15:52:34 +0200
> > 
> >  include/asm-i386/suspend.h |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/asm-i386/suspend.h b/include/asm-i386/suspend.h
> > index 08be1e5..01cd812 100644
> > --- a/include/asm-i386/suspend.h
> > +++ b/include/asm-i386/suspend.h
> > @@ -16,6 +16,15 @@ arch_prepare_suspend(void)
> >  		printk(KERN_ERR "PSE is required for swsusp.\n");
> >  		return -EPERM;
> >  	}
> > +
> > +#ifdef CONFIG_X86_PAE
> > +	printk(KERN_ERR "swsusp is incompatible with PAE.\n");
> > +	/* This is actually instance of the same problem. We need
> > +	   identity mapping self-contained in swsusp_pg_dir, and PAE
> > +	   prevents that. Solution could be copied from x86_64. */
> > +	return -EPERM;
> > +#endif
> > +
> >  	return 0;
> >  }
> 
> Why not do this in Kconfig??

Well, Kconfig does not provide natural place for comments, and
disappearing config option is sure to confuse people. But of course I
can do it.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
