Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTHYPzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTHYPzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:55:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5585 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261484AbTHYPzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:55:01 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Erich Focht <efocht@hpce.nec.com>, Andi Kleen <ak@muc.de>, mingo@elte.hu
Subject: Re: [patch 2.6.0t4] 1 cpu/node scheduler fix
Date: Mon, 25 Aug 2003 10:54:36 -0500
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@osdl.org
References: <200308241913.24699.efocht@hpce.nec.com>
In-Reply-To: <200308241913.24699.efocht@hpce.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308251054.36216.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This simple patch is not meant as opposition to Andrew's attempt to
> NUMAize the whole scheduler. That one will definitely make NUMA
> coders' lives easier but I fear that it is a bit too complex for
> 2.6. 

I would agree, it's probably too much to change this late in 2.6.  Eventually 
(2.7) I think we should revisit this and try for a more unified approach.  

> The attached small incremental change is sufficient to solve the
> main problem. Besides, the change of the cross-node scheduling is
> compatible with Andrew's scheduler structure. I really don't like the
> timer-based cross-node balancing because it is too unflexible (no way
> to have different balancing intervals for each node) and I'd really
> like to get back to just one single point of entry for load balancing:
> the routine load_balance(), no matter whether we balance inside a
> timer interrupt or while the CPU is going idle.

Looks good to me.  One other thing your patch fixes:  Once in a while we 
called load_balance in rebalance_tick with the wrong 'idle' value.  
Occasionally we would be on an idle_node and idle_cpu rebalance tick, the 
idle cpu would [possibly] pull a task, become non-idle, then we would call 
load_balance again, but still have idle=1 for the intranode balance.  

