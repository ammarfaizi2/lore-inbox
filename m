Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbTHYRuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbTHYRuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:50:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54491 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262079AbTHYRuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:50:06 -0400
Date: Mon, 25 Aug 2003 10:38:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>, Andi Kleen <ak@muc.de>, mingo@elte.hu
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>,
       Andrew Theurer <habanero@us.ibm.com>, torvalds@osdl.org
Subject: Re: [patch 2.6.0t4] 1 cpu/node scheduler fix
Message-ID: <4490000.1061833107@flay>
In-Reply-To: <200308241913.24699.efocht@hpce.nec.com>
References: <200308241913.24699.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the 1 cpu/node fix of the NUMA scheduler rewritten for the new
> cpumask handling. The previous version was a bit too aggressive with
> cross node balancing so I changed the default timings a bit such that
> the behavior is very similar to the old one.
> 
> Here is what the patch does:
> - Links the frequency of cross-node balances to the number of failed
> local balance attempts. This simplifies the code by removing the too
> rigid cross-node balancing dependency of the timer interrupts.
> 
> - Fixes the 1 CPU/node issue, i.e. eliminates local balance attempts
> for the nodes which have only one CPU. Can happen on any NUMA
> platform (playing around with a 2 CPU/node box and have a flaky CPU,
> so I have sometimes a node with only one CPU), is a major issue on
> AMD64.
> 
> - Makes the cross-node balance frequency tunable by the parameter
> NUMA_FACTOR_BONUS. Its default setting is such that the scheduler
> behaves like before: cross node balance every 5 local node balances on
> an idle CPU, every 2 local node balances on a busy CPU. This parameter
> should be tuned for each platform depending on its NUMA factor.

This seems to clear up the low end stuff I was seeing before - thanks.

Did you (or anyone else) get a chance to test this on AMD? Would
be nice to confirm that's fixed ...

M.

