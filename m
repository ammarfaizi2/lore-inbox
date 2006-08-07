Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWHGVU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWHGVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWHGVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:20:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48308 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932386AbWHGVU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:20:28 -0400
Date: Mon, 7 Aug 2006 14:20:21 -0700
From: Greg KH <greg@kroah.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] kbuild fixes for 2.6.18
Message-ID: <20060807212021.GB13148@kroah.com>
References: <20060807192708.GA12937@mars.ravnborg.org> <20060807204241.GA11510@kroah.com> <20060807210209.GA14327@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807210209.GA14327@mars.ravnborg.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 11:02:09PM +0200, Sam Ravnborg wrote:
> On Mon, Aug 07, 2006 at 01:42:41PM -0700, Greg KH wrote:
> > On Mon, Aug 07, 2006 at 09:27:09PM +0200, Sam Ravnborg wrote:
> > > Hi Greg.
> > > Please apply to 2.6.18.
> > > 
> > > Pull from:
> > > 
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git
> > 
> > Thanks, pulled and pushed out.
> > 
> > Oh, I just got a few reports of 2.6.18-rc3 not building with external
> > trees very well, and something like the following would be required:
> > 
> > --- linux-2.6.17/arch/sh/Makefile-dist        2006-08-07 20:42:33.000000000 +0200
> > +++ linux-2.6.17/arch/sh/Makefile     2006-08-07 21:08:26.000000000 +0200
> > @@ -173,7 +173,7 @@
> >  archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
> > 
> >  PHONY += maketools FORCE
> > -maketools:  include/linux/version.h FORCE
> > +maketools: $(objtree)/include/linux/version.h FORCE
> > 
> > for all instances of the version.h file.
> This looks bogus.

Ick, ok, thanks.

> Current directory is $(objtree) so prefixing with $(objtree) should not
> be needed and doing so will confuse make. make will not know that
> $(objtree)/include/linux/version.h and include/linux/version.h is the
> same file.
> 
> And the version.h dependency is anyway not needed. kbuild guarantee the
> version.h is created when the commands for archprepare are executed.

Hm, I'll point the person who is having the problem with this at you and
lkml and have him explain the problems he is seeing.  Much easier than
me trying to mediate the conversation :)

thanks,

greg k-h
