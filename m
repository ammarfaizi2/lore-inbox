Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319057AbSIJGxJ>; Tue, 10 Sep 2002 02:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319058AbSIJGxJ>; Tue, 10 Sep 2002 02:53:09 -0400
Received: from packet.digeo.com ([12.110.80.53]:36066 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319057AbSIJGxJ>;
	Tue, 10 Sep 2002 02:53:09 -0400
Message-ID: <3D7D9B76.353BBEAB@digeo.com>
Date: Tue, 10 Sep 2002 00:12:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Daniel Phillips <phillips@arcor.de>, Jesse Barnes <jbarnes@sgi.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <E17oTES-0006qj-00@starship> <3D7CF93A.972FCC8D@digeo.com> <E17oVLe-0006uT-00@starship> <20020910064354.GM8719@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2002 06:57:46.0934 (UTC) FILETIME=[5E8C1560:01C25897]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Sep 09 2002, Daniel Phillips wrote:
> > On Monday 09 September 2002 21:40, Andrew Morton wrote:
> > > We need a general-purpose "read or write these pages to this blockdev"
> > > library function.
> >
> > I thought bio was supposed to be that.  In what way does it not suffice?
> > Simply because of not having a suitable wrapper?
> 
> a bio _can_ hold a number of pages, it's just that noone has written the
> bio_rw_pages() yet. Not that it would be hard...

It's simple if it's synchronous.  When I discussed this a while
back with the LVM and EVMS developers the consensus was that an
async API would be better - so we'd need some sort of completion
cookie or callback or whatever.

It would end up with almost as much state as the rather amazing
`struct dio'.

Of course, one could do a synchronous API and see if anyone really,
really complains ;)  But a bit of requirements-gathering would be
needed before getting in and coding it.
