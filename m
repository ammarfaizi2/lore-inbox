Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLPQaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLPQaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:30:20 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:20822 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261799AbTLPQaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:30:16 -0500
Date: Tue, 16 Dec 2003 11:29:50 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <wli@holomorphy.com>, <kernel@kolivas.org>,
       <chris@cvine.freeserve.co.uk>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031216112307.GA5041@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0312161126520.19925-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Roger Luethi wrote:

> One potential problem with the benchmarks is that my test box has
> just one bar with 256 MB RAM. The kbuild and efax tests were run with
> mem=64M and mem=32M, respectively. If the difference between mem=32M
> and a real 32 MB machine is significant for the benchmark,

Could you try "echo 0 > /proc/sys/vm/lower_zone_protection" ?

I have a feeling that the lower zone protection logic could
be badly messing up systems in the 24-48 MB range, as well
as systems in the 1.5-3 GB range.

This would be because the allocation threshold for the
lower zone would be 30% higher than the high threshold
of the pageout code, meaning that the memory in the lower
zone would be just sitting there, without old pages being
recycled by the pageout code.

In effect, your 32 MB test would have old memory in the
lower 16 MB, without the pageout code reusing that memory
for something more useful, reducing the amount of memory
the system really uses well to something way lower.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

