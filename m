Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVL2Qq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVL2Qq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVL2Qq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:46:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17596 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750829AbVL2Qq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:46:26 -0500
Date: Thu, 29 Dec 2005 11:46:25 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
In-reply-to: <20051229083333.GA31003@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512291142510.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
 <1135685158.2926.22.camel@laptopd505.fenrus.org>
 <20051227131501.GA29134@elte.hu>
 <Pine.LNX.4.64.0512282222400.3309@localhost.localdomain>
 <20051229083333.GA31003@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Ingo Molnar wrote:

> > I'd solve it like this instead (on top of your latest patches):
> 
> thanks, applied.
> 
> > +		"1: ldrex	%0, [%3]	\n"
> > +		"subs		%1, %0, #1	\n"
> > +		"strexeq	%2, %1, [%3]	\n"
> > +		"movlt		%0, #0		\n"
> > +		"cmpeq		%2, #0		\n"
> > +		"bgt		1b		\n"
> 
> so we are back to what is in essence a cmpxchg implementation?

A limited cmpxchg.  Using the generic cmpxchg for this would need either 
9 or 10 instructions instead of 6.


Nicolas
