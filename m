Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWAFWeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWAFWeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWAFWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:34:11 -0500
Received: from cantor.suse.de ([195.135.220.2]:24556 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932275AbWAFWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:34:02 -0500
From: Andi Kleen <ak@suse.de>
To: paulmck@us.ibm.com
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
Date: Fri, 6 Jan 2006 21:57:41 +0100
User-Agent: KMail/1.8.2
Cc: Eric Dumazet <dada1@cosmosbay.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
References: <20060105235845.967478000@sorel.sous-sol.org> <43BEA693.5010509@cosmosbay.com> <20060106202626.GA5677@us.ibm.com>
In-Reply-To: <20060106202626.GA5677@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062157.42470.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 21:26, Paul E. McKenney wrote:

> If not, it may be worthwhile to limit the number of times that
> rt_run_flush() runs per RCU grace period.

Problem is that without rt_run_flush new routes and route attribute
changes don't get used by the stack. If RCU takes long and routes
keep changing this might be a big issue.

As a admin I would be certainly annoyed if the network stack
ignored my new route for some unbounded time.

Perhaps a better way would be to just exclude dst entries in RCU state
from the normal accounting and assume that if the system
really runs short of memory because of this the results would
trigger quiescent states more quickly, freeing the memory again.

-Andi
