Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVF0Un2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVF0Un2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVF0Uj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:39:26 -0400
Received: from embeddededge.com ([209.113.146.155]:22536 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261665AbVF0UgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:36:04 -0400
In-Reply-To: <20050627.125052.108115648.davem@davemloft.net>
References: <20050626190944.GC6091@logos.cnet> <20050626.175347.104031526.davem@davemloft.net> <705a40397bb8383399109debccaebaa3@embeddededge.com> <20050627.125052.108115648.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd805c30d3ab223b650077cca3c82d86@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: increased translation cache footprint in v2.6
Date: Mon, 27 Jun 2005 16:35:41 -0400
To: "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 27, 2005, at 3:50 PM, David S. Miller wrote:

> I think you're making this problem more complex than it really
> is.  There is no reason at all to hold page tables for the direct
> physical memory mappings of lowmem if you have any control whatsoever
> over the TLB miss handler.

I'm not one to make it more complex, I just want to cover
all of the possibilities :-)  The "compute kernel" part of
it needs to be generic for all of the possibilities.   Like I mentioned.
we have a quite configurable address space for mapping text,
data, IO, and uncached spaces.  In addition, we have execute
in place out of flash and other embedded custom options.
I was hoping to find a solution where the kernel TLBs could
be dynamically loaded as well, with the standard look up
algorithm.  Yes, I still need a kernel path for the special
case processing of other than 4K pages, but it would be nice
to keep that generic as well.

I agree, it's rather trivial to fabricate the kernel text/data
large page sizes on the fly, but there are other address spaces
that would also benefit from such mapping.  I'd like to find a
complete solution to this, and I am working on it as time permits.
I'd rather not try to define a half-baked solution in the future, as
I sometimes have to do of code written years ago :-)

Even if we don't use the page tables, we still need to create
them, as the Abatron BDI2000 has knowledge of Linux page
tables.  When using this jtag debugger, it performs virtual->physical
translations of addresses not currently mapped by the MMU.

Thanks.


	-- Dan

