Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSIIVnF>; Mon, 9 Sep 2002 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSIIVnE>; Mon, 9 Sep 2002 17:43:04 -0400
Received: from packet.digeo.com ([12.110.80.53]:7892 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318873AbSIIVnE>;
	Mon, 9 Sep 2002 17:43:04 -0400
Message-ID: <3D7D16ED.B09C9B47@digeo.com>
Date: Mon, 09 Sep 2002 14:47:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <3D7D105D.7050604@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 21:47:40.0786 (UTC) FILETIME=[85599520:01C2584A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Andrew Morton wrote:
> > Nobody seems to have come forth to implement a thought-out scatter/gather,
> > map-user-pages library infrastructure so I'd be a bit reluctant to
> > break stuff without offering a replacement.
> >
> 
> We'd need one.
> 
> get_user_pages() is broken if a kernel module access the virtual address
> of the page and the cpu caches are not coherent:

OK.  Most users seem to just want to put the pages under DMA though.

> Most of the flush functions need the vma pointer, but it's impossible to
> guarantee that it still exists when the get_user_pages() user calls
> page_cache_release().

Well presumably, if the driver is altering user memory by hand,
it is synchronous and they can hang onto mmap_sem while doing it?
