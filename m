Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSIWSLt>; Mon, 23 Sep 2002 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSIWSLt>; Mon, 23 Sep 2002 14:11:49 -0400
Received: from packet.digeo.com ([12.110.80.53]:18824 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261274AbSIWSLs>;
	Mon, 23 Sep 2002 14:11:48 -0400
Message-ID: <3D8F59DA.5ACD0044@digeo.com>
Date: Mon, 23 Sep 2002 11:13:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Grega Fajdiga <Gregor.Fajdiga@telemach.net>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.38-mm2
References: <20020923153301.2c87768d.Gregor.Fajdiga@telemach.net> <3D8F48D9.1D8BE9D@digeo.com> <20020923180435.GF15479@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 18:13:46.0311 (UTC) FILETIME=[F5309D70:01C2632C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Sep 23 2002, Andrew Morton wrote:
> > Grega Fajdiga wrote:
> > >
> > > Good day,
> > >
> > > I get this oops at startup in 2.5.38-mm2. The oops
> >
> > It's not an oops - it's just a warning.
> >
> > > ..
> > > Trace; c0117826 <__might_sleep+56/5d>
> > > Trace; c0134386 <kmalloc+66/1f0>
> > > Trace; c01d2e60 <ide_intr+0/1d0>
> >
> > ide_intr() is calling sleeping functions inside ide_lock.
> 
> this is ludicris, why on earth would ide_intr() call kmalloc() from its
> isr?! the trace is obviously bogus.
> 

Argh, sorry - brain is mush.  It's init_irq() which is calling
sleeping functions inside ide_lock.  The ide_intr is just stack gunk.
