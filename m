Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbTATOMX>; Mon, 20 Jan 2003 09:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTATOMX>; Mon, 20 Jan 2003 09:12:23 -0500
Received: from ns1.netroute.cz ([212.71.168.2]:17569 "HELO pop3.netroute.cz")
	by vger.kernel.org with SMTP id <S265568AbTATOMW>;
	Mon, 20 Jan 2003 09:12:22 -0500
Date: Mon, 20 Jan 2003 15:21:19 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Balbir <balbir@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disabling file system caching
Message-ID: <20030120142119.GB1468@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, Balbir <balbir@ti.com>,
	linux-kernel@vger.kernel.org
References: <006f01c2c058$3748ad00$6353579d@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006f01c2c058$3748ad00$6353579d@india.ti.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 01:17:42PM +0530, Balbir wrote:
> Not sure if posting to the newsgroup linux.kernel sends
> it to the mailing list too.
> 
> "Balbir Singh" <balbir_soni@yahoo.com> wrote in message
> news:b0g6q2$lfq$1@tilde.itg.ti.com...
> > "Rik van Riel" <riel@conectiva.com.br> wrote in message
> > news:20030120011009$2d98@gated-at.bofh.it...
> > > On Sun, 19 Jan 2003, Jean-Eric Cuendet wrote:
> > >
> > > > Is it possible to disable file caching for a given partition or mount?
> > >
> > > No, if you do that mmap(), read(), write() etc. would be impossible.
> > >
> > > > Or at least to limit it at a certain quantity of memory?
> > >
> > > Not yet.  I'm thinking of implementing something like this
> > > for the next version of -rmap (reclaim only from the cache
> > > if the cache occupies more than a certain fraction of ram).
> >
> 
> I think that this feature is very important. In an embedded system
> using an NFS root filesystem, we found that the file cache
> would take a lot of memory and all insmods would fail. This is
> especially true when the system boots up and looks for /lib/modules.
> 
> I think it should be possible to modify the slab allocator to
> implement a memory pool. We could add a flag which would prevent
> the slab from growing beyond its initial size.
> 
> This approach would work only if the cache is allocated by
> using the slab allocator.

No, it's not! And the slab alocator should mercilessly rip the cache
when it needs some pages. In the NFS root case, I would guess it's
a problem of NFS implementation allocating too much kernel memory, since
both cache and user-land pages are riped in favor of kernel allocations.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
