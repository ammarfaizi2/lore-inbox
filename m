Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVHEJiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVHEJiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVHEJiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:38:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16029 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262935AbVHEJhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:37:42 -0400
Date: Fri, 5 Aug 2005 11:37:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <20050804233634.1406e92a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508051132540.3743@scrub.home>
References: <1123219747.20398.1.camel@localhost> <20050804223842.2b3abeee.akpm@osdl.org>
 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
 <20050804233634.1406e92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Andrew Morton wrote:

> > +static inline void *kzalloc(size_t size, unsigned int __nocast flags)
> > +{
> > +	return kcalloc(1, size, flags);
> > +}
> > +
> 
> That'll generate just as much code as simply using kcalloc(1, ...).  This
> function should be out-of-line and EXPORT_SYMBOL()ed.  And kcalloc() can
> call it too..

BTW we already have 420 "kcalloc(1, ...)" user and 41 without the 1 
argument, most of them are in sound, which introduced it in first place.
Can we please deprecate that function before it spreads any further?

bye, Roman
