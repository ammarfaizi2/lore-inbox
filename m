Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUCYPkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUCYPkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:40:18 -0500
Received: from ns.suse.de ([195.135.220.2]:2016 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263203AbUCYPkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:40:14 -0500
Date: Thu, 25 Mar 2004 16:40:11 +0100
From: Andi Kleen <ak@suse.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, Rick Lindsley <ricklind@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040325154011.GB30175@wotan.suse.de>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 07:31:37AM -0800, Nakajima, Jun wrote:
> Andi,
> 
> Can you be more specific with "it doesn't load balance threads
> aggressively enough"? Or what behavior of the base NUMA scheduler is
> missing in the sched-domain scheduler especially for NUMA?

It doesn't do load balance in wake_up_forked_process()  and is relatively
non aggressive in balancing later. This leads to the multithreaded OpenMP
STREAM running its childs first on the same node as the original process
and allocating memory there. Then later they run on a different node when
the balancing finally happens, but generate  cross traffic to the old node, 
instead of using the memory bandwidth of their local nodes.

The difference is very visible, even the 4 thread STREAM only sees the
bandwidth of a single node. With a more aggressive scheduler you get
4 times as much.

Admittedly it's a bit of a stupid benchmark, but seems to representative
for a lot of HPC codes.

-Andi
