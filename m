Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVDDGkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDDGkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDDGkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:40:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5064 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261561AbVDDGkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:40:00 -0400
Date: Sun, 3 Apr 2005 23:38:16 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, kenneth.w.chen@intel.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403233816.71a6dd4b.pj@engr.sgi.com>
In-Reply-To: <1112594184.5077.9.camel@npiggin-nld.site>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403152413.GA26631@elte.hu>
	<20050403160807.35381385.pj@engr.sgi.com>
	<4250A195.5030306@yahoo.com.au>
	<20050403205558.753f2b55.pj@engr.sgi.com>
	<1112594184.5077.9.camel@npiggin-nld.site>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> In a sense, the information *is* already there - in node_distance.
> What I think should be done is probably to use node_distance when
> calculating costs, ...

Hmmm ... perhaps I'm confused, but this sure sounds like the alternative
implementation of cpu_distance using node_distance that I submitted to
this thread about 16 hours ago.  It was using this alternative that
got me the more varied matrix:

---------------------
          [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]
[00]:     -     4.0(0) 21.7(1) 21.7(1) 25.2(2) 25.2(2) 25.3(3) 25.3(3)
[01]:   4.0(0)    -    21.7(1) 21.7(1) 25.2(2) 25.2(2) 25.3(3) 25.3(3)
[02]:  21.7(1) 21.7(1)    -     4.0(0) 25.3(3) 25.3(3) 25.2(2) 25.2(2)
[03]:  21.7(1) 21.7(1)  4.0(0)    -    25.3(3) 25.3(3) 25.2(2) 25.2(2)
[04]:  25.2(2) 25.2(2) 25.3(3) 25.3(3)    -     4.0(0) 21.7(1) 21.7(1)
[05]:  25.2(2) 25.2(2) 25.3(3) 25.3(3)  4.0(0)    -    21.7(1) 21.7(1)
[06]:  25.3(3) 25.3(3) 25.2(2) 25.2(2) 21.7(1) 21.7(1)    -     4.0(0)
[07]:  25.3(3) 25.3(3) 25.2(2) 25.2(2) 21.7(1) 21.7(1)  4.0(0)    -
---------------------

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
