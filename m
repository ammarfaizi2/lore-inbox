Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265391AbRF0TvW>; Wed, 27 Jun 2001 15:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265395AbRF0TvM>; Wed, 27 Jun 2001 15:51:12 -0400
Received: from pC19F5B04.dip.t-dialin.net ([193.159.91.4]:8964 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S265391AbRF0Tu5> convert rfc822-to-8bit;
	Wed, 27 Jun 2001 15:50:57 -0400
Message-ID: <3B3A38ED.8223B773@baldauf.org>
Date: Wed, 27 Jun 2001 21:50:06 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: VM deadlock
In-Reply-To: <910160000.993670608@tiny>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

> On Wednesday, June 27, 2001 02:43:57 PM -0300 Marcelo Tosatti
> <marcelo@conectiva.com.br> wrote:
> >
> > Looking at http://lists.omnipotent.net/reiserfs/200106/msg00214.html:
>
> Also from Xuan ;-)
>
> >
> >>> EIP; c0128228 <page_launder+b8/90c>   <=====
> > Trace; c01303df <refill_freelist+1f/54>
> > Trace; c01307e2 <getblk+f2/108>
> > Trace; c5141308 <END_OF_CODE+4e978b8/????>
> > Trace; c0176c4b <do_journal_end+63f/ac0>
> > Trace; c5160848 <END_OF_CODE+4eb6df8/????>
> > Trace; c01759e6 <journal_end_sync+16/1c>
> > Trace; c015e23a <reiserfs_write_inode+56/64>
> > Trace; c0141055 <try_to_sync_unused_inodes+101/1a8>
> > Trace; c01416dd <prune_icache+105/114>
> > Trace; c014170d <shrink_icache_memory+21/30>
> > Trace; c0128d67 <do_try_to_free_pages+2b/58>
> > Trace; c0128deb <kswapd+57/e4>
> > Trace; c0105434 <kernel_thread+28/38>
> >
> >
> >
> > refill_freelist() calls page_launder(GFP_BUFFER). Now GFP_BUFFER _will_
> > block writting out buffers with try_to_free_buffers().
>
> Grrr, how did I miss this before?  I thought Xuan's hang went away after
> pre3, so I didn't look into this trace hard enough.

Actually, it went away :-), but only because I switched back from
linux-2.4.6-pre3 to linux-2.4.5-pre5 or so due to a symbol problem ("do_softirq"
or the like) which made some of this kernels modules not loadable. So the bug
which caused my first report is not fixed.

>
>
> Reiserfs expects write_inode() calls initiated by kswapd to always have
> sync==0.  Otherwise, kswapd ends up waiting on the log, which isn't what we
> want at all.
>
> The dirty inode callback ensures there are no dirty inodes that haven't
> been logged.  I took the sync parameter to mean it is initiated by fsync or
> O_SYNC, so I trigger a full commit when sync == 1.
>
> So, my choices are to ignore sync == 1 write_inode calls when kswapd is
> doing it, or make a private inode dirty list.
>
> >
> > Maybe thats the reason for the deadlock we're seeing here at this specific
> > trace ?
> >
>
> The trace above is caused by the dirty inode problem, the I think the more
> recent trace is something different.
>
> -chris

I also think that my new lockup is a different problem, because stack traces are
different. The only common things are that the kernel version number is benath
each other and I had to sit not virtually, but really in front of the monitor
connected to that box and write undecoded stack traces onto paper...

Xuân.


