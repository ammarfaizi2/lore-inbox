Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSJCOfd>; Thu, 3 Oct 2002 10:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSJCOfc>; Thu, 3 Oct 2002 10:35:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60376 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261454AbSJCOfc>;
	Thu, 3 Oct 2002 10:35:32 -0400
Date: Thu, 3 Oct 2002 10:40:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Russell King <rmk@arm.linux.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: initrd breakage in 2.5.38-2.5.40
In-Reply-To: <20021003131240.B2304@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0210031037340.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Russell King wrote:

> My mtdblock problems are probably related to this, so I'll followup here.
> 
> mtdblock registers its gendisk structure in its open() method.
> Unfortunately, do_open wants to obtain this structure before
> the open() method (but doesn't use it.)

That's wrong thing to do, actually.  Correct way to handle it is the
same as for modular ide, etc. - separate callback to be used by
get_gendisk() and doing allocations/loading subdrivers/etc.

It will go in right after complete switchover to dynamic allocation and
introduction of ->bd_disk.

