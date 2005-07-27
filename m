Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVG0UUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVG0UUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVG0UUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:20:13 -0400
Received: from graphe.net ([209.204.138.32]:22237 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261373AbVG0UTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:19:07 -0400
Date: Wed, 27 Jul 2005 13:19:00 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
In-Reply-To: <20050727130355.08a534b7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0507271317400.12883@graphe.net>
References: <20050727195107.GC29092@stusta.de> <20050727130355.08a534b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Andrew Morton wrote:

> >  	return objp;
> >  }
> > -EXPORT_SYMBOL(kmem_cache_alloc_node);
> >  
> >  #endif
> 
> Even though we don't currently have in-module users, we probably will do so
> soon and it's a part of the slab API and the slab API is exported to
> modules.  I don't see much point in partially-exporting the API and
> applying a patch which we'll soon revert.
> 
> Christoph?
> 

I fully agree. Drivers will have to use that call in the future in order 
to properly place their control structures. The e1000 in your tree already 
does so and may be compiled as a module. Thus applying this patch will 
break mm.


