Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUC3HRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUC3HRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:17:10 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:31937 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262647AbUC3HPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:15:33 -0500
Date: Mon, 29 Mar 2004 23:13:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>
cc: mingo@elte.hu, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <205870000.1080630837@[10.10.2.4]>
In-Reply-To: <40691BCE.2010302@yahoo.com.au>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>	<20040325154011.GB30175@wotan.suse.de>	<20040325190944.GB12383@elte.hu>	<20040325162121.5942df4f.ak@suse.de>	<20040325193913.GA14024@elte.hu>	<20040325203032.GA15663@elte.hu>	<20040329084531.GB29458@wotan.suse.de>	<4068066C.507@yahoo.com.au>	<20040329080150.4b8fd8ef.ak@suse.de>	<20040329114635.GA30093@elte.hu>	<20040329221434.4602e062.ak@suse.de>	<4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We are not going to go back to the wild balancing that
> numasched does (I have some benchmarks where sched-domains
> reduces cross node task movement by several orders of
> magnitude). 

Agreed, I think that'd be a fatal mistake ...

> So the other option is to do balance on clone
> across NUMA nodes, and make it very sensitive to imbalance.
> Or probably better to make it easy to balance off to an idle
> CPU, but much more difficult to balance off to a busy CPU.

I think that's correct, but we need to be careful. We really, really 
do want to try to keep threads on the same node *if* we have enough 
processes around to keep the machine busy. Because we don't balance
on fork, we make a reasonable job of that today, but we should probably
be more reluctant on rebalance than we are.

It's when we have less processes than nodes that we want to spread things 
around. That's a difficult balance to strike (and exactly why I wimped 
out on it originally ;-)).

M.

