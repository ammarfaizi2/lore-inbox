Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbVKDKIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbVKDKIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbVKDKIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:08:21 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:13325 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161131AbVKDKIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:08:21 -0500
Date: Fri, 4 Nov 2005 10:08:18 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG
In-Reply-To: <1131044351.8830.6.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.10.10511040959200.1648-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

I have found a working combination of GCC/Binutils [gcc-3.4.3,
binutils-2.16.1 (GCC needs more work as it got its specs wrong and has a
bug in it regarding %llu on sparc).

This suggests that there is a kernel build error associated with GCC-4.0.2
(for sparc-linux). I will need to investigate this as GCC-4.0.2 has a
veriety of bug fixes in it that affect the sparc-linux target. It also has
improved configuration/build scripts that are relevent to what I am trying
to do.

I will let you know what I find. It may take me some time as my sparc
assembly is not too good and this is the best place to find compiler
hickups.

Regards
	Mark Fortescue.

On Thu, 3 Nov 2005, Trond Myklebust wrote:

> On Thu, 2005-11-03 at 18:10 +0000, Mark Fortescue wrote:
> > Hi Trond,
> > 
> > I am running a sparc-linux kernel using an NFS Root and it is falling over
> > with the trace below.
> > 
> > My Kernel is not a standard kernel (I have had to tweek it to get the
> > SBUS GC3 and the 82077 floppy to work on my OPUS Sparc 1 clone).
> > 
> > Can you advise me on any known issues in the NFS Client code that might
> > enter NULL pointers into the 'slot->slots[i]' in __lookup_tag.
> > 
> > If there are none that you are aware of, are there any specific areas that
> > I should investigate with printk statements.
> 
> NFS does not ever directly access the radix tree internals: it always
> uses the API, and it always protects those operations using the
> NFS_I(inode)->req_lock.
> 
> Are you sure that radix_tree_init() is being called before the NFSroot
> stuff is started? To me, this whole thing smells of memory scribble.
> 
> Cheers,
>   Trond
> 
> 

