Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbSIZWYq>; Thu, 26 Sep 2002 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSIZWYq>; Thu, 26 Sep 2002 18:24:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261496AbSIZWYq>; Thu, 26 Sep 2002 18:24:46 -0400
Date: Thu, 26 Sep 2002 15:32:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <3D938588.4508FDF@digeo.com>
Message-ID: <Pine.LNX.4.33.0209261530150.1345-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Andrew Morton wrote:
> Ingo Molnar wrote:
> > 
> > ...
> > another implementation would be an idea from Linus: the page's lru list
> > pointer can in theory be used for pinned pages (pinned pages do not have
> > much LRU meaning anyway), and this pointer could specify the 'owner' MM of
> > the physical page. The COW fault handler then checks the sticky page:
> 
> Overloading page->lru in this way is tricky.   If we can guarantee
> that the page is anonymous (anonymise it if it's file-backed, pull
> it out of swapcache) then fine, ->mapping, ->list.next, ->list.prev,
> ->index and ->private are available.
> 
> Can we do that?

Well, we have two situations:
 - the page is shared. In which case we don't need to put it on any 
   pinning list, since the very sharedness of the page means that we won't
   be COW'ing it in this address space.
 - the page is private. In which case we can (and should) pre-COW it and 
   make it anonymous at futex time.

So yeah, it should be doable.

Not pretty.

		Linus

