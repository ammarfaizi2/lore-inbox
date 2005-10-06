Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVJFPrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVJFPrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVJFPrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:47:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751100AbVJFPre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:47:34 -0400
Date: Thu, 6 Oct 2005 08:46:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrey Savochkin <saw@sawoct.com>
cc: Andi Kleen <ak@suse.de>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, st@sw.ru, discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
In-Reply-To: <20051006192106.A13978@castle.nmd.msu.ru>
Message-ID: <Pine.LNX.4.64.0510060842190.31407@g5.osdl.org>
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de>
 <20051006174604.B10342@castle.nmd.msu.ru> <Pine.LNX.4.64.0510060750230.31407@g5.osdl.org>
 <20051006192106.A13978@castle.nmd.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Andrey Savochkin wrote:
> 
> I start to wonder about existing mainstream code, presumably bug-free, that
> uses spinlocks without any problematic restart.

Actually, a number of cases where we found things to be a problem have 
been converted.

It _is_ a real-life issue, although with "normal" code it only happens in 
extreme machines (NUMA with tons of nodes). It's fairly fundamental in 
NUMA, and in many ways you do absolutely _not_ want fairness, because it's 
much better to take the lock locally a hundred times (almost free) than it 
is to bounce it back-and-forth between two nodes a hundred times (very 
expensive). 

Fairness is often very expensive indeed.

But places where unfairness can be a problem have been converted to things 
like RCU, which allows concurrent operations more gracefully.

And sometimes the answer is just "don't do that then".

		Linus
