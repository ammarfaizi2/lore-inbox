Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280146AbRKEDKq>; Sun, 4 Nov 2001 22:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280154AbRKEDKh>; Sun, 4 Nov 2001 22:10:37 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59121
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280150AbRKEDKV>; Sun, 4 Nov 2001 22:10:21 -0500
Date: Sun, 4 Nov 2001 19:10:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] vm_swap_full
Message-ID: <20011104191014.C16017@mikef-linux.matchmail.com>
Mail-Followup-To: Ed Tomlinson <tomlins@cam.org>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20011104152341.A4C289E898@oscar.casa.dyndns.org> <Pine.LNX.4.33L.0111041436020.2963-100000@imladris.surriel.com> <20011104180840.A16017@mikef-linux.matchmail.com> <20011105025817.D997216E5C@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105025817.D997216E5C@oscar.casa.dyndns.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 09:58:17PM -0500, Ed Tomlinson wrote:
> On November 4, 2001 09:08 pm, Mike Fedyk wrote:
> > On Sun, Nov 04, 2001 at 02:36:34PM -0200, Rik van Riel wrote:
> > > On Sun, 4 Nov 2001, Ed Tomlinson wrote:
> > > > -/* Swap 50% full? Release swapcache more aggressively.. */
> > > > -#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
> > > > +/* Free swap less than inactive pages? Release swapcache more
> > > > aggressively.. */ +#define vm_swap_full() (nr_swap_pages <
> > > > nr_inactive_pages)
> > > >
> > > > Comments?
> > >
> > > Makes absolutely no sense for systems which have more
> > > swap than RAM, eg. a 64MB system with 200MB of swap.
> >
> > How does the inactive list get bigger than physical ram?
> >
> > If swap is bigger than ram, there is *no* possibility of the inactive list
> > being bigger than swap, and thus no aggressive swapping...
> 
> nr_swap_pages is the number of swap pages free.  

Oh, I thought it was total swap pages...

>The idea is to start
> aggressive swap only when we are at risk of running out of swap.  This way
> we get to take full advantage of throwing away clean pages that are backed
> up by swap when under vm pressure. 
> 
Yes.  My point is that the inactive list can't get bigger than RAM, and thus
if swap is bigger than ram this case wouldn't trigger...

But now that nr_swap_pages is *free* swap, you'll have to add another test
for (swap > RAM)... 

Mike
