Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTE1BrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 21:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTE1BrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 21:47:15 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:5257 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S264473AbTE1BrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 21:47:13 -0400
Date: Tue, 27 May 2003 23:00:25 -0300
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       linuxcompressed-deve@lists.sourceforge.net
Subject: Re: [2.4.20-ck7] good compressed caching experience
Message-ID: <20030528020025.GC2318@bach>
References: <200305270711.34608.kernel@kolivas.org> <200305271713.49762.rabbit80@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271713.49762.rabbit80@mbnet.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Kimmo,

On Tue, May 27, 2003 at 05:13:48PM +0300, Kimmo Sundqvist wrote:
> On Tuesday 27 May 2003 00:11, Con Kolivas wrote:
> > On Tue, 27 May 2003 04:50, Kimmo Sundqvist wrote:
> > > Just a warning... both systems have only ReiserFS partitions.  Other FSes
> > > might still get hurt.
> 
> > This is definitely the case! If you try out compressed caching with ck7
> > please do not enable preempt if you are using ext2/3 or vfat.
> 
> Is this a problem in ext2/3, pre-empt implementation, compressed caching or 
> kernel in general?

It is a compressed caching problem. As Con said, FSs that are safe are
just lucky.

> I think I can still choose between compression methods, or can I?

You can, just use the kernel parameter "compalg=" kernel parameter. 

compalg=0 (WKdm)
compalg=1 (WK4x4)
compalg=2 (LZO, default)

> Which one of them, on average, is the least CPU-intensive, and which
> one gives the best compression ratio?  I am also at loss how to
> interpret the percentages in "cat /proc/comp_cache_stat".

LZO is the most CPU-intensive and gives the best compression
ratio. Even if spending more CPU cycles to compress than WKdm or
WK4x4, it showed to have the best performance given its compression
ratio.

> For M$ Windows there was once a program called MagnaRAM97 that had a
> similar idea, but I don't understand how it could report 2 to 3-fold
> compression ratios.  It always spontaneously rebooted the Pentium
> 133MHz after some hours, so I uninstalled it.

I am not sure, but I guess the purpose of MagnaRAM and this patch are
different, as well as the approach. This patch intends to reduce the
number of disk accesses using compression and extending effective
memory size, therefore improving general performance. We use an
adaptive cache size to avoid overhead when compression isn't/wouldn't
help.

> Just take your time, but will we see a pre-empt safe (or better yet
> SMP safe) version coming out anytime soon?

Yes, you will, they are the top items on my todo list.

> Compiling another 2.4.20-ck7 with 8kB pages and swap compression in
> the background.  I have now "mem=896M" to avoid the highmem
> boundary, even if it wasn't necessary.  Someone said somewhere that
> a 1GB system is faster without highmem support, so I haven't
> compiled it in for a while.

Best regards,
-- 
Rodrigo


