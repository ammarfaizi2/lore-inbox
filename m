Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUJFBvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUJFBvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUJFBvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:51:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:9362 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266674AbUJFBve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:51:34 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <52r7ocra4q.fsf@topspin.com>
References: <1096922369.2666.177.camel@cube>
	 <200410041926.57205.jbarnes@sgi.com> <1096945479.24537.15.camel@gaston>
	 <200410050833.49654.jbarnes@engr.sgi.com>
	 <1097016099.27222.14.camel@gaston>  <52r7ocra4q.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1097027142.16744.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 11:45:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 09:57, Roland Dreier wrote:

> I could be wrong but I think that the eieio in the ppc IO write
> functions should be strong enough that mmiowb() can be a no-op.
> 
> By the way, are the ordering rules different for ppc32 and ppc64?  I
> notice that the ppc32 out_xxx() functions do eieio while the ppc64
> versions do a full sync.

ppc32 and ppc64 are identical by spec, but the current chips smaller
store queues are such that we didn't epxerience on ppc32 the amount
of issues we had on ppc64.

eieio will not order a cacheable store vs. a non-cacheable store by
spec, which is the root of our problem on ppc and why we had to change
some of these into sync's. Extended the semantics of mmiowb() to a more
generic ordering of MMIO vs. "the rest of the world" would help us as
I don't beleive in defining yet-another barrier and have it properly
used by device driver writers.

Ben.


