Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316244AbSEQOfl>; Fri, 17 May 2002 10:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316245AbSEQOfk>; Fri, 17 May 2002 10:35:40 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:27791 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316244AbSEQOfg>; Fri, 17 May 2002 10:35:36 -0400
Date: Fri, 17 May 2002 09:35:31 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: linux-kernel@vger.kernel.org, <davej@suse.de>
Subject: Re: [RFC][PATCH] cpqarray-1: Convert to modern module_init mechanism
In-Reply-To: <20020517005146.GA32719@www.kroptech.com>
Message-ID: <Pine.LNX.4.44.0205170929350.26436-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 May 2002, Adam Kropelin wrote:

> Below is a patch (against 2.5.15-dj1) to convert cpqarray over to the modern
> module_init mechanism. This eliminates the need to call cpqarray_init() from
> genhd.c and starts the process of simplifying the cpqarray init sequence.
> It lays the groundwork for converting over to the "new" PCI registration
> mechanism as well. Also included in the patch are some simple cleanups for
> a few obvious formatting flaws.
> 
> Comments and critique are welcome. I'm also curious if this work is
> considered worthwhile. If so, I'll continue on and do the PCI init conversion
> (and any other fixups that may be warranted) as well.

Patch looks basically good to me (I basically have the same thing sitting
around here, as I was cleaning up drivers/block/genhd.c) If you want to I 
can send you what I have, so you can base the further changes (e.g. PCI) 
on it.

--Kai

>  /*
>   *  This is it.  Find all the controllers and register them.  I really hate
>   *  stealing all these major device numbers.
> - *  returns the number of block devices registered.
> + *  returns 0 on success, -EIO on failure

I'd suggest to go ahead and make it return sensible values, i.e. -EBUSY if
it can't get the major, -ENODEV if there's no hardware, -ENOMEM if the
allocations fail.

>  int __init cpqarray_init(void)

This should be static now. Also, you need to remove the explicit call to 
cpqarray_init() from drivers/block/genhd.c, otherwise it'll get called 
twice. (That part's already in my patch).

--Kai


