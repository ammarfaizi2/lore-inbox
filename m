Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264005AbRFHO7V>; Fri, 8 Jun 2001 10:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264011AbRFHO7L>; Fri, 8 Jun 2001 10:59:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27438 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264005AbRFHO7C>; Fri, 8 Jun 2001 10:59:02 -0400
To: Richard Henderson <rth@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Patrick Mochel <mochel@transmeta.com>, Alan Cox <alan@redhat.com>,
        "David S. Miller" <davem@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
In-Reply-To: <20010607153119.H1522@suse.de>
	<Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
	<20010607145912.B2286@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jun 2001 08:55:04 -0600
In-Reply-To: <20010607145912.B2286@redhat.com>
Message-ID: <m13d9b3ttj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson <rth@redhat.com> writes:

> On Thu, Jun 07, 2001 at 02:22:10PM -0700, Linus Torvalds wrote:
> > For example, what's the difference between ZONE_HIGHMEM and ZONE_NORMAL
> > on a sane 64-bit architecture (right now I _think_ the 64-bit architectures
> > actually make ZONE_NORMAL be what we call ZONE_DMA32 on x86, because they
> > already need to be able to distinguish between memory that can be PCI-DMA'd
> > to, and memory that needs bounce-buffers. Or maybe it's ZONE_DMA that they
> > use for the DMA32 stuff?).
> 
> On most alphas we use only one zone -- ZONE_DMA.  The iommu makes it
> possible to do 32-bit pci to the entire memory space.
> 
> For those alphas without an iommu, we also set up ZONE_NORMAL.

The AMD760 which looks like it might walk on both the alpha, an x86
side of the fence also has an iommu.  Mostly it's used for AGP but
according to the docs it should be able to handle the other cases as
well.  The only downside is that it only supports 4GB of ram...

Anyway we shouldn't assume iommu's don't exist on x86.

Eric






