Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSEPTJt>; Thu, 16 May 2002 15:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314562AbSEPTJs>; Thu, 16 May 2002 15:09:48 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:64229 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314558AbSEPTJr>;
	Thu, 16 May 2002 15:09:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] remove 2TB block device limit
Date: Thu, 16 May 2002 21:08:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        martin@dalecki.de, neilb@cse.unsw.edu.au
In-Reply-To: <3CDB4711.1A4FFDAC@zip.com.au> <5.1.0.14.2.20020510093714.01fa9680@pop.cus.cam.ac.uk> <3CDB8D2E.438E99C3@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178Qc1-0008TM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 May 2002 11:04, Andrew Morton wrote:
> Anton Altaparmakov wrote:
> > 
> > ...
> > >This code:
> > >
> > >         printk("%lu%s", some_sector, some_string);
> > >
> > >will work fine with 32-bit sector_t.  But with 64-bit sector_t it
> > >will generate a warning at compile-time and an oops at runtime.
> > >
> > >The same problem applies to dma_addr_t.  Jeff, davem and I kicked
> > >that around a while back and ended up deciding that although there
> > >are a number of high-tech solutions, the dumb one was best:
> > 
> > Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu and
> > typecast (unsigned long long)sector_t_variable in the printk.
> > 
> 
> Agree.   The nice thing about the typecast is that you
> can format the output with %06Lx, %9Ld, %Lo or whatever.
> The FMT_SECTOR_T thing forces you to use the chosen formatting.

This approach solves the phys_t printk problem as well.

-- 
Daniel
