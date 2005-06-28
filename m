Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVF1IC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVF1IC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVF1ICJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:02:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:149 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261921AbVF1GYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:24:07 -0400
Subject: Re: increased translation cache footprint in v2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
In-Reply-To: <dd805c30d3ab223b650077cca3c82d86@embeddededge.com>
References: <20050626190944.GC6091@logos.cnet>
	 <20050626.175347.104031526.davem@davemloft.net>
	 <705a40397bb8383399109debccaebaa3@embeddededge.com>
	 <20050627.125052.108115648.davem@davemloft.net>
	 <dd805c30d3ab223b650077cca3c82d86@embeddededge.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 16:18:22 +1000
Message-Id: <1119939502.5133.195.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 16:35 -0400, Dan Malek wrote:
> On Jun 27, 2005, at 3:50 PM, David S. Miller wrote:
> 
> > I think you're making this problem more complex than it really
> > is.  There is no reason at all to hold page tables for the direct
> > physical memory mappings of lowmem if you have any control whatsoever
> > over the TLB miss handler.
> 
> I'm not one to make it more complex, I just want to cover
> all of the possibilities :-)  The "compute kernel" part of
> it needs to be generic for all of the possibilities.   Like I mentioned.
> we have a quite configurable address space for mapping text,
> data, IO, and uncached spaces.  In addition, we have execute
> in place out of flash and other embedded custom options.
> I was hoping to find a solution where the kernel TLBs could
> be dynamically loaded as well, with the standard look up
> algorithm.  Yes, I still need a kernel path for the special
> case processing of other than 4K pages, but it would be nice
> to keep that generic as well.

Can't you put the "8Mb page" flag at the PMD level and use normal kernel
page tables ? You'll have to fill PMD entries two by two but that
shouldn't be too difficult.

You can then have the kernel linear mapping use 8Mb pages, along with
some "block IO" translations and leave the rest to normal 4k page tables

Ben.


