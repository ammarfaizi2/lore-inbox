Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTLQSxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLQSxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:53:54 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:47440 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264501AbTLQSxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:53:52 -0500
Date: Wed, 17 Dec 2003 13:53:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <wli@holomorphy.com>, <kernel@kolivas.org>,
       <chris@cvine.freeserve.co.uk>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031216112307.GA5041@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Roger Luethi wrote:

> One potential problem with the benchmarks is that my test box has
> just one bar with 256 MB RAM. The kbuild and efax tests were run with
> mem=64M and mem=32M, respectively. If the difference between mem=32M

OK, I found another difference with 2.4.

Try "echo 256 > /proc/sys/vm/min_free_kbytes", I think
that should give the same free watermarks that 2.4 has.

Using 1MB as the min free watermark for lowmem is bound
to result in more free (and less used) memory on systems
with less than 128 MB RAM ... significantly so on smaller
systems.

The fact that ZONE_HIGHMEM and ZONE_NORMAL are recycled
at very different rates could also be of influence on
some performance tests...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

