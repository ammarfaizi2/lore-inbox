Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUJCFmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUJCFmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 01:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUJCFmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 01:42:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:55495 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264396AbUJCFmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 01:42:04 -0400
Date: Sat, 2 Oct 2004 22:39:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041002223940.69c7c1db.pj@sgi.com>
In-Reply-To: <415F8A47.5010305@bigpond.net.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<20041002201933.41e4cdc4.pj@sgi.com>
	<415F77A7.4070207@bigpond.net.au>
	<20041002214715.6d60813d.pj@sgi.com>
	<415F8A47.5010305@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> 
> Provided overlapping sets are allowed it should be feasible.  However, 
> I'm not a big fan of overlapping sets as it would make using different 
> CPU scheduling configurations in each set more difficult (maybe even 
> inadvisable) but that's a different issue.

One can resolve these apparently conflicting objectives by having the
scheduling configuration apply to an entire subtree of the cpuset
hierarchy.  When cpuset "a/b" is created below cpuset "a", by
default cpuset "a/b" should get reference counted links to the same
scheduler and other CKRM policies as "a" had.

Then details about what happens further down the cpuset tree, as leaf
nodes come and go, overlapping with their parents, in order to emulate
the old affinity calls, don't confuse the scheduling configuration,
which applies across the same broad swath of CPUs before the affinity
call as after.

You don't need all the cpusets non-overlapping, you just need the
ones that define the realm of a particular scheduling policy to be
non-overlapping (or to tolerate the confusions that result if they
aren't, if that's preferrable - I don't know that it is.)

Indeed, the simple act of an individual task tweaking its own CPU or
Memory affinity should _not_ give it a different scheduling realm. 
Rather such a task must remain stuck in whatever realm it was in before
that affinity call.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
