Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268725AbTCCTHY>; Mon, 3 Mar 2003 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268726AbTCCTHY>; Mon, 3 Mar 2003 14:07:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48389 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268725AbTCCTFg>; Mon, 3 Mar 2003 14:05:36 -0500
Date: Mon, 3 Mar 2003 11:13:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Horrible L2 cache effects from kernel compile
In-Reply-To: <20030303140356.G15363@redhat.com>
Message-ID: <Pine.LNX.4.44.0303031108390.12011-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Mar 2003, Benjamin LaHaise wrote:
> 
> Part of it is that some of the dentry is simply just too bloated.  At 
> 160 bytes, there must be something we can prune:

The thing is, the size of it doesn't really matter. The bad effects come 
not from the size, but from the bad behaviour of the lookup algorithm, 
which would be exactly the same even if the dentry was _half_ the size it 
is now.

In other words, the size of the dentry only matters from a memory usage
standpoint, and I don't think we have any cause to believe that dentries
really hurt our global memory usage (we've _often_ had the bug that we
don't shrink the dentry cache quickly enough, which is a different
problem, though - keeping too many of them around. That should be largely
fixed in current kernels).

So I don't think there is any real reason to worry about the size of the
dentry itself. Yes, you could make it smaller (you could remove the inline
string from it, for example, and you could avoid allocating it at
cacheline boundaries - both of which makes it a _lot_ smaller than just
trying to save few bits), but both of those bigger decisions look like 
they are worthwhile tradeoffs.

		Linus

