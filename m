Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVC2Qzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVC2Qzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVC2Qzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:55:44 -0500
Received: from verein.lst.de ([213.95.11.210]:54161 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261237AbVC2Qzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:55:37 -0500
Date: Tue, 29 Mar 2005 18:55:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Ali Akcaagac <aliakc@web.de>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel OOOPS in 2.6.11.6
Message-ID: <20050329165524.GA1997@lst.de>
References: <1112008141.17962.1.camel@localhost> <20050328224430.GO28536@shell0.pdx.osdl.net> <20050329063044.GB17541@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329063044.GB17541@frodo>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 04:30:44PM +1000, Nathan Scott wrote:
> On Mon, Mar 28, 2005 at 02:44:30PM -0800, Chris Wright wrote:
> > * Ali Akcaagac (aliakc@web.de) wrote:
> > > And happy easter to you all. Just got this while trying to delete some
> > > files on my system.
> > ...
> > > : EIP is at linvfs_open+0x59/0xa0
> > ...
> > Nothing in the -stable series has changed either XFS or the core vfs
> > path on during file open.  Without a chance of reproducing or any more
> > information, it'll be tough to make much progress here.
> 
> *nod*.
> 
> Your full .config would be useful too, Ali, thanks.
> 
> > with eax == 00000000.  This corresponds to a vp->v_fops (or rather
> > vp->v_bh.bh_first->bd_ops) deref.  So, looks like the vnode has a
> > NULL v_bh.bh_first (which looks like it's meant to be used to mean
> > uninitialized).  May check with XFS folks if they've seen this type
> > of bug.
> 
> Its not currently known.  Looks like a possible iget-related race;
> does this one ring any bells, Christoph?

This means the inode wasn't fully initialized.  This looks more like a
problem of not unwinding properly on an error than a race to me.

I'll take a deeper look.

