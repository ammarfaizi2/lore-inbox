Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWA0UJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWA0UJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWA0UJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:09:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51553 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1160997AbWA0UJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:09:18 -0500
Date: Fri, 27 Jan 2006 21:10:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127201015.GF9068@suse.de>
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA7CD1.4040301@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Pierre Ossman wrote:
> Russell King wrote:
> >
> > I don't see what the problem is.  A sg entry is a list of struct page
> > pointers, an offset, and a size.  As such, it can't describe a transfer
> > which crosses a page because such a structure does not imply that one
> > struct page follows another struct page.
> >
> >   
> 
> If the pages do not strictly follow each other then there is a lot of
> broken code in the kernel. drivers/mmc/mmci.c and drivers/block/ub.c
> being two occurences since both assume they can access the entire entry
> through a single mapping.

Assuming that page idx and idx + 1 in a bio are contigious is a very bad
one, no one has ever made any such guarantees. Besides, if you kmap()
it, things change. The pages in a bio have nothing to do with each
other, they are usually just a consequence of how the page cache ended
up allocating. So completely random usually, once you get a little
fragmentation.

Are you sure you are reading that code correctly? Code making such
assumptions would be breaking pretty quickly.

-- 
Jens Axboe

