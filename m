Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWHaWsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWHaWsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWHaWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:48:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932467AbWHaWsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:48:38 -0400
Date: Thu, 31 Aug 2006 15:48:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp with PAE
Message-Id: <20060831154828.4313327c.akpm@osdl.org>
In-Reply-To: <20060831223521.GB31125@elf.ucw.cz>
References: <20060831135336.GL3923@elf.ucw.cz>
	<20060831104304.e3514401.akpm@osdl.org>
	<20060831223521.GB31125@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 00:35:21 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > > diff --git a/include/asm-i386/suspend.h b/include/asm-i386/suspend.h
> > > index 08be1e5..01cd812 100644
> > > --- a/include/asm-i386/suspend.h
> > > +++ b/include/asm-i386/suspend.h
> > > @@ -16,6 +16,15 @@ arch_prepare_suspend(void)
> > >  		printk(KERN_ERR "PSE is required for swsusp.\n");
> > >  		return -EPERM;
> > >  	}
> > > +
> > > +#ifdef CONFIG_X86_PAE
> > > +	printk(KERN_ERR "swsusp is incompatible with PAE.\n");
> > > +	/* This is actually instance of the same problem. We need
> > > +	   identity mapping self-contained in swsusp_pg_dir, and PAE
> > > +	   prevents that. Solution could be copied from x86_64. */
> > > +	return -EPERM;
> > > +#endif
> > > +
> > >  	return 0;
> > >  }
> > 
> > Why not do this in Kconfig??
> 
> Well, Kconfig does not provide natural place for comments, and
> disappearing config option is sure to confuse people. But of course I
> can do it.

It would be more conventional.

I think what this really points at is a weakness in the menuconfig/xconfig/etc
user interfaces.  It should be possible to navigate to the presently-disabled
config option and ask it "why can't I turn you on?".
