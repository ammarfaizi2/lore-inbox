Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWGNDAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWGNDAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWGNDAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:00:07 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:33207 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161193AbWGNDAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:00:05 -0400
Date: Thu, 13 Jul 2006 19:59:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, alokk@calsoftinc.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <20060713195419.a955b6dd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607131957240.31912@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
 <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu>
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org> <1152818472.3024.75.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
 <20060713161620.f61d2ac0.akpm@osdl.org> <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
 <20060713195419.a955b6dd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Andrew Morton wrote:

> > How would this slab become corrupted if it is no longer on the lists?
> 
> It's a bad sign that this question is flowing in the you->me direction ;)

Take it as a rhetorical question reflecting my lack of details about this 
issue.
> 
> I don't see anywhere under slab_destroy() where *cachep state gets altered.
> 
> The change did cause
> free_block->slab_destroy->__cache_free->cache_free_alien to no longer be
> called under this slab's l3->list_lock.  Maybe that locking is
> (accidentally?) protecting something?

Yes this is also protecting the shared array. It is invalid to use 
free_block on elements of the shared array. It is valid to use free block 
on per cpu arrays since they are protected only by interrupt disable. It 
also valid to use free_block on alien caches because they have their own 
lock.

Still looking.....

