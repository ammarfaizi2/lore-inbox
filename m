Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWHFBjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWHFBjE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 21:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWHFBjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 21:39:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57225 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751478AbWHFBjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 21:39:02 -0400
Date: Sat, 5 Aug 2006 18:38:42 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       Simon.Derr@bull.net, steiner@sgi.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-Id: <20060805183842.a23a46cb.pj@sgi.com>
In-Reply-To: <20060802143611.A19038@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0>
	<20060731071242.GA31377@elte.hu>
	<20060731090440.A2311@unix-os.sc.intel.com>
	<20060731095429.d2b8801d.pj@sgi.com>
	<20060731101542.A2817@unix-os.sc.intel.com>
	<20060801235752.28519bda.pj@sgi.com>
	<20060802143611.A19038@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> Paul, I will answer your questions on Suse bugzilla as that is a better
> forum than lkml.

Well ... can't say I ever got answers to some of my questions.

But the critical one was answered - what patch(es) do I need
to fix this memory corruption problem on SLES10 kernels.

Earlier, Suresh had recommended [numbers added by pj]:
> Basically SLES10 has to backport all these patches:
> 
> 1) sched: fix group power for allnodes_domains
> 2) sched_domai: Allocate sched_group structures dynamically
> 3) sched: build_sched_domains() fix


Only two of these three patches are needed for this memory corruption
bug:

  1) sched: fix group power for allnodes_domains
  3) sched: build_sched_domains() fix

Patch (2) addresses a separate problem, and has been reworked since
anyway, and was the one that caused me grief backporting SLES10 as it
depended on other patches not in SLES10.

The key fix for the memory corruption is in patch (1).  This patch went
into Linus's tree on March 28, 2006.  Patch (3) fixed a bug introduced
in the first patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
