Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSKBSHY>; Sat, 2 Nov 2002 13:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSKBSHY>; Sat, 2 Nov 2002 13:07:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:30900 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261313AbSKBSHX>;
	Sat, 2 Nov 2002 13:07:23 -0500
Message-ID: <3DC415DA.29D22E92@digeo.com>
Date: Sat, 02 Nov 2002 10:13:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Akira Tsukamoto <at541@columbia.edu>
CC: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
References: <3DC3A9C0.7979C276@digeo.com> <20021102060423.032A.AT541@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 18:13:47.0124 (UTC) FILETIME=[9632AB40:01C2829B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Tsukamoto wrote:
> 
> On Sat, 02 Nov 2002 02:32:32 -0800
> Andrew Morton <akpm@digeo.com> mentioned:
> 
> > Akira Tsukamoto wrote:
> > >
> > But you've inlined them again.  Your patches increase my kernel
> > size by 17 kbytes, which is larger than my entire Layer 1 instruction
> > cache!
> 
> It is because I was working on this patch based on 2.5.44 :)
> 
> As Andi mentioned, how about selecting if OCNFIG_SAMLL is defined?

Well you could make it dependent on CONFIG_SLOW_KERNEL ;)

It's an act of faith - we have no benchmarks on this.  But it
goes like this:

- subroutine calls are fast
- cache misses are slow
- kernel has no right to be evicting user code from the CPU cache
- smaller is faster
- inlining to the point of increasing code size is probably wrong
