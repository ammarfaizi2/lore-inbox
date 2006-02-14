Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422853AbWBNXpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWBNXpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWBNXpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:45:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4817 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422853AbWBNXpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:45:00 -0500
Date: Tue, 14 Feb 2006 15:44:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: suresh.b.siddha@intel.com, akpm@osdl.org, kernel@kolivas.org,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-Id: <20060214154432.9a4f8a0c.pj@sgi.com>
In-Reply-To: <43F25C60.4080603@bigpond.net.au>
References: <43ED3D6A.8010300@bigpond.net.au>
	<20060214010712.B20191@unix-os.sc.intel.com>
	<43F25C60.4080603@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> In these circumstances, moving the task 
> to an idle CPU should be a "good thing" unless the time taken for the 
> move is longer than the time that will pass before the task becomes the 
> running task on its current CPU.

Even then, it's not always a "good thing".

The less of the cache-memory hierarchy the two CPUs share, the greater
the penalty to the task for memory accesses after the move.

At one extreme, two hyperthreads on the same core share essentially all
the memory hierarchy, so have no such penalty.

At the other extreme, two CPUs at opposite ends of a big NUMA box have,
so far as performance is concerned, quite different views of the memory
hierarchy.  A task moved to a far away CPU will be cache cold for
several layers of core, package, board, and perhaps router hierarchy,
and have slower access to its main memory pages.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
