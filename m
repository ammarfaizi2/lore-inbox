Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTL1L6q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbTL1L6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:58:46 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:12202 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S265083AbTL1L6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:58:44 -0500
Date: Sun, 28 Dec 2003 12:58:22 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@surriel.com, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-ID: <20031228115822.GB4847@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, riel@surriel.com,
	torvalds@osdl.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com> <20031226190045.0f4651f3.akpm@osdl.org> <20031227230757.GA25229@k3.hellgate.ch> <20031227160410.754c5ce1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227160410.754c5ce1.akpm@osdl.org>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 16:04:10 -0800, Andrew Morton wrote:
> > Having all processes blocked is indeed one problem of 2.6 under memory
> > pressure. I don't know what the cause is, though.
> 
> I usually work this sort of thing out by "random sampling".  When
> everything is in steady state, break into kgdb and start looking at task
> backtraces, see where they are all sleeping.

Well, there isn't really a steady state as such. On a loaded system
there are periods during compile benchmarks where the system spends
half the time and more in I/O wait, so some processes do get to run
and do some minimal amount of work.

> If it's in the pagefault handler, go up to do_page_fault() and work out the
> faulting address.  Compare that with /proc/pid/maps to see if it's libc or
> whatever.
> 
> Repeat the above N times until you have a decent feel for what's happening
> in there.  It doesn't take long.

I instrumented the kernel a while ago to log page fault handling
(address, backing file if available) when the system became idle with
all processes blocked. I can resurrect that code which would allow for
larger samples. I'll post results if/when I get around to do it.

Roger
