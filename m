Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292992AbSB0Vu6>; Wed, 27 Feb 2002 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292983AbSB0Vse>; Wed, 27 Feb 2002 16:48:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15514 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292994AbSB0VsT>;
	Wed, 27 Feb 2002 16:48:19 -0500
Date: Wed, 27 Feb 2002 16:48:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
In-Reply-To: <3C7D374B.4621F9BA@zip.com.au>
Message-ID: <Pine.GSO.4.21.0202271645560.12074-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2002, Andrew Morton wrote:

> "Martin J. Bligh" wrote:
> > 
> > ...
> > looks a little distressing - the hold times on inode_lock by prune_icache
> > look bad in terms of latency (contention is still low, but people are still
> > waiting on it for a very long time). Is this a transient thing, or do people
> > think this is going to be a problem?
> 
> inode_lock hold times are a problem for other reasons.

ed mm/vmscan.c <<EOF
/shrink_icache_memory/s/priority/1/
w
q
EOF

and repeat the tests.  Unreferenced inodes == useless inodes.  Aging is
already taken care of in dcache and anything that had fallen through
is fair game.

