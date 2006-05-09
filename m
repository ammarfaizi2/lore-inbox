Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWEIGBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWEIGBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWEIGBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:01:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3735 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750983AbWEIGBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:01:08 -0400
Date: Mon, 8 May 2006 23:01:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Add SYSTEM_BOOTING_KMALLOC_AVAIL system_state
In-Reply-To: <20060508224952.0b43d0fd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605082259510.23978@schroedinger.engr.sgi.com>
References: <20060509053512.GA20073@monkey.ibm.com> <20060508224952.0b43d0fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Andrew Morton wrote:

> >  SYSTEM_BOOTING to SYSTEM_RUNNING well after the bootmem allocator
> >  is no longer usable.  Introduce the SYSTEM_BOOTING_KMALLOC_AVAIL
> >  state which indicates the kmalloc allocator is available for use.
> 
> Let's not do this - system_state is getting out of control.
> 
> How about some private boolean in slab.c, and some special allocation
> function like
> 
> void __init *alloc_memory_early(size_t size, gfp_t gfp_flags)
> {
> 	if (slab_is_available)
> 		return kmalloc(size, gfp_flags);
> 	return alloc_bootmem(size);
> }	

You may use g_cpucache_up to check the state of the slab allocator.

