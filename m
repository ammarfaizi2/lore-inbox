Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRKEDDp>; Sun, 4 Nov 2001 22:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280143AbRKEDDg>; Sun, 4 Nov 2001 22:03:36 -0500
Received: from cogito.cam.org ([198.168.100.2]:59408 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S280132AbRKEDDZ>;
	Sun, 4 Nov 2001 22:03:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Mike Fedyk <mfedyk@matchmail.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC][PATCH] vm_swap_full
Date: Sun, 4 Nov 2001 21:58:17 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011104152341.A4C289E898@oscar.casa.dyndns.org> <Pine.LNX.4.33L.0111041436020.2963-100000@imladris.surriel.com> <20011104180840.A16017@mikef-linux.matchmail.com>
In-Reply-To: <20011104180840.A16017@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105025817.D997216E5C@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 09:08 pm, Mike Fedyk wrote:
> On Sun, Nov 04, 2001 at 02:36:34PM -0200, Rik van Riel wrote:
> > On Sun, 4 Nov 2001, Ed Tomlinson wrote:
> > > -/* Swap 50% full? Release swapcache more aggressively.. */
> > > -#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
> > > +/* Free swap less than inactive pages? Release swapcache more
> > > aggressively.. */ +#define vm_swap_full() (nr_swap_pages <
> > > nr_inactive_pages)
> > >
> > > Comments?
> >
> > Makes absolutely no sense for systems which have more
> > swap than RAM, eg. a 64MB system with 200MB of swap.
>
> How does the inactive list get bigger than physical ram?
>
> If swap is bigger than ram, there is *no* possibility of the inactive list
> being bigger than swap, and thus no aggressive swapping...

nr_swap_pages is the number of swap pages free.  The idea is to start
aggressive swap only when we are at risk of running out of swap.  This way
we get to take full advantage of throwing away clean pages that are backed
up by swap when under vm pressure. 

Ed Tomlinson
