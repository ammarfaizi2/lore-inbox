Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRBXXtS>; Sat, 24 Feb 2001 18:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbRBXXtJ>; Sat, 24 Feb 2001 18:49:09 -0500
Received: from ns.suse.de ([213.95.15.193]:48908 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129718AbRBXXsy>;
	Sat, 24 Feb 2001 18:48:54 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Feb 2001 00:48:35 +0100
In-Reply-To: Jeff Garzik's message of "25 Feb 2001 00:27:56 +0100"
Message-ID: <oupsnl3k5gs.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Advantages:  A de-allocation immediately followed by a reallocation is
> eliminated, less L1 cache pollution during interrupt handling. 
> Potentially less DMA traffic between card and host.
> 
> Disadvantages?

You need a new mechanism to cope with low memory situations because the 
drivers can tie up quite a bit of memory (in fact you gave up unified
memory management). 

> 3) Slabbier packet allocation.  Even though skb allocation is decently
> fast, you are still looking at an skb buffer head grab and a kmalloc,
> for each [dev_]alloc_skb call.  I was wondering if it would be possible
> to create a helper function for drivers which would improve the hot-path
> considerably:
[...]

If you need such a horror it just means there is something wrong with slab.
Better fix slab.


4) Better support for aligned RX by only copying the header, no the whole
packet, to end up with an aligned IP header. Unless the driver knows about
all protocol lengths this means the stack needs to support "parse header
in this buffer, then switch to other buffer with computed offset for data" 

-Andi
