Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUH2RB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUH2RB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUH2Q70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:59:26 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:28630 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268199AbUH2Q7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:59:09 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408290948.06473.jbarnes@engr.sgi.com>
References: <1093786747.1708.8.camel@mulgrave> 
	<200408290948.06473.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 12:58:22 -0400
Message-Id: <1093798704.10973.15.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 12:48, Jesse Barnes wrote:
> But I think this breaks what the code is supposed to do.  You're right that we 
> shouldn't use cpu_online_map, but we should leave the nodemask in there and 
> fix the code that sets it in the non-NUMA case instead.

Well, let's say it puts back the original behaviour. If you look at even
the NUMA code before these changes, it had cpu_possible_map in there.

I totally agree about fixing NUMA, it looks completely broken to me in
the way it handles cpu maps because node_to_cpumask(i) needs to expand
to cpu_possible_map for initialisation and cpu_online_map for
operation.  Has anyone ever checked NUMA for hotplug CPU?

James


