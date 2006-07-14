Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbWGNDpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWGNDpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWGNDpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:45:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36837 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161234AbWGNDpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:45:50 -0400
Date: Thu, 13 Jul 2006 20:45:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, alokk@calsoftinc.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <Pine.LNX.4.64.0607132009520.32134@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0607132040550.32134@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
 <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu>
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org> <1152818472.3024.75.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
 <20060713161620.f61d2ac0.akpm@osdl.org> <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0607131944260.31824@schroedinger.engr.sgi.com>
 <20060713200234.d30cf1b8.akpm@osdl.org> <Pine.LNX.4.64.0607132009520.32134@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Christoph Lameter wrote:

> The fix by removing the dropping of the lock in free_block could cause 
> retaking the list_lock that we already hold in the OFF_SLAB case (even in 
> the non NUMA case). 

That retaking only occurs if the general slab cache used for the cache 
management is the same general slab where we are freeing from.

Otherwise we are acquiring the list_locks of two distinct slab caches 
which may introduce an issue of lock ordering.

So reversing the patch seems to be the right measure after all. But we 
have the two weird locking scenarios above.
