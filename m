Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUCYV7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUCYV7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:59:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22226 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263626AbUCYV7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:59:02 -0500
Date: Thu, 25 Mar 2004 22:59:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040325215908.GA19313@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325154011.GB30175@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> It doesn't do load balance in wake_up_forked_process() and is
> relatively non aggressive in balancing later. This leads to the
> multithreaded OpenMP STREAM running its childs first on the same node
> as the original process and allocating memory there. Then later they
> run on a different node when the balancing finally happens, but
> generate cross traffic to the old node, instead of using the memory
> bandwidth of their local nodes.
> 
> The difference is very visible, even the 4 thread STREAM only sees the
> bandwidth of a single node. With a more aggressive scheduler you get 4
> times as much.
> 
> Admittedly it's a bit of a stupid benchmark, but seems to
> representative for a lot of HPC codes.

There's no way the scheduler can figure out the scheduling and memory
use patterns of the new tasks in advance.

but userspace could give hints - e.g. a syscall that triggers a
rebalancing: sys_sched_load_balance(). This way userspace notifies the
scheduler that it is on 'zero ground' and that the scheduler can move it
to the least loaded cpu/node.

a variant of this is already possible, userspace can use setaffinity to
load-balance manually - but sched_load_balance() would be automatic.

	Ingo
