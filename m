Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031361AbWKUUEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031361AbWKUUEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031376AbWKUUEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:04:52 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:10650 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1031361AbWKUUEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:04:51 -0500
Date: Tue, 21 Nov 2006 23:04:41 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121200441.GA341@oleg>
References: <20061120185712.GA95@oleg> <Pine.LNX.4.44L0.0611201439350.7569-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201439350.7569-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20, Alan Stern wrote:
>
> On Mon, 20 Nov 2006, Oleg Nesterov wrote:
> 
> > So, if we have global A == B == 0,
> > 
> > 	CPU_0		CPU_1
> > 
> > 	A = 1;		B = 2;
> > 	mb();		mb();
> > 	b = B;		a = A;
> > 
> > It could happen that a == b == 0, yes?
> 
> 	Both CPUs execute their "mb" instructions.  The mb forces each
> 	cache to wait until it receives an Acknowdgement for the 
> 	Invalidate it sent.
> 
> 	Both caches send an Acknowledgement message to the other.  The
> 	mb instructions complete.
> 
> 	"b = B" and "a = A" execute.  The caches return A==0 and B==0
> 	because they haven't yet invalidated their cache lines.
> 
> The reason the code failed is because the mb instructions didn't force
> the caches to wait until the Invalidate messages in their queues had been 
> fully carried out (i.e., the lines had actually been invalidated).

However, from
	http://marc.theaimsgroup.com/?l=linux-kernel&m=113435711112941

Paul E. McKenney wrote:
>
> 2.      rmb() guarantees that any changes seen by the interconnect
>         preceding the rmb() will be seen by any reads following the
>         rmb().
>
> 3.      mb() combines the guarantees made by rmb() and wmb().

Confused :(

Oleg.

