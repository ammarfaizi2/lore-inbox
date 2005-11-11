Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVKKDsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVKKDsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKKDsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:48:16 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:48611 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932331AbVKKDsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:48:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [RFC, PATCH] Slab counter troubles with swap prefetch?
Date: Fri, 11 Nov 2005 14:50:07 +1100
User-Agent: KMail/1.8.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, alokk@calsoftinc.com
References: <Pine.LNX.4.62.0511101351120.16380@schroedinger.engr.sgi.com> <200511111007.12872.kernel@kolivas.org> <Pine.LNX.4.62.0511101510240.16588@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511101510240.16588@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111450.07396.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 10:13 am, Christoph Lameter wrote:
> On Fri, 11 Nov 2005, Con Kolivas wrote:
> > > This patch splits the counter into the nr_local_slab which reflects
> > > slab pages allocated from the local zones (and this number is useful
> > > at least as a guidance for the VM) and the remotely allocated pages.
> >
> > How large a contribution is the remote slab size likely to be? Would this
> > information be useful to anyone potentially in future code besides swap
> > prefetch? The nature of prefetch is that this is only a fairly coarse
> > measure of how full the vm is with data we don't want to displace. Thus
> > it is also not important that it is very accurate.
>
> The size of the remote cache depends on many factors. The application can
> influence that by setting memory policies.
>
> > Unless the remote slab size can be a very large contribution, or having
> > local
>
> Yes it can be quite large. On some of my tests with applications these are
> 100%. This is typical if the application sets the policy in such a way
> that all allocations are off node or if the kernel has to allocate memory
> on a certain node for a device.

One last thing. Swap prefetch works off the accounting of total memory and is 
only a single kernel thread rather than a thread per cpu or per pgdat unlike 
kswapd. Currently it just cares about total slab data and total ram. 
Depending on where this thread is scheduled (which node) your accounting 
change will alter the behaviour of it. Does this affect the relevance of this 
patch to you?

Cheers,
Con
