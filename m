Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132480AbQLVWpB>; Fri, 22 Dec 2000 17:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbQLVWov>; Fri, 22 Dec 2000 17:44:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1038 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132411AbQLVWoe>; Fri, 22 Dec 2000 17:44:34 -0500
Date: Fri, 22 Dec 2000 18:20:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap write clustering
In-Reply-To: <Pine.LNX.4.21.0012210721440.1991-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0012221813490.3382-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Dec 2000, Marcelo Tosatti wrote:

> 
> On Thu, 21 Dec 2000, Andrew Morton wrote:
> 
> > Marcelo Tosatti wrote:
> > > 
> > > Hi,
> > > 
> > > Basically this new swap_writepage function looks for dirty swapcache pages
> > > which may be contiguous (reverse and forward searching wrt to the physical
> > > address of the page being passed to swap_writepage) and builds a page list
> > > which is written "at once".
> > > 
> > > The patch is against test13pre3.
> > > 
> > > Comments are welcome. (especially about the __find_page_nolock
> > > modification)
> > > 
> > 
> > Have you any benchmarks for this?
> 
> Not yet. 
> 
> Under some stress tests on a 16mb machine, around 30% of the clustered
> swapouts were reaching the limit of pages, which was 16. 

While running X, Netscape and dbench (2 threads) on the 16mb machine the
number of successful write request merges increased by around 1000
(without the patch it was an average of 4000 write merges).

The dbench throughtput increased from 2.0Mb/s to 2.3Mb/s on average.

(Note: the swap partition was on the same disk as the rest of the system)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
