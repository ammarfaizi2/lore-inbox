Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUBCLMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 06:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUBCLMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 06:12:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64958 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265978AbUBCLMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 06:12:00 -0500
Date: Tue, 3 Feb 2004 12:12:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Message-ID: <20040203111236.GA8508@elte.hu>
References: <200401291917.42087.kernel@kolivas.org> <200402032152.46481.kernel@kolivas.org> <20040203105758.GA7783@elte.hu> <200402032207.38006.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402032207.38006.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> > for lowprio tasks they are of little use, unless you modify gcc to
> > sprinkle mwait yields all around the 'lowprio code' - not very practical
> > i think.
> 
> Yuck!
> 
> Looks like the kernel is the only thing likely to be smart enough to
> do this correctly for some time yet. 

no, there's no way for the kernel to do this 'correctly', without
further hardware help. mwait is suspending the current virtual CPU a bit
better than rep-nop did. This can be exploited for the idle loop because
the idle loop does nothing so it can execute the rep-nop. (mwait can
likely also be used for spinlocks but that is another issue.)

user-space code that is 'low-prio' cannot be slowed down via mwait,
without interleaving user-space instructions with mwait (or with
rep-nop).

this is a problem area that is not solved by mwait - giving priority to
virtual CPUs should be offered by CPUs, once the number of logical cores
increases significantly - if the interaction between those cores is
significant. (there are SMT designs where this isnt an issue.)

	Ingo
