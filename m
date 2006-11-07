Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752745AbWKGU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbWKGU7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbWKGU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:59:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16870 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752626AbWKGU7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:59:14 -0500
Date: Tue, 7 Nov 2006 12:59:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061107203147.GB4753@elte.hu>
Message-ID: <Pine.LNX.4.64.0611071258280.5516@schroedinger.engr.sgi.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
 <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>
 <20061107093112.A3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
 <20061107095049.B3262@unix-os.sc.intel.com> <Pine.LNX.4.64.0611071113390.4582@schroedinger.engr.sgi.com>
 <20061107203147.GB4753@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Ingo Molnar wrote:

> Per-CPU tasklets are equivalent to softirqs, with extra complexity and 
> overhead ontop of it :-)
> 
> so please just introduce a rebalance softirq and attach the scheduling 
> rebalance tick to it. But i'd suggest to re-test on the 4096-CPU box, 
> maybe what 'fixed' your workload was the global serialization of the 
> tasklet. With a per-CPU softirq approach we are i think back to the same 
> situation that broke your system before.

What broke the system was the disabling of interrupts over long time 
periods during load balancing.

