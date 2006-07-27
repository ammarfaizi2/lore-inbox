Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWG0JRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWG0JRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWG0JRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:17:52 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:47271 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750761AbWG0JRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:17:51 -0400
Date: Thu, 27 Jul 2006 11:17:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Levitsky Maxim <maximlevitsky@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Block size > PAGE_SIZE
Message-ID: <20060727091742.GA10622@wohnheim.fh-wedel.de>
References: <20060720105058.40166.qmail@web38507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060720105058.40166.qmail@web38507.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 July 2006 03:50:58 -0700, Levitsky Maxim wrote:
> 
> I have idea to lift software based limitation of 4K
> maximum block size of block devices.
> 
> There are some devices that have bigger that 4K block
> size. The most notable are packet driven CD/DVD
> recorders, but for example Flash chips cannot erase
> blocks that are bigger that 64K of even more.

s/bigger/smaller/

Flash is a bad example.  Even if the block layer and say ext2 could
deal with 64k block size, using ext2 as a flash filesystem would still
be an extremely bad idea for several other reasons.  Not sure about
the CD/DVD case, but according to my half-knowledge the same is true
there.

> The extent based filesystems can also benefit from
> bigger block size , they will be able to read a
> cluster at time

Already the case, afaics.

> Each buffer_head will have addition filed ->next that
> will point in circuit to next buffer_head that stores
> data from the same sector 

buffer_head is considered deprecated.  You could have a look at
struct bio and reconsider whether your idea is a good one.

> I didn't yet implemented this idea , because I want to
> know whenever you like this idea or not. After all
> this is not a simply work. 

There can be some benefit in having larger block sizes.  For ext2, it
would increase limits like the maximum file size, decrease the amount
of metadata and have some nice effects on caches (smaller data is as
good as bigger caches and bigger bandwidth in one).

But there are disadvantages as well, most notably the wasted space for
small files increases.

And overall, 99% of the problem lies within an individual filesystem,
so working on the block layer doesn't help much.  If you want to
follow your idea, you should pick a filesystem, learn as much about it
as you can and then change this filesystem.  And after your changes,
measure whether they have beneficial effects.

Jörn

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
-- Brian W. Kernighan
