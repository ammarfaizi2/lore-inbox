Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272308AbTHIJd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 05:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTHIJd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 05:33:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:26244 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272308AbTHIJd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 05:33:57 -0400
Date: Sat, 9 Aug 2003 10:33:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Morton <akpm@osdl.org>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-ID: <20030809093337.GA28566@mail.jlokier.co.uk>
References: <20030809010950.GD26375@mail.jlokier.co.uk> <Pine.LNX.4.30.0308090609370.19108-100000@divine.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0308090609370.19108-100000@divine.city.tvnet.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs wrote:
> I just can't believe reiser4 is so fast on an unloaded system (from the
> numbers one could also expect it's the slowest on loaded systems and JFS
> seems to be the winner on those).

reiser4 is using approximately twice the CPU percentage, but completes
in approximately half the time, therefore it uses about the same
amount of CPU time at the others.

Therefore on a loaded system, with a load carefully chosen to make the
test CPU bound rather than I/O bound, one could expect reiser4 to
complete in approximately the same time as the others, _not_ slowest.

That's why it's misleading to draw conclusions from the CPU percentage alone.

> Disks have a speed/seek limits. To be faster, one must ignore
> 'sync', do less IO (file/tail packing, compression, etc) and/or
> optimise seek times.

reiser4 literature claims that it does less IO (wandering logs) and
suggests better seek patterns (deferred allocation).

> > Another interesting statistic would be the number of blocks read and
> > written during the test.
> 
> Yes, but I would collect those stats after these short term tests for an
> additional X seconds to make sure no additional "optimization" is involved
> (aka data is indeed on the disk).

Indeed.  Even sync() is not guaranteed to flush the data to disk in
its final form, if the filesystem state is already committed to the
journal.

-- Jamie
