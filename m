Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314215AbSEBBfC>; Wed, 1 May 2002 21:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314216AbSEBBfB>; Wed, 1 May 2002 21:35:01 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:6298 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314215AbSEBBfA>;
	Wed, 1 May 2002 21:35:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 03:35:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172j1d-0001rS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 02:20, Anton Blanchard wrote:
> > so ia64 is one of those archs with a ram layout with huge holes in the
> > middle of the ram of the nodes? I'd be curious to know what's the
> > hardware advantage of designing the ram layout in such a way, compared
> > to all other numa archs that I deal with. Also if you know other archs
> > with huge holes in the middle of the ram of the nodes I'd be curious to
> > know about them too. thanks for the interesting info!
> 
> From arch/ppc64/kernel/iSeries_setup.c:
> 
>  * The iSeries may have very large memories ( > 128 GB ) and a partition
>  * may get memory in "chunks" that may be anywhere in the 2**52 real
>  * address space.  The chunks are 256K in size.
> 
> Also check out CONFIG_MSCHUNKS code and see why I'd love to see a generic
> solution to this problem.

Using the config_nonlinear model, you'd change the four mapping functions:

	logical_to_phys
	phys_to_logical
	pagenum_to_phys
	phys_to_pagenum

to use a hash table instead of a table lookup.  Bill Irwin suggested a btree
would work here as well.

(Note I'm trying out the term 'pagenum' instead of 'ordinal' here, following
comments on lse-tech.)

-- 
Daniel
