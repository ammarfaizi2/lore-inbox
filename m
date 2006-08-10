Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbWHJCIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbWHJCIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 22:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWHJCIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 22:08:39 -0400
Received: from waste.org ([66.93.16.53]:5787 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030525AbWHJCIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 22:08:38 -0400
Date: Wed, 9 Aug 2006 21:07:09 -0500
From: Matt Mackall <mpm@selenic.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: npiggin@suse.de, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
Message-ID: <20060810020708.GN6908@waste.org>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:52:00PM -0700, Christoph Lameter wrote:
> This is by no means complete and probably full of bugs. Feedback and help 
> wanted! I have tried to switch over two minor system caches (memory 
> policies) to use simple slab and it seems to work. We probably have some 
> way to go before we could do performance tests.

There's probably enough here to shim in a regular slab and kmalloc
interface layer to run a desktop machine.
 
> The Simple Slab is not NUMA capable at this point and I think the
> NUMAness may better be implemented in a different way. Maybe we
> could understand the Simple Slab as a lower layer and then add all
> the bells and whistles including NUMAness, proc API, kmalloc caches
> etc. on top as a management layer for this lower level
> functionality.

I think a layered approach to handling NUMA and the like makes an
awful lot of sense here. And probably greatly simplifies locking, etc.

Also, I like that you've gone to off-slab accounting. Not only does
this simplify things overall, it's good for memory footprint and
possibly better on cache footprint.

It's gonna need a better name though..

-- 
Mathematics is the supreme nostalgia of our time.
