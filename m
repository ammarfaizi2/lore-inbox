Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUBMV3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUBMV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:29:17 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14604 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267234AbUBMV2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:28:23 -0500
Date: Fri, 13 Feb 2004 22:27:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
In-Reply-To: <20040210162259.GA26620@kroah.com>
Message-ID: <Pine.LNX.4.58.0402121629210.7855@serv>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
 <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be> <20040210145558.A4684@infradead.org>
 <20040210162259.GA26620@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Feb 2004, Greg KH wrote:

> How about dropping this into your arch if you can't use the
> include/asm-generic/dma-mapping.h file.  Or I can add it as
> include/asm-generic/dma-mapping-broken.h and you can repoint your arch
> to use it.  Which would be easier for you?

I don't think adding a dma-mapping-broken.h is correct either.
Some m68k scsi drivers are still badly broken, because they use some
archaic API and need an update to something sane.
I think the problem is that DMA-API.txt suggest there is separate API for
coherent/noncoherent (especially dma_alloc_coherent()/
dma_alloc_noncoherent()). DMA-mapping.txt is better here as it
distinguishes between consistent and streaming mappings.
m68k needs something similiar as arm, consistent allocations are mapped
noncachable into the kernel and dma_map* does the necessary cache flushes.
With that you would already get very far and would do the right thing for
most noncoherent archs. This would only would only leave us with some
special cases which had to be fixed to make a driver coherency aware.
So I would suggest to drop e.g. dma_alloc_noncoherent() (parisc seems to
be the only user and it's simply a kmalloc) and merge the rest of
DMA-API.txt with DMA-mapping.txt or make at least consistent with it and
maybe add a bit more information what the functions do in the coherent/
noncoherent case.

bye, Roman
