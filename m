Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbUC3Iof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbUC3Iof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:44:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1213 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263440AbUC3Iod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:44:33 -0500
Date: Tue, 30 Mar 2004 10:45:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040330084501.GA23069@elte.hu>
References: <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au> <205870000.1080630837@[10.10.2.4]> <4069223E.9060609@yahoo.com.au> <20040330080530.GA22195@elte.hu> <40692D95.8030605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40692D95.8030605@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> You're probably mostly right, but I really don't know if I'd start
> with the assumption that threads don't share anything. I think they're
> very likely to share memory and cache.

it all depends on the workload i guess, but generally if the application
scales well then the threads only share data in a read-mostly manner -
hence we can balance at creation time.

if the application does not scale well then balancing too early cannot
make the app perform much worse.

things like JVMs tend to want good balancing - they really are userspace
simulations of separate contexts with little sharing and good overall
scalability of the architecture.

> Also, these additional system wide balance points don't come for free
> if you attach them to common operations (as opposed to the slow
> periodic balancing).

yes, definitely.

the implementation in sched2.patch does not take this into account yet. 
There are a number of things we can do about the 500 CPUs case. Eg. only
do the balance search towards the next N nodes/cpus (tunable via a
domain parameter).

	Ingo
