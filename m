Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268122AbSIRUMf>; Wed, 18 Sep 2002 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268123AbSIRUMe>; Wed, 18 Sep 2002 16:12:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:15352 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268122AbSIRUMe>;
	Wed, 18 Sep 2002 16:12:34 -0400
Message-ID: <3D88DF5A.68E41C6B@digeo.com>
Date: Wed, 18 Sep 2002 13:17:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mm gang: you goofed!
References: <Pine.LNX.4.44.0209182006530.5607-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 20:17:30.0148 (UTC) FILETIME=[6A137E40:01C25F50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> ...
> It seems that __lookup() can easily return 0, even though there's
> more to find, if it starts partway into a RADIX_TREE_MAP_SIZE
> array, in which the only occupied slots are before it starts.

erk.  That sounds right.

I don't think the max_index test matters much - if we ever
hit that index then something has gone horridly wrong, because
it's out-of-bounds for the tree height.  But whatever.

> Patch below seems to fix it

But your patch only fixes the symptoms of the bug.  You should
fix the real bug.  But to do that you'd need to find me, so this
will have to do for now.

> but I bet you can improve upon it.

Well the colour scheme is a bit gaudy.
 
> Might this relate to Trond/Chuck's NFS invalidation woes?

Nope; this code is only in the mm crash-test-dummy tree at present.
And it's currently at the "wow, it worked first time" stage.  I need
to get down and write some special test code for it, and to run
fsx-linux.  Possibly fsx-linux has sufficient coverage.

> It's certainly the main contributor to my tmpfs problems.

Sorry about that.
 
> I look forward to your "erk" - or will you delight us with
> some other exclamation?!

gack?
