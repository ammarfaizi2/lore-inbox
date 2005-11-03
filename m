Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbVKCXPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbVKCXPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbVKCXPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:15:35 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:44292 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030521AbVKCXPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:15:34 -0500
Date: Thu, 3 Nov 2005 23:15:31 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG
In-Reply-To: <1131044351.8830.6.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.10.10511032305220.4078-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

The error occoures well after the NFS root is up and running (during the
link phase of a gcc compilation of hello.c). I thought it might be part of
the NFS system due to the backtrace.

I am currently working on a GCC-3.4.3, Binutils-2.15 version to see if it
is a compiler/binary utilities issue. The problem I have is that
GCC-3.4.3, Binutils-2.15 does not cope with printk("%llu") so I know that
there is a high potential for failure with this combination.

If it works OK, I will try with GCC-3.4.3, Binutils-2.16.1 and GCC-4.0.2,
Binutils-2.15 to try and eliminate compiler/binutils issues.

Once I have eliminated compiler/binutils bugs/features then I will start
to concentrate on the Kernel to try to identify the initial point of
failure.

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

