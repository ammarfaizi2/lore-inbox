Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSHZCRG>; Sun, 25 Aug 2002 22:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHZCRG>; Sun, 25 Aug 2002 22:17:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317829AbSHZCRG>;
	Sun, 25 Aug 2002 22:17:06 -0400
Message-ID: <3D699343.D5343AD4@zip.com.au>
Date: Sun, 25 Aug 2002 19:32:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Steven Cole <elenstev@mesatop.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D698F4E.93A3DDA2@zip.com.au> <17830228.1030302537@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> > kjournald: page allocation failure. order:0, mode:0x0
> >>
> >> I've seen this before, but am curious how we ever passed
> >> a gfpmask (aka mode) of 0 to __alloc_pages? Can't see anywhere
> >> that does this?
> >
> > Could be anywhere, really.  A network interrupt doing GFP_ATOMIC
> > while kjournald is executing.  A radix-tree node allocation
> > on the add-to-swap path perhaps.  (The swapout failure messages
> > aren't supposed to come out, but mempool_alloc() stomps on the
> > caller's setting of PF_NOWARN.)
> >
> > Or:
> >
> > mnm:/usr/src/25> grep -r GFP_ATOMIC drivers/scsi/*.c | wc -l
> >      89
> 
> No, GFP_ATOMIC is not 0:
> 

It's mempool_alloc(GFP_NOIO) or such.  mempool_alloc() strips
__GFP_WAIT|__GFP_IO on the first attempt.

It also disables the printk, so maybe I just dunno ;)  show_stack()
would tell.
