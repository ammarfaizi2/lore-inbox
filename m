Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161290AbWG1UhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161290AbWG1UhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161291AbWG1UhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:37:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29081 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161290AbWG1UhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:37:16 -0400
Date: Fri, 28 Jul 2006 13:36:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       alokk@calsoftinc.com, kiran@scalex86.org
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
In-Reply-To: <1154118947.10196.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain> 
 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com> 
 <1154067247.27297.104.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com> 
 <1154117501.10196.2.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com> 
 <1154118476.10196.5.camel@localhost.localdomain> <1154118947.10196.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006, Thomas Gleixner wrote:

> Let me know, if you need more info

What type of NUMA system is this? How many nodes? Is memory exhausted on 
some so that allocations are redirected? Are cpusets or memory policies
used to redirect allocations?
 
Maybe we get confused about local and remote objects due to fallback and 
contamination of the per node lists with foreign node objects. I have a 
patch here that make the slab allocations not fall back and insures that 
cpuset do not interfere but it involves patching the page 
allocator to not do fallback for slab allocations.

Lets see if we can figure this one out first.
