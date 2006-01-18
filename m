Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWARNyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWARNyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWARNyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:54:46 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:49357 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030310AbWARNyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:54:46 -0500
Date: Wed, 18 Jan 2006 15:54:13 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Sven Lauritzen <the-pulse@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] at mm/slab.c:1235! (Version 2.6.15)
In-Reply-To: <1137591682.1774.35.camel@berlin.slsd>
Message-ID: <Pine.LNX.4.58.0601181547580.20218@sbz-30.cs.Helsinki.FI>
References: <1137582956.1774.15.camel@berlin.slsd> 
 <84144f020601180422q78ecdf37mb8b8e9d1f40039d1@mail.gmail.com>
 <1137591682.1774.35.camel@berlin.slsd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 14:22 +0200, Pekka Enberg wrote:
> > Try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC to see if
> > they pick up anything.

On Wed, 18 Jan 2006, Sven Lauritzen wrote:
> Ok, I'll try that. I guess I'll find the results in syslog?

Yes. They'll give us a better oops if they pick up something.
 
On Wed, 2006-01-18 at 14:22 +0200, Pekka Enberg wrote:
> > I don't quite see how this could happen. Is the box otherwise stable?
> > Have you run memtest86 on it?
 
On Wed, 18 Jan 2006, Sven Lauritzen wrote:
> It's the first crash within 4 days. I have exchanged motherboard and ram
> of the box, so maybe there's something worng. But it seems that the
> crash was caused by high traffic on the disk drive. 6:25 is the time,
> when findutils and logrotate and so on start to run.

Indeed that's because the kernel starts reclaiming memory and attempts to 
shrink the slabs. It's just that the page we're freeing is being managed 
by the slab allocator and I don't see how anyone else could be messing 
around with it. The fact that it's one bit error makes me think it could 
be due to faulty memory.

			Pekka
