Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTLQTvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTLQTu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:50:59 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:31175 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S264415AbTLQTu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:50:57 -0500
Date: Wed, 17 Dec 2003 20:49:51 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031217194950.GA9375@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20031216112307.GA5041@k3.hellgate.ch> <Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 13:53:28 -0500, Rik van Riel wrote:
> On Tue, 16 Dec 2003, Roger Luethi wrote:
> 
> > One potential problem with the benchmarks is that my test box has
> > just one bar with 256 MB RAM. The kbuild and efax tests were run with
> > mem=64M and mem=32M, respectively. If the difference between mem=32M
> 
> OK, I found another difference with 2.4.
> 
> Try "echo 256 > /proc/sys/vm/min_free_kbytes", I think
> that should give the same free watermarks that 2.4 has.

I played around with that knob after wli posted his findings in the
"mem=16MB laptop testing" thread. IIRC tweaking min_free_kbytes didn't
help nearly as much as I had hoped. I'm running the efax benchmark
right now just to make sure. It's going to take a couple of hours,
I'll follow up with results.

FWIW akpm posted a patch to initialize min_free_kbytes depending on
available RAM which seemed to make sense but it hasn't made it into
mainline yet.

> Using 1MB as the min free watermark for lowmem is bound
> to result in more free (and less used) memory on systems
> with less than 128 MB RAM ... significantly so on smaller
> systems.

Possibly. If memory pressure is high enough, though, the allocator
ignores the watermarks. And on the other end kswapd seems to be pretty
busy anyway during the benchmarks.

Roger
