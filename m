Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRGIWQi>; Mon, 9 Jul 2001 18:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbRGIWQ2>; Mon, 9 Jul 2001 18:16:28 -0400
Received: from mail.zmailer.org ([194.252.70.162]:59657 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S264244AbRGIWQP>;
	Mon, 9 Jul 2001 18:16:15 -0400
Date: Tue, 10 Jul 2001 01:17:55 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Adam Shand <larry@spack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010710011755.M18653@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>; from larry@spack.org on Mon, Jul 09, 2001 at 01:01:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This really should be a Linux-Kernel FAQ item...
  ( http://www.tux.org/lkml/ )

On Mon, Jul 09, 2001 at 01:01:17PM -0700, Adam Shand wrote:
> Linux 2.4 does support greater then 4GB of RAM with these caveats ...
> 
>  * It does this by supporting Intel's PAE (Physical Address Extension)
>    features which are in all Pentium Pro and newer CPU's.

   Carefull out there.

   Check intel 386 family processors address mapping manuals.
   You will see that the address calculated by combining "base"
   and "segment" are in fact TRUNCATED at 32-bits before feeding
   them to page mapping machinery --> There are no tricks at all
   to have SIMULTANEOUS access to more than 4 GB of memory without
   playing MMU mapping tricks -- which are painfully slow...

   That is the origin of i386 architecture 4 GB virtual memory limit.

   All that PAE mode does is to allow that 4 GB virtual space to be
   mapped into larger physical space.

   Compound that with unability to have separate user and kernel
   mappings active at the same time (unlike e.g. Motorola 68000
   family MMUs do), and the userspace can't have even that 4GB,
   but is limited to at least 3.5/0.5 (user/kernel) split, more
   commonly to 3.0/1.0 split.

   With 64-bit processors (those that do addresses in 64-bit mode)
   there are a plenty of bits to "waste" in these mappings.  E.g.
   one can have a 1:1 mapping in between kernel and user, with
   2^63 bits address space for each.  The number is mindbogglingly
   large..  ( 2G * 4G = 8 000 000 T = 8 000 E )
   (In reality e.g. Alphas do use "only" 43-bits of addresses in
    these mappings, but even those are 1000+ times larger than 4G.)

> Thanks,
> Adam.

/Matti Aarnio
