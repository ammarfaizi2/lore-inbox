Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVATQIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVATQIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVATQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:06:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:22976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262179AbVATQFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:05:38 -0500
Date: Thu, 20 Jan 2005 08:05:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu, peterc@gelato.unsw.edu.au,
       tony.luck@intel.com, dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
In-Reply-To: <20050120031854.GA8538@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0501200752280.8178@ppc970.osdl.org>
References: <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu>
 <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au>
 <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
 <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
 <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org>
 <20050120031854.GA8538@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jan 2005, Chris Wedgwood wrote:
>
> On Wed, Jan 19, 2005 at 07:01:04PM -0800, Andrew Morton wrote:
> 
> > ... how about we simply nuke this statement:
> >
> > Chris Wedgwood <cw@f00f.org> wrote:
> > >
> > >  	if (!spin_is_locked(&p->sighand->siglock) &&
> > >  -				!rwlock_is_locked(&tasklist_lock))
> > >  +				!rwlock_write_locked(&tasklist_lock))
> >
> > and be done with the whole thing?
> 
> I'm all for killing that.  I'll happily send a patch once the dust
> settles.

How about I just kill it now, so that it just doesn't exist, and the dust 
(from all the other things) can settle where it will?

In fact, I think I will remove the whole "rwlock_is_locked()" thing and 
the only user, since it's all clearly broken, and regardless of what we do 
it will be something else. That will at least fix the current problem, and 
only leave us doing too many bus accesses when BKL_PREEMPT is enabled.

		Linus
