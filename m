Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVATDTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVATDTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVATDTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:19:54 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:64210 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261986AbVATDTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:19:43 -0500
Date: Wed, 19 Jan 2005 19:18:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       peterc@gelato.unsw.edu.au, tony.luck@intel.com, dsw@gelato.unsw.edu.au,
       torvalds@osdl.org, benh@kernel.crashing.org, linux-ia64@vger.kernel.org,
       hch@infradead.org, wli@holomorphy.com, jbarnes@sgi.com
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
Message-ID: <20050120031854.GA8538@taniwha.stupidest.org>
References: <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu> <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119190104.71f0a76f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 07:01:04PM -0800, Andrew Morton wrote:

> ... how about we simply nuke this statement:
>
> Chris Wedgwood <cw@f00f.org> wrote:
> >
> >  	if (!spin_is_locked(&p->sighand->siglock) &&
> >  -				!rwlock_is_locked(&tasklist_lock))
> >  +				!rwlock_write_locked(&tasklist_lock))
>
> and be done with the whole thing?

I'm all for killing that.  I'll happily send a patch once the dust
settles.

It still isn't enough to rid of the rwlock_read_locked and
rwlock_write_locked usage in kernel/spinlock.c as those are needed for
the cpu_relax() calls so we have to decide on suitable names still...
