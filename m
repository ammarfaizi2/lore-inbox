Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUH2RLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUH2RLf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUH2RLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:11:34 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:50923 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268216AbUH2RKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:10:45 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: James Bottomley <James.Bottomley@SteelEye.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040829170328.GK5492@holomorphy.com>
References: <1093786747.1708.8.camel@mulgrave>
	<200408290948.06473.jbarnes@engr.sgi.com> 
	<20040829170328.GK5492@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 13:09:49 -0400
Message-Id: <1093799390.10990.19.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 13:03, William Lee Irwin III wrote:
> -#define node_to_cpumask(node)	(cpu_online_map)
> +#define node_to_cpumask(node)	(cpu_possible_map)

I really don't think so.  This macro is also used at runtime, so there
it would return CPUs that aren't online.

It does look like all runtime uses in sched.c pass node_to_cpumask
through any_online_cpu(), so at least for the scheduler, the change may
be safe, but you'd have to audit all other runtime uses.

James


