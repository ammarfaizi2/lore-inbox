Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWGZLlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWGZLlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWGZLlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:41:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34191 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750943AbWGZLle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:41:34 -0400
Date: Wed, 26 Jul 2006 04:41:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com> <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
 <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka J Enberg wrote:

> On Wed, 26 Jul 2006, Christoph Lameter wrote:
> > Well that is a bit far reaching. What is broken is that SLAB_RED_ZONE and
> > SLAB_STORE_USER ignore any given alignment. If you want to fix that then 
> > you need to modify how both debugging methods work.
> 
> Not sure I understand what you mean. Isn't it enough that we disable 
> debugging if architecture or caller mandated alignment is greater than 
> BYTES_PER_WORD?

If you disable them then we are fine. I think the main "bug" is that 
we create the caches with ARCH_KMALLOC_MINALIGN in kmem_cache_init but 
allow debug options on them. It seemss that we need to be able to disable 
debugging from kmem_cache_init.
