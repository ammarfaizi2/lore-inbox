Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUFNVKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUFNVKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUFNVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:10:53 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:19867 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S264255AbUFNVKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:10:51 -0400
Date: Mon, 14 Jun 2004 23:19:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/5] kbuild: make clean improved
Message-ID: <20040614211940.GA15555@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204655.GE15243@mars.ravnborg.org> <20040614215034.K14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614215034.K14403@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 09:50:34PM +0100, Russell King wrote:
> On Mon, Jun 14, 2004 at 10:46:55PM +0200, Sam Ravnborg wrote:
> >  # Directories & files removed with 'make clean'
> >  CLEAN_DIRS  += $(MODVERDIR)
> > -CLEAN_FILES +=	vmlinux System.map \
> > +CLEAN_FILES +=	vmlinux System.map .version .config.old \
> >                  .tmp_kallsyms* .tmp_version .tmp_vmlinux*
> 
> Why should 'make clean' remove the build version?  Traditionally,
> this has been preserved until 'make mrproper'.

In the 2.4 days people had to do 'make clean' very often.
For the 2.6 kernel this is no longer needed, so when cleaning up
we want to be effective.

.version only really pays off when doing a lot of consecutive
build on the _same_ kernel src.

And make clean is often used in combination with kernel patching,
especially when renaming files: mv mm/slab.c.old mm/slab.c for example.

Here we start over with some new src, so it make sense to start over
with the version?

	Sam
