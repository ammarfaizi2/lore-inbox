Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSGRSUz>; Thu, 18 Jul 2002 14:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSGRSUz>; Thu, 18 Jul 2002 14:20:55 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:30728 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318297AbSGRSUy>; Thu, 18 Jul 2002 14:20:54 -0400
Date: Thu, 18 Jul 2002 19:25:54 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Robert Love <rml@tech9.net>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027014161.1086.123.camel@sinai>
Message-ID: <Pine.LNX.4.30.0207181900390.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2002, Robert Love wrote:
> On Thu, 2002-07-18 at 09:36, Szakacsits Szabolcs wrote:
>
> > This is what I would do first [make sure you don't hit any resource,
> > malloc, kernel memory mapping, etc limits -- this is a simulation that
> > must eat all available memory continually]:
> > main(){void *x;while(1)if(x=malloc(4096))memset(x,666,4096);}
> >
> > When the above used up all the memory try to ssh/login to the box as
> > root and clean up the mess. Can you do it?
>
> - with strict overcommit and the "allocations must meet backing store"
> rule (policy #3) the above can never use all physical memory

So you can't do it: if this user can't get more memory neither root.

> - if your point is that a rogue user can use all of the systems memory,
> then you need per-user resource accounting.

I explicitely mentioned above, "make sure you don't hit any resource
... limit".

> - the point of this patch is to not use MORE memory than the system
> has.

I had my [not finished] own non-overcommit patch based on Eduardo
Horvath's from 2000, no need to explain what it means :) Actually the
basics of your patch looks very similar to Eduardo's one.

> I say nothing else except that I am trying to avoid OOM and push
> the allocation failures into the allocations themselves.  Assuming the
> accounting is correct (and it seems to be) then Alan and I have
> succeeded.

And my point (you asked for comments) was that, this is only (the
harder) part of the solution making Linux a more reliable (no OOM
killing *and* root always has the control) and cost effective platform
(no need for occasionally very complex and continuous resource limit
setup/adjusting, especially for inexpert home/etc users).

	Szaka

