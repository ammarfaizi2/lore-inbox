Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVAUHMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVAUHMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAUHMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:12:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42331
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262299AbVAUHKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:10:24 -0500
Date: Fri, 21 Jan 2005 08:10:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: OOM fixes 2/5
Message-ID: <20050121071024.GF17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050120222056.61b8b1c3.akpm@osdl.org> <1106289375.5171.7.camel@npiggin-nld.site> <20050121065235.GD17050@dualathlon.random> <20050120230016.442e5835.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120230016.442e5835.akpm@osdl.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 11:00:16PM -0800, Andrew Morton wrote:
> Last time we dicsussed this you pointed out that reserving more lowmem from
> highmem-capable allocations may actually *help* things.  (Tries to remember
> why) By reducing inode/dentry eviction rates?  I asked Martin Bligh if he
> could test that on a big NUMA box but iirc the results were inconclusive.

This is correct, guaranteeing more memory to be freeable in lowmem (ptes
aren't freeable without a sigkill for example) the icache/dcache will at
least have a margin where it can grow indipendently from highmem
allocations.

> Maybe it just won't make much difference.  Hard to say.

I don't know myself if it makes a performance difference, all old
benchmarks have been run with this applied. This was applied for
correcntess (i.e.  to avoid sigkills or lockups), it wasn't applied for
performance. But I don't see how it could hurt performance (especially
given current code already does the check at runtime, which is
pratically the only fast-path cost ;).

> >  The sysctl name had to change to lowmem_reserve_ratio because its
> >  semantics are completely different now.
> 
> That reminds me.  Documentation/filesystems/proc.txt ;)

Woops, forgotten about it ;)

> I'll cook something up for that.

Thanks. If you prefer I can write it too to relieve you from this load,
it's up to you. If you want to fix it yourself go ahead of course ;)
