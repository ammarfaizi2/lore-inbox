Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUH2Rtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUH2Rtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUH2Rto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:49:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20178 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268231AbUH2Rtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:49:41 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: Nathan Lynch <nathanl@austin.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093800241.1708.25.camel@mulgrave>
References: <1093786747.1708.8.camel@mulgrave>
	 <200408290948.06473.jbarnes@engr.sgi.com>
	 <1093798704.10973.15.camel@mulgrave>
	 <200408291007.50553.jbarnes@engr.sgi.com>
	 <1093800241.1708.25.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1093801714.29741.15.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 12:48:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 12:24, James Bottomley wrote:
> On Sun, 2004-08-29 at 13:07, Jesse Barnes wrote:
> > I've up and downed a few CPUs on an Altix, and it seems to work ok, but that's 
> > a pretty basic test.  How about this?
> 
> Incidentally, down and up tests won't pick up these initialisation
> problems because the SMP paths will already have created the start of
> day data structures for these CPUs.  You need to boot with the CPU down
> and bring it up after boot to see the issues.

I've got a patch which reinitializes sched domains at cpu hotplug time. 
We need something like this on ppc64 for partitioned systems (we run
into the same issue when adding a cpu which wasn't present at boot).  I
had been waiting to post it until some cpu hotplug issues with preempt
were solved, but it seems it would help the case of hotplugging
secondary cpus at boot, so I'll submit that soon.

Nathan


