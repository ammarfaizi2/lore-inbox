Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133065AbRDLH1c>; Thu, 12 Apr 2001 03:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133064AbRDLH1V>; Thu, 12 Apr 2001 03:27:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49404 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133062AbRDLH1P>;
	Thu, 12 Apr 2001 03:27:15 -0400
Date: Thu, 12 Apr 2001 03:27:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-fsdevel@vger.kernel.org
cc: kowalski@datrix.co.za, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: [race][RFC] d_flags use
In-Reply-To: <200104120700.f3C70W3N016374@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104120318150.18135-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Andreas Dilger wrote:

> Al writes:
> > We _have_ VM pressure there. However, such loads had never been used, so
> > there's no wonder that system gets unbalanced under them.
> > 
> > I suspect that simple replacement of goto next; with continue; in the
> > fs/dcache.c::prune_dcache() may make situation seriously better.
> 
> Yes, it appears that this would be a bug.  We were only _checking_
> "count" dentries, rather than pruning "count" dentries.
> 
> Testing continues.

Uh-oh... After looking at prune_dcache for a minute... Folks, what
protects ->d_flags? That may very well be the reason of some NFS
and autofs problems.

If nobody objects I'll go for test_bit/set_bit/clear_bit here.
								Al

