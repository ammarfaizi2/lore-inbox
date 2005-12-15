Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbVLODqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVLODqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVLODqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:46:14 -0500
Received: from waste.org ([64.81.244.121]:50364 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1161014AbVLODqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:46:13 -0500
Date: Wed, 14 Dec 2005 19:39:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051215033937.GC11856@waste.org>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com> <20051214092228.GC18862@brahms.suse.de> <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:55:45AM -0800, Sridhar Samudrala wrote:
> On Wed, 2005-12-14 at 10:22 +0100, Andi Kleen wrote:
> > > I would appreciate any feedback or comments on this approach.
> > 
> > Maybe I'm missing something but wouldn't you need an own critical
> > pool (or at least reservation) for each socket to be safe against deadlocks?
> > 
> > Otherwise if a critical sockets needs e.g. 2 pages to finish something
> > and 2 critical sockets are active they can each steal the last pages
> > from each other and deadlock.
> 
> Here we are assuming that the pre-allocated critical page pool is big enough
> to satisfy the requirements of all the critical sockets.

Not a good assumption. A system can have between 1-1000 iSCSI
connections open and we certainly don't want to preallocate enough
room for 1000 connections to make progress when we might only have one
in use.

I think we need a global receive pool and per-socket send pools.

-- 
Mathematics is the supreme nostalgia of our time.
