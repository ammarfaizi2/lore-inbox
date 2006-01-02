Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWABNE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWABNE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWABNE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:04:29 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:25733 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750716AbWABNE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:04:28 -0500
Date: Mon, 2 Jan 2006 15:04:17 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andi Kleen <ak@suse.de>
cc: Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on
 x86_64 machines ?
In-Reply-To: <200601021345.44843.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0601021447440.22227@sbz-30.cs.Helsinki.FI>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
 <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
 <84144f020601020037n7af7ac54l74cdbe602372c7f@mail.gmail.com>
 <200601021345.44843.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/05, Andreas Kleen <ak@suse.de> wrote:
> > > I remember the original slab paper from Bonwick actually mentioned that
> > > power of two slabs are the worst choice for a malloc - but for some reason Linux
> > > chose them anyways.

On Monday 02 January 2006 09:37, Pekka Enberg wrote:
> > Power of two sizes are bad because memory accesses tend to concentrate
> > on the same cache lines but slab coloring should take care of that. So
> > I don't think there's a problem with using power of twos for kmalloc()
> > caches.
 
On Mon, 2 Jan 2006, Andi Kleen wrote:
> There is - who tells you it's the best possible distribution of memory?

Maybe it's not. But that's besides the point. The specific problem Bonwick 
mentioned is related to cache line distribution and should be taken care 
of by slab coloring. Internal fragmentation is painful but the worst 
offenders can be fixed with kmem_cache_alloc(). So I really don't see the 
problem. On the other hand, I am not opposed to dynamic generic slabs if 
you can show a clear performance benefit from it. I just doubt you will.

			Pekka
