Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275032AbRJANAd>; Mon, 1 Oct 2001 09:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275021AbRJANAY>; Mon, 1 Oct 2001 09:00:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32273 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275020AbRJANAQ>; Mon, 1 Oct 2001 09:00:16 -0400
Date: Mon, 1 Oct 2001 08:37:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010927014431.C2164@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0110010835500.4491-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Sep 2001, Pavel Machek wrote:

> Hi!
> 
> > > > > So my suggestion was to look at getting anonymous pages backed by what
> > > > > amounts to a shared memory segment.  In that vein.  By using an extent
> > > > > based data structure we can get the cost down under the current 8 bits
> > > > > per page that we have for the swap counts, and make allocating swap
> > > > > pages faster.  And we want to cluster related swap pages anyway so
> > > > > an extent based system is a natural fit.
> > > >
> > > > Much of this goes away if you get rid of both the swap and anonymous page
> > > > special cases. Back anonymous pages with the "whoops everything I write here
> > > > vanishes mysteriously" file system and swap with a swapfs
> > >
> > > What exactly is anonymous memory? I thought it is what you do when you
> > > want to malloc(), but you want to back that up by swap, not /dev/null.
> >
> > Anonymous memory is memory which is not backed by a filesystem or a
> > device. eg: malloc()ed memory, shmem, mmap(MAP_PRIVATE) on a file (which
> > will create anonymous memory as soon as the program which did the mmap
> > writes to the mapped memory (COW)), etc.
> 
> So... how can alan propose to back anonymous memory with /dev/null?

I guess he means anonymous memory backed up by /dev/null means anonymous
memory backep up by nothing.

> [see above] It should be backed by swap, no?

Not necessarily. As soon as we need to swapout anon memory, we have to
back it up by swap. (mm/vmscan.c:try_to_swap_out() job)

