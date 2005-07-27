Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVG0U6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVG0U6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVG0U4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:56:36 -0400
Received: from graphe.net ([209.204.138.32]:63140 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262473AbVG0UzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:55:15 -0400
Date: Wed, 27 Jul 2005 13:55:13 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
In-Reply-To: <20050727205028.GB3679@stusta.de>
Message-ID: <Pine.LNX.4.62.0507271351420.20601@graphe.net>
References: <20050727195107.GC29092@stusta.de> <20050727130355.08a534b7.akpm@osdl.org>
 <Pine.LNX.4.62.0507271317400.12883@graphe.net> <20050727205028.GB3679@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Adrian Bunk wrote:

> > I fully agree. Drivers will have to use that call in the future in order 
> > to properly place their control structures. The e1000 in your tree already 
> > does so and may be compiled as a module. Thus applying this patch will 
> > break mm.
> 
> I don't see e1000 in 2.6.13-rc3-mm2 using it.

Hmmm. Ok. e1000 only uses kmalloc_node which is based on 
kmem_cache_alloc_node. However, kmalloc_node will likely become a 
macro like kmalloc.

Applying the patch would mean that modules would only be 
able to use kmalloc_node and not able to allocate node specific memory 
from one of the slab caches.



