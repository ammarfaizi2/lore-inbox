Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319293AbSH2UdZ>; Thu, 29 Aug 2002 16:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSH2UdZ>; Thu, 29 Aug 2002 16:33:25 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:26634 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319293AbSH2UdY>; Thu, 29 Aug 2002 16:33:24 -0400
Message-ID: <3D6E85A0.A88FA63A@zip.com.au>
Date: Thu, 29 Aug 2002 13:35:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: /pub/linux/kernel/people/hedrick/ide-2.5.32
References: <3D6E7CBB.407299E3@zip.com.au> <Pine.LNX.4.10.10208291300130.24156-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a wee bit reluctant to shrink these settings globally,
because it will have a small impact on people's ongoing
evaluation of 2.5 on high-end SCSI hardware.

Could you please set BIO_MAX_SECTORS to 64 within the IDE
patch, and add a BIG FAT COMMENT?


Andre Hedrick wrote:
> 
> Andrew,
> 
> I am just now getting back to crawling speeds in the 2.5 tree.
> I can only comment on what works and what Viro tells me.
> But if you think it needs to be globally set, until the updates from Jens
> arrive, please send to Linus.  I am running my stuff by Viro and company.
> 
> Cheers,
> 
> On Thu, 29 Aug 2002, Andrew Morton wrote:
> 
> > Andre Hedrick wrote:
> > >
> > > ...
> > > There is one more thing to fix.
> > >
> > > ./fs/mpage.c
> > >
> > > /*
> > >  * The largest-sized BIO which this code will assemble, in bytes.  Set this
> > >  * to PAGE_CACHE_SIZE if your drivers are broken.
> > >  */
> > > #define MPAGE_BIO_MAX_SIZE 32768        //BIO_MAX_SIZE
> > >
> > > This is confirmed with Al Viro and was required to make things sane!
> >
> > You'll need to do the same thing to fs/direct-io.c:DIO_BIO_MAX_SIZE
> > in that case.
> >
> > I'd suggest that you just go in and change BIO_MAX_SECTORS
> > to 64.   Or 32 if you happen to be using a qlogic controller :(
> >
> > So everything's broken in there - a hardwired constant doesn't
> > cut it.   Jens is cooking up an `add_page_to_bio()' API which
> > will do the right thing based upon q->max_sectors.  But that
> > is not yet available.
> >
> 
> Andre Hedrick
> LAD Storage Consulting Group
