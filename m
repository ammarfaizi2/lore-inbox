Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTE0OG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTE0OG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:06:28 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:20385 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261169AbTE0OG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:06:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.20-ck7] good compressed caching experience
Date: Wed, 28 May 2003 00:20:48 +1000
User-Agent: KMail/1.5.1
Cc: rcastro@ime.usp.br
References: <200305262150.04552.rabbit80@mbnet.fi> <200305270711.34608.kernel@kolivas.org> <200305271713.49762.rabbit80@mbnet.fi>
In-Reply-To: <200305271713.49762.rabbit80@mbnet.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305280020.48514.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 00:13, Kimmo Sundqvist wrote:
> On Tuesday 27 May 2003 00:11, Con Kolivas wrote:
> > On Tue, 27 May 2003 04:50, Kimmo Sundqvist wrote:
> > > Just a warning... both systems have only ReiserFS partitions.  Other
> > > FSes might still get hurt.
> >
> > This is definitely the case! If you try out compressed caching with ck7
> > please do not enable preempt if you are using ext2/3 or vfat.
>
> Is this a problem in ext2/3, pre-empt implementation, compressed caching or
> kernel in general?

The compressed caching code isn't yet properly preempt aware. The filesystems 
that are safe are just lucky.

>
> I think I can still choose between compression methods, or can I?  Which
> one of them, on average, is the least CPU-intensive, and which one gives
> the best compression ratio?  I am also at loss how to interpret the
> percentages in "cat /proc/comp_cache_stat".

The default in -ck7 is lzo which is the best compression and pretty fast. The 
full details only RCastro can tell us.

>
> For M$ Windows there was once a program called MagnaRAM97 that had a
> similar idea, but I don't understand how it could report 2 to 3-fold
> compression ratios.  It always spontaneously rebooted the Pentium 133MHz
> after some hours, so I uninstalled it.
>
> Just take your time, but will we see a pre-empt safe (or better yet SMP
> safe) version coming out anytime soon?
>
> Compiling another 2.4.20-ck7 with 8kB pages and swap compression in the
> background.  I have now "mem=896M" to avoid the highmem boundary, even if
> it wasn't necessary.  Someone said somewhere that a 1GB system is faster
> without highmem support, so I haven't compiled it in for a while.

Definitely with the default VM as the basis in 2.4 (as opposed to AA or RMAP) 
you are much better off without High Mem enabled if you only have 1Gb.

Con
