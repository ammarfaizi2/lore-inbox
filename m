Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSGWUq2>; Tue, 23 Jul 2002 16:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSGWUq1>; Tue, 23 Jul 2002 16:46:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2574 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318297AbSGWUqZ>;
	Tue, 23 Jul 2002 16:46:25 -0400
Message-ID: <3D3DC0E0.EDE4CF20@zip.com.au>
Date: Tue, 23 Jul 2002 13:47:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David F Barrera <dbarrera@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0, 
 mode:0x0
References: <OF6F39340B.FF1F1097-ON85256BFF.005C6460@pok.ibm.com> <3D3DAD54.6825F86@zip.com.au> <20020723203445.GK1117@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Tue, Jul 23, 2002 at 12:24:04PM -0700, Andrew Morton wrote:
> > David F Barrera wrote:
> > >
> > > I have experienced the following errors while running a test suite (LTP
> > > test suite)  on the 2.4.26 kernel.  Has anybody seen this problem, and, if
> > > so, is there a patch for it?  Thanks.
> > >
> > > kernel BUG at page_alloc.c:92!
> >
> > Could you please replace the put_page(page) in
> > kernel/ptrace.c:access_process_vm() with page_cache_release(page)
> > and retest?
> 
> I prefer to drop page_cache_release and to have __free_pages_ok to deal
> with the lru pages like it's been fixed in 2.4.

That would fix it too.  But a __free_pages_ok call from interrupt
context can deadlock the box.

The removal of pages from the LRU is rather a mess.  It's getting
better, and we can fix up some more of this if/when pagemap_lru_lock
becomes an interrupt-safe lock.

-
