Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUC3IFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUC3IFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:05:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40623 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263371AbUC3IFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:05:03 -0500
Date: Tue, 30 Mar 2004 10:05:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@suse.de>,
       jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040330080530.GA22195@elte.hu>
References: <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au> <205870000.1080630837@[10.10.2.4]> <4069223E.9060609@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4069223E.9060609@yahoo.com.au>
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

> Maybe balance on clone would be beneficial if we only balance onto
> CPUs which are idle or very very imbalanced. Basically, if you are
> very sure that it is going to be balanced off anyway, it is probably
> better to do it at clone.

balancing threads/processes is not a problem, as long as it happens
within the rules of normal balancing.

ie. 'new context created' (on exec, fork or clone) is just an event that
impacts the load scenario, and which might trigger rebalancing.

_if_ the sharing between various contexts is very high and it's actually
faster to run them all single-threaded, then the application writer can
bind them to one CPU, via the affinity syscalls. But the scheduler
cannot know this advance.

so the cleanest assumption, from the POV of the scheduler, is that
there's no sharing between contexts. Things become really simple once
this assumption is made.

and frankly, it's much easier to argue with application developers whose
application scales badly and thus the scheduler over-distributes it,
than with application developers who's application scales badly due to
the scheduler.

	Ingo
