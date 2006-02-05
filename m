Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWBEJSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWBEJSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 04:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWBEJSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 04:18:32 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19929 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750719AbWBEJSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 04:18:31 -0500
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Jackson <pj@sgi.com>
Cc: christoph@lameter.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       manfred@colorfullife.com
In-Reply-To: <1139128872.11782.5.camel@localhost>
References: <1139060024.8707.5.camel@localhost>
	 <Pine.LNX.4.62.0602040709210.31909@graphe.net>
	 <1139070369.21489.3.camel@localhost> <1139070779.21489.5.camel@localhost>
	 <20060204180026.b68e9476.pj@sgi.com>  <1139128872.11782.5.camel@localhost>
Date: Sun, 05 Feb 2006 11:18:29 +0200
Message-Id: <1139131109.11782.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 10:41 +0200, Pekka Enberg wrote:
> Ah, sorry about that, I forgot to verify the NUMA case. The problem is
> that to kmalloc_node() is calling cache_alloc() now which is forced
> inline. I am wondering, would it be ok to make __cache_alloc()
> non-inline for NUMA? The relevant numbers are:

[snip]

Btw, we can also change kmalloc_node() to use kmem_cache_alloc_node()
again but for that, we have a minor correctness issue, namely, the
__builtin_return_address(0) won't work for kmalloc_node(). Hmm.

			Pekka

