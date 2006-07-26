Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWGZLX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWGZLX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGZLX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:23:26 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:64207 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932531AbWGZLXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:23:24 -0400
Subject: Re: [PATCH] mm: inactive-clean list
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Martin Schwidefsky <schwidefsky@googlemail.com>
Cc: Rik van Riel <riel@redhat.com>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <6e0cfd1d0607260400r731489a1tfd9e6c5a197fb0bd@mail.gmail.com>
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>
	 <6e0cfd1d0607260400r731489a1tfd9e6c5a197fb0bd@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 13:11:08 +0200
Message-Id: <1153912268.2732.30.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 13:00 +0200, Martin Schwidefsky wrote:
> On 7/23/06, Rik van Riel <riel@redhat.com> wrote:
> > Peter Zijlstra wrote:
> > > This patch implements the inactive_clean list spoken of during the VM summit.
> > > The LRU tail pages will be unmapped and ready to free, but not freeed.
> > > This gives reclaim an extra chance.
> >
> > This patch makes it possible to implement Martin Schwidefsky's
> > hypervisor-based fast page reclaiming for architectures without
> > millicode - ie. Xen, UML and all other non-s390 architectures.
> 
> Hmm, I wonder how the inactive clean list helps in regard to the fast
> host reclaim
> scheme. In particular since the memory pressure that triggers the
> reclaim is in the
> host, not in the guest. So all pages might be on the active list but
> the host still
> wants to be able to discard pages.
> 

I think Rik would want to set all the already unmapped pages to volatile
state in the hypervisor.

These pages can be dropped without loss of information on the guest
system since they are all already on a backing-store, be it regular
files or swap.



