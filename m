Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVK2JiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVK2JiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVK2JiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:38:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61651 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751023AbVK2JiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:38:21 -0500
To: thockin@hockin.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
References: <1133179554.11491.3.camel@localhost.localdomain>
	<20051128173040.GA32547@hockin.org>
	<1133199568.7416.31.camel@mindpipe> <20051128183517.GA4549@hockin.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Nov 2005 07:06:24 -0700
In-Reply-To: <20051128183517.GA4549@hockin.org>
Message-ID: <p73r78zh7kv.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thockin@hockin.org writes:

> On Mon, Nov 28, 2005 at 12:39:28PM -0500, Lee Revell wrote:
> > On Mon, 2005-11-28 at 09:30 -0800, thockin@hockin.org wrote:
> > > The kernel's use of TSC is wholly incorrect.  TSCs can ramp up and
> > > down and *do* vary between nodes as well as between cores within a
> > > node.  You really can not compare TSCs between cpu cores at all, as is
> > > (and the kernel assumes 1 global TSC in at least a few places). 
> > 
> > That's one way to look at it; another is that the AMD dual cores have a
> > broken TSC implementation.  The kernel's use of the TSC was never a
> > problem in the past...
> 
> Sure.  But the OS can be fixed, the chips can not.  That said, I'd like to
> see a spec that says TSCs are a) synced, b) linear.

They have specs that say they're not. Intel has specs that say that they
are on newer systems, but at least one chipset breaks it.

Linear they are never because there are MSRs to change them.

But I'm surprised you're saying 2.6.11 broke. At least 2.6.11 64bit should
have always used HPET in this case. I only broke it around 2.6.13
where I added an overeager optimization for single socket DC on my side based
on a misunderstanding. Earlier and later kernels should have been ok.

32bit might have been different.

-Andi
