Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUH2XBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUH2XBw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUH2XBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:01:52 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:37593 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268360AbUH2XAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:00:21 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093801714.29741.15.camel@booger>
References: <1093786747.1708.8.camel@mulgrave>
	<200408290948.06473.jbarnes@engr.sgi.com>
	<1093798704.10973.15.camel@mulgrave>
	<200408291007.50553.jbarnes@engr.sgi.com>
	<1093800241.1708.25.camel@mulgrave>  <1093801714.29741.15.camel@booger>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 18:59:49 -0400
Message-Id: <1093820392.1708.73.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 13:48, Nathan Lynch wrote:
> I've got a patch which reinitializes sched domains at cpu hotplug time. 
> We need something like this on ppc64 for partitioned systems (we run
> into the same issue when adding a cpu which wasn't present at boot).  I
> had been waiting to post it until some cpu hotplug issues with preempt
> were solved, but it seems it would help the case of hotplugging
> secondary cpus at boot, so I'll submit that soon.

Well, but the only time you should need to alter a priori knowledge like
this is if you're actually altering the NUMA topology, isn't it?  Simply
bringing up a CPU in a known numa system shouldn't need to alter
scheduling domain information on CPU hotplug because the cpu
automatically becomes part of an existing domain (where it was
originally accounted for as missing).

However, if you hotplug a numa node, then you're adding to the
scheduling domain and would thus need to initialise the new node and its
CPUs.

James


