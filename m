Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278311AbRJMPFj>; Sat, 13 Oct 2001 11:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278312AbRJMPF3>; Sat, 13 Oct 2001 11:05:29 -0400
Received: from [204.177.156.37] ([204.177.156.37]:28350 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S278311AbRJMPFP>; Sat, 13 Oct 2001 11:05:15 -0400
Date: Sat, 13 Oct 2001 16:07:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andi Kleen <andi@firstfloor.org>
cc: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
In-Reply-To: <20011013015726.A28065@zero.firstfloor.org>
Message-ID: <Pine.LNX.4.21.0110131537470.931-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Andi Kleen wrote:
> 
> I attached a patch. It allows you to get some simple statistics from
> /proc/net/sockstat (unfortunately costly too). It also adds a new kernel
> boot argument tcpehashgoal=order. Order is the log2 of how many pages you
> want to use for the hash table (so it needs 2^order * 4096 bytes on i386) 
> You can experiment with various sizes and check which one gives still 
> reasonable hash distribution under load.

Wouldn't something like "tcpehashbuckets" make a better boot tunable
than "tcpehashorder"?  Rounded up to next power of two before used.

I come at this from the PAGE_SIZE angle, rather than the TCP angle:
"order" tunables seem confusing to me (being interested in configurable
PAGE_SIZE).  And they're confusing to code too: note that the existing
calculation of goal from num_physpages gives you more hash buckets for
larger PAGE_SIZE (comment says "methodology is similar to that of the
buffer cache", but buffer cache gets it right - though for small memory,
would do better to multiply mempages by sizeof _before_ shifting right).

Hugh

