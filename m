Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264824AbUEEWau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbUEEWau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUEEWau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:30:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:32907 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264824AbUEEWal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:30:41 -0400
Date: Wed, 5 May 2004 15:30:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Wright <chrisw@osdl.org>, manfred@colorfullife.com, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify mqueue_inode_info->messages allocation
Message-ID: <20040505153036.K21045@build.pdx.osdl.net>
References: <20040504174214.D21045@build.pdx.osdl.net> <20040504174713.E21045@build.pdx.osdl.net> <20040504180622.F21045@build.pdx.osdl.net> <20040504183722.H21045@build.pdx.osdl.net> <20040505135523.GC1418@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040505135523.GC1418@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, May 05, 2004 at 10:55:23AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti (marcelo.tosatti@cyclades.com) wrote:
> On Tue, May 04, 2004 at 06:37:22PM -0700, Chris Wright wrote:
> > * Chris Wright (chrisw@osdl.org) wrote:
> > > --- ./ipc/mqueue.c~single_alloc	2004-05-04 15:16:34.000000000 -0700
> > > +++ ./ipc/mqueue.c~	2004-05-04 15:59:25.000000000 -0700
> > 
> > Ugh!  Andrew pointed out to me that this is crap.  Sorry about the added
> > noise.  Here's a patch relative to a file that actually exists. 
> 
> While we're at it, in do_create:
> 
>         ret = vfs_create(dir->d_inode, dentry, mode, NULL);
>         if (ret) {
>                 kfree(msgs);
>                 return ERR_PTR(ret);
> 
> The msgs pointer can be NULL. Isnt that going to BUG if so?

kfree(NULL) is no-op.  but if you look at this patch, that is gone
altogether.

thanks,
-chris

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
