Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbSA1WW0>; Mon, 28 Jan 2002 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287189AbSA1WWQ>; Mon, 28 Jan 2002 17:22:16 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:3719 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287139AbSA1WWA>;
	Mon, 28 Jan 2002 17:22:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Rick Stevens <rstevens@vitalstream.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Mon, 28 Jan 2002 23:26:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201281940580.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201281940580.32617-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VKEh-0000DB-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 10:43 pm, Rik van Riel wrote:
> On Mon, 28 Jan 2002, Rick Stevens wrote:
> > Daniel Phillips wrote:
> > [snip]
>   [page table COW description]
> 
> > Perhaps I'm missing this, but I read that as the child gets a reference
> > to the parent's memory.  If the child attempts a write, then new memory
> > is allocated, data copied and the write occurs to this new memory.  As
> > I read this, it's only invoked on a child write.
> >
> > Would this not leave a hole where the parent could write and, since the
> > child shares that memory, the new data would be read by the child?  Sort
> > of a hidden shm segment?  If so, I think we've got problems brewing.
> > Now, if a parent write causes the same behaviour as a child write, then
> > my point is moot.
> 
> Daniel and I discussed this issue when Daniel first came up with
> the idea of doing page table COW.  He seemed a bit confused by
> fork semantics when we first discussed this idea, too ;)

Oh yes, I admit it, confused is me.  That way I avoid heading off in 
directions that people have already gone, and found nothing ;-)

> You're right though, both parent and child need to react in the
> same way, preferably _without_ having to walk all of the parent's
> page tables and mark them read-only ...

Yes, and look at the algorithm as I've stated it, it's symmetric with respect 
to parent and child.  Getting it into this simple and robust form took a lot 
of work, and as you know, my initial attempts were complex and, yes, confused.

-- 
Daniel
