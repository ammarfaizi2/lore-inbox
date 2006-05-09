Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWEJAAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWEJAAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEJAAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:00:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8341 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932243AbWEJAAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:00:15 -0400
Date: Tue, 9 May 2006 16:59:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, manfred@colorfullife.com, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <Pine.LNX.4.64.0605090737500.3718@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605091659070.30807@schroedinger.engr.sgi.com>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>
  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost>
 <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605090737500.3718@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Linus Torvalds wrote:

> Right now the __cache_free() chain does "virt_to_page()" on NUMA 
> regardless, through the
> 
> 	#ifdef CONFIG_NUMA
> 	        {
> 	                struct slab *slabp;
> 	                slabp = virt_to_slab(objp);
> 	,,,
> 
> thing. The suggested patch obviously makes it do it _twice_: once to get 
> the cachep, once to get the slabp. But some simple re-organization would 
> make it do it just once, if we passed in the "struct page *" instead of 
> the "struct cachep" - since in the end, every single path into the real 
> core of the allocator does end up needing it.

Sounds like the best approach to address this rather than another slab 
redesign.

