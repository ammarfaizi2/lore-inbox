Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWGZLzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWGZLzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWGZLzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:55:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58768 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030280AbWGZLzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:55:51 -0400
Date: Wed, 26 Jul 2006 04:55:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com> <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
 <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka J Enberg wrote:

> On Wed, 26 Jul 2006, Pekka J Enberg wrote:
> > Note that this will fix the kmem_cache_init() case too. If 
> > ARCH_KMALLOC_MINALIGN is greater than BYTES_PER_WORD, we'll disable 
> > debugging for those caches. It's obviously ok to have debugging for 
> > kmem_cache_init caches too if ARCH_KMALLOC_MINALIGN is greater than or 
> > equal to BYTES_PER_WORD.
> 
> Eh, meant "if ARCH_KMALLOC_MINALIGN is less than or equal to 
> BYTES_PER_WORD" obviously.

Your patch only deals with ARCH_SLAB_MINALIGN. kmem_cache_create() never 
uses ARCH_KMALLOC_MINALIGN only kmem_cache_init() does by passing it to 
kmem_cache_create.  ARCH_KMALLOC_MINALIGN will still be ignored.
