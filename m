Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbQLSRQu>; Tue, 19 Dec 2000 12:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQLSRQk>; Tue, 19 Dec 2000 12:16:40 -0500
Received: from hermes.mixx.net ([212.84.196.2]:44814 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129408AbQLSRQ1>;
	Tue, 19 Dec 2000 12:16:27 -0500
Message-ID: <3A3F904F.8FBC46A5@innominate.de>
Date: Tue, 19 Dec 2000 17:43:59 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <20001218114612.E21351@redhat.com> <Pine.LNX.4.21.0012191008360.836-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Mon, 18 Dec 2000, Stephen C. Tweedie wrote:
> 
> > Hi,
> >
> > On Sun, Dec 17, 2000 at 12:38:17AM -0200, Marcelo Tosatti wrote:
> > > On Fri, 15 Dec 2000, Stephen C. Tweedie wrote:
> > >
> > > Stephen,
> > >
> > > The ->flush() operation (which we've been discussing a bit) would be very
> > > useful now (mainly for XFS).
> > >
> > > At page_launder(), we can call ->flush() if the given page has it defined.
> > > Otherwise use try_to_free_buffers() as we do now for filesystems which
> > > dont care about the special flushing treatment.
> >
> > As of 2.4.0test12, page_launder() will already call the
> > per-address-space writepage() operation for dirty pages.  Do you need
> > something similar for clean pages too, or does Linus's new laundry
> > code give you what you need now?
> 
> I think the semantics of the filesystem specific ->flush and ->writepage
> are not the same.
> 
> Is ok for filesystem specific writepage() code to sync other "physically
> contiguous" dirty pages with reference to the one requested by
> writepage() ?
> 
> If so, it can do the same job as the ->flush() idea we've discussing.

Except that for ->writepage you don't have the option of *not* writing
the specified page.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
