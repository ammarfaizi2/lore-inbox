Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQLSTms>; Tue, 19 Dec 2000 14:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQLSTmh>; Tue, 19 Dec 2000 14:42:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48906 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129588AbQLSTmf>; Tue, 19 Dec 2000 14:42:35 -0500
Date: Tue, 19 Dec 2000 15:18:50 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <3A3F904F.8FBC46A5@innominate.de>
Message-ID: <Pine.LNX.4.21.0012191517120.842-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Dec 2000, Daniel Phillips wrote:

> Marcelo Tosatti wrote:
> > 
> > On Mon, 18 Dec 2000, Stephen C. Tweedie wrote:
> > 
> > > Hi,
> > >
> > > On Sun, Dec 17, 2000 at 12:38:17AM -0200, Marcelo Tosatti wrote:
> > > > On Fri, 15 Dec 2000, Stephen C. Tweedie wrote:
> > > >
> > > > Stephen,
> > > >
> > > > The ->flush() operation (which we've been discussing a bit) would be very
> > > > useful now (mainly for XFS).
> > > >
> > > > At page_launder(), we can call ->flush() if the given page has it defined.
> > > > Otherwise use try_to_free_buffers() as we do now for filesystems which
> > > > dont care about the special flushing treatment.
> > >
> > > As of 2.4.0test12, page_launder() will already call the
> > > per-address-space writepage() operation for dirty pages.  Do you need
> > > something similar for clean pages too, or does Linus's new laundry
> > > code give you what you need now?
> > 
> > I think the semantics of the filesystem specific ->flush and ->writepage
> > are not the same.
> > 
> > Is ok for filesystem specific writepage() code to sync other "physically
> > contiguous" dirty pages with reference to the one requested by
> > writepage() ?
> > 
> > If so, it can do the same job as the ->flush() idea we've discussing.
> 
> Except that for ->writepage you don't have the option of *not* writing
> the specified page.

It does.

Both the swapper writepage() operation and shm_writepage() cannot be able
to write the page. 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
