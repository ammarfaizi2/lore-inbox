Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWIWUgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWIWUgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWIWUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:36:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37057 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751503AbWIWUgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:36:09 -0400
Date: Sat, 23 Sep 2006 21:36:05 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060923203605.GN29920@ftp.linux.org.uk>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923202912.GA22293@uranus.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 10:29:12PM +0200, Sam Ravnborg wrote:
> On Sat, Sep 23, 2006 at 04:44:16PM +0100, Al Viro wrote:
> > indirect chains of includes are arch-specific and can't
> > be relied upon...  (hell, even attempt to build it for
> > itanic would trigger vmalloc.h ones; err.h triggers
> > on e.g. alpha).
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  drivers/infiniband/core/mad_priv.h           |    1 +
> >  drivers/infiniband/hw/amso1100/c2_provider.c |    1 +
> >  drivers/infiniband/hw/amso1100/c2_rnic.c     |    1 +
> >  drivers/infiniband/hw/ipath/ipath_diag.c     |    1 +
> >  4 files changed, 4 insertions(+), 0 deletions(-)
> A better fix would be to avoid the arch dependency in the non-arch .h
> files so that in most cases it just works??

What "it"?  Use of vmalloc() without including vmalloc.h since on i386
it just happens to be pulled via the
linux/pci.h -> linux/dmapool.h -> asm-i386/io.h -> linux/vmalloc.h
chain?

Should we replicate it on every platform?  Along with all kinds of fun that's
going to cause wrt ordering, BTW...
