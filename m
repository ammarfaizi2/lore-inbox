Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVHESUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVHESUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVHESSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:18:30 -0400
Received: from graphe.net ([209.204.138.32]:61610 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262827AbVHESQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:16:51 -0400
Date: Fri, 5 Aug 2005 11:16:37 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Stephen Pollei <stephen.pollei@gmail.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <feed8cdd050805104954a07573@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0508051114001.31384@graphe.net>
References: <1123219747.20398.1.camel@localhost>  <20050804223842.2b3abeee.akpm@osdl.org>
  <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> 
 <20050804233634.1406e92a.akpm@osdl.org>  <Pine.LNX.4.61.0508051132540.3743@scrub.home>
  <1123235219.3239.46.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051202520.3728@scrub.home>
  <1123236831.3239.55.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051225270.3743@scrub.home>
 <feed8cdd050805104954a07573@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Stephen Pollei wrote:

> > On Fri, 5 Aug 2005, Arjan van de Ven wrote:
> > > > This would imply a similiar kmalloc() would be useful as well.
> > > > Second, how relevant is it for the kernel?
> > > we've had a non-negliable amount of security holes because of this
> > So why don't we have a similiar kmalloc()?
> You mean something like:
> static void __bad_kmalloc_safe_nonconstant_size(void);

Hmm. If we had kcmalloc then we may be able to add a zero bit to the slab 
allocator. If we would obtain zeroed pages for the slab then we may skip 
zeroing of individual entries. However, the cache warming effect of the 
current zeroing is then not occurring. Not sure if this would make sense 
but this is a possible optimization if we had kcmalloc.


