Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281961AbRKUUOE>; Wed, 21 Nov 2001 15:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281965AbRKUUNp>; Wed, 21 Nov 2001 15:13:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17145 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281961AbRKUUNf>; Wed, 21 Nov 2001 15:13:35 -0500
Message-ID: <3BFC0AD5.5A4802D@mvista.com>
Date: Wed, 21 Nov 2001 12:13:09 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Memory allocation question
In-Reply-To: <Pine.LNX.4.33L.0111211651280.1491-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 21 Nov 2001, george anzinger wrote:
> > Alan Cox wrote:
> > >
> > > > size chuncks.  Currently I am using kmalloc() to allocate a page at a
> > > > time.  I don't want to have to worry about mapping/unmapping etc.  I
> > >
> > > Use get_free_page() to get page sized chunks
> >
> > What about __get_free_page() ?  I don't need or want the clear page
> > (performance issues).
> 
> get_free_page() doesn't clear the page afaics.
> 
In mm.h (2.4.13 kernel)....

#define __get_free_page(gfp_mask) \
		__get_free_pages((gfp_mask),0)

#define __get_dma_pages(gfp_mask, order) \
		__get_free_pages((gfp_mask) | GFP_DMA,(order))

/*
 * The old interface name will be removed in 2.5:
 */
#define get_free_page get_zeroed_page
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Where as __get_free_page() does not zero.  I know this is an old kernel,
but...


What am I missing?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
