Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWGFUdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWGFUdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWGFUdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:33:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbWGFUdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:33:53 -0400
Date: Thu, 6 Jul 2006 13:32:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
cc: Mark Lord <lkml@rtr.ca>, Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <44AD725F.6070005@nortel.com>
Message-ID: <Pine.LNX.4.64.0607061331180.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca>
 <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com>
 <44AD666B.1060500@rtr.ca> <44AD725F.6070005@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Chris Friesen wrote:
> 
> As long as you're not talking to external devices, each cpu must be coherent
> with respect to itself, no?  It's allowed to execute out-of-order, but it
> needs to make sure that by doing so it doesn't cause changes that are visible
> to software.

Right. But then "volatile" won't really matter either, unless you have 
some _ordering_ constraint, in which case "volatile" is not enough unless 
you're guaranteed to be single-threaded.

In other words, again, "volatile" is almost always the wrong thing to 
have, and just makes you _think_ your code is correct.

		Linus
