Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUFNVin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUFNVin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUFNVim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:38:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32955 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S264512AbUFNVih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:38:37 -0400
Date: Mon, 14 Jun 2004 14:38:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/5] kbuild: make clean improved
Message-ID: <20040614213835.GA11113@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204655.GE15243@mars.ravnborg.org> <20040614215034.K14403@flint.arm.linux.org.uk> <20040614211940.GA15555@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614211940.GA15555@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 11:19:40PM +0200, Sam Ravnborg wrote:
> On Mon, Jun 14, 2004 at 09:50:34PM +0100, Russell King wrote:
> > On Mon, Jun 14, 2004 at 10:46:55PM +0200, Sam Ravnborg wrote:
> > >  # Directories & files removed with 'make clean'
> > >  CLEAN_DIRS  += $(MODVERDIR)
> > > -CLEAN_FILES +=	vmlinux System.map \
> > > +CLEAN_FILES +=	vmlinux System.map .version .config.old \
> > >                  .tmp_kallsyms* .tmp_version .tmp_vmlinux*
> > 
> > Why should 'make clean' remove the build version?  Traditionally,
> > this has been preserved until 'make mrproper'.
> 
> In the 2.4 days people had to do 'make clean' very often.
> For the 2.6 kernel this is no longer needed, so when cleaning up
> we want to be effective.
> 
> .version only really pays off when doing a lot of consecutive
> build on the _same_ kernel src.
> 
> And make clean is often used in combination with kernel patching,
> especially when renaming files: mv mm/slab.c.old mm/slab.c for example.
> 
> Here we start over with some new src, so it make sense to start over
> with the version?

I'd agrue the exact opposite.  If you're starting from scratch (new
patchset, etc, where you might do something like mv mm/slab.c.old
mm/slab.c) use 'distclean' or 'mrproper'.  If you just want to do a
'make clean' because you can't be sure you trust the build system to get
things right, you don't want the version being reset.

-- 
Tom Rini
http://gate.crashing.org/~trini/
