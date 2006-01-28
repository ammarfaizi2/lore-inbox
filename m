Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWA1AW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWA1AW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWA1AWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:22:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422728AbWA1AWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:22:54 -0500
Date: Fri, 27 Jan 2006 19:22:15 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, lock validator] fix uidhash_lock <-> RCU deadlock
In-Reply-To: <20060126111352.GF4953@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0601271920000.3192@evo.osdl.org>
References: <20060125142307.GA5427@elte.hu> <20060126111352.GF4953@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Jan 2006, Paul E. McKenney wrote:
>
> On Wed, Jan 25, 2006 at 03:23:07PM +0100, Ingo Molnar wrote:
> > RCU task-struct freeing can call free_uid(), which is taking 
> > uidhash_lock - while other users of uidhash_lock are softirq-unsafe.
> 
> I guess I get to feel doubly stupid today.  Good catch, great tool!!!

I wonder if the right fix wouldn't be to free the user struct early, 
instead of freeing it from RCU. Hmm?

		Linus
