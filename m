Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319323AbSH2UAK>; Thu, 29 Aug 2002 16:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319324AbSH2UAK>; Thu, 29 Aug 2002 16:00:10 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26639
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319323AbSH2UAJ>; Thu, 29 Aug 2002 16:00:09 -0400
Date: Thu, 29 Aug 2002 13:02:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: /pub/linux/kernel/people/hedrick/ide-2.5.32
In-Reply-To: <3D6E7CBB.407299E3@zip.com.au>
Message-ID: <Pine.LNX.4.10.10208291300130.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

I am just now getting back to crawling speeds in the 2.5 tree.
I can only comment on what works and what Viro tells me.
But if you think it needs to be globally set, until the updates from Jens
arrive, please send to Linus.  I am running my stuff by Viro and company.

Cheers,

On Thu, 29 Aug 2002, Andrew Morton wrote:

> Andre Hedrick wrote:
> > 
> > ...
> > There is one more thing to fix.
> > 
> > ./fs/mpage.c
> > 
> > /*
> >  * The largest-sized BIO which this code will assemble, in bytes.  Set this
> >  * to PAGE_CACHE_SIZE if your drivers are broken.
> >  */
> > #define MPAGE_BIO_MAX_SIZE 32768        //BIO_MAX_SIZE
> > 
> > This is confirmed with Al Viro and was required to make things sane!
> 
> You'll need to do the same thing to fs/direct-io.c:DIO_BIO_MAX_SIZE
> in that case.
> 
> I'd suggest that you just go in and change BIO_MAX_SECTORS
> to 64.   Or 32 if you happen to be using a qlogic controller :(
> 
> So everything's broken in there - a hardwired constant doesn't
> cut it.   Jens is cooking up an `add_page_to_bio()' API which
> will do the right thing based upon q->max_sectors.  But that
> is not yet available.
> 

Andre Hedrick
LAD Storage Consulting Group

