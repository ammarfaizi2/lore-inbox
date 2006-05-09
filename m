Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWEITF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWEITF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWEITF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:05:29 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:30399 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750974AbWEITF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:05:28 -0400
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Bj=F6rn?= Steinbrink" <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
In-Reply-To: <4460DEAD.9040900@colorfullife.com>
References: <445E80DD.9090507@hozac.com>
	 <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
	 <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
	 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>
	 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
	 <1147104412.22096.8.camel@localhost>
	 <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org>
	 <1147116991.11282.3.camel@localhost>
	 <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
	 <44603543.8070205@colorfullife.com>
	 <Pine.LNX.4.58.0605091316010.27821@sbz-30.cs.Helsinki.FI>
	 <4460DEAD.9040900@colorfullife.com>
Date: Tue, 09 May 2006 22:05:25 +0300
Message-Id: <1147201526.23732.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 20:25 +0200, Manfred Spraul wrote:
> No - it would only make sense if it could be used for all slabs. 
> Otherwise: How should kfree figure out if it's called for a slab with 
> embedded pointers or not?

Yeah, you're absolutely right. Which is exactly why I asked what you
want to do with the OFF_SLAB case. We certainly can support both by
virtualizing kfree() and kmem_cache_free() with struct slab_operations
type of thing, but that's probably not very performant. Well, it might
be for NUMA, as virt_to_page() is so expensive.

Anyway, embedding struct kmem_cache pointer in the beginning of slab
page is doable (I have a proof-of-concept patch for that btw) but we
need to solve OFF_SLAB first.

				Pekka

