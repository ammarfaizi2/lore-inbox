Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269762AbUHZXxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269762AbUHZXxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbUHZXtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:49:25 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:51419 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269681AbUHZXnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:43:33 -0400
Date: Fri, 27 Aug 2004 01:41:52 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Cc: Oliver Neukum <oliver@neukum.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
In-Reply-To: <20040826211642.GA30866@babylon.d2dc.net>
Message-ID: <Pine.LNX.4.58.0408270136440.17528@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
 <200408200956.50972.oliver@neukum.org> <4125B111.2040308@yahoo.com.au>
 <200408201052.51178.oliver@neukum.org> <20040826211642.GA30866@babylon.d2dc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Zephaniah E. Hull wrote:

> On Fri, Aug 20, 2004 at 10:52:51AM +0200, Oliver Neukum wrote:
> > Am Freitag, 20. August 2004 10:06 schrieb Nick Piggin:
> > > >>So I'd say try to find a way to only use PF_MEMALLOC on behalf of
> > > >>a PF_MEMALLOC thread or use a mempool or something.
> > > >
> > > >
> > > > Then the SCSI layer should pass down the flag.
> > > >
> > >
> > > It would be ideal from the memory allocator's point of view to do it
> > > on a per-request basis like that.
> > >
> > > When the rubber hits the road, I think it is probably going to be very
> > > troublesome to do it right that way. For example, what happens when
> > > your usb-thingy-thread blocks on a memory allocation while handling a
> > > read request, then the system gets low on memory and someone tries to
> > > free some by submitting a write request to the USB device?
> >
> > The write request will have to wait.
>
> > Storage cannot do concurrent IO.
>
> I'm going to jump in here and ask a simple question, what is the
> blocking point that stops writes happening concurrent with reads?

If writing process can't allocate request, because there's not enough
memory, it synchronously waits for some other request to terminate. This
is true for all block devices.

Mikulas
