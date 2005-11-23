Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVKWTkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVKWTkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKWTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:40:52 -0500
Received: from fmr24.intel.com ([143.183.121.16]:49568 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932239AbVKWTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:40:52 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 11:46:34 -0800
Message-Id: <1132775194.25086.54.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 19:39:36.0483 (UTC) FILETIME=[A2DF3F30:01C5F065]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 11:30 -0800, Christoph Lameter wrote:
> On Tue, 22 Nov 2005, Rohit Seth wrote:
> 
> > [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> > local pcp lists when a higher order allocation request is not able to 
> > get serviced from global free_list.
> 
> Ummm.. One controversial idea: How about removing the complete pcp 
> subsystem? Last time we disabled pcps we saw that the effect 
> that it had was within noise ratio on AIM7. The lru lock taken without 
> pcp is in the local zone and thus rarely contended.

Oh please stop.

This per_cpu_pagelist is one great logic that has got added in
allocator.  Besides providing pages without the need to acquire the zone
lock, it is one single main reason the coloring effect is drastically
reduced in 2.6 (over 2.4) based kernels.

-rohit

