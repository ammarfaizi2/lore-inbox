Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSFJRkL>; Mon, 10 Jun 2002 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSFJRkL>; Mon, 10 Jun 2002 13:40:11 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:23723 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315599AbSFJRkK> convert rfc822-to-8bit; Mon, 10 Jun 2002 13:40:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Mon, 10 Jun 2002 19:39:40 +0200
X-Mailer: KMail [version 1.4]
Cc: Roland Dreier <roland@topspin.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <200206101922.26985.oliver@neukum.name> <20020610172909.GE14252@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206101939.40269.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Juni 2002 19:29 schrieb Tom Rini:
> On Mon, Jun 10, 2002 at 07:22:26PM +0200, Oliver Neukum wrote:
> > > > So is the consensus now that in general drivers should make sure
> > > > any buffers passed to pci_map/unmap are aligned to SMP_CACHE_BYTES
> > > > (and a multiple of SMP_CACHE_BYTES in size)?  In other words if a
> > > > driver uses an unaligned buffer it should be fixed unless we can
> > > > prove (and document in a comment :) that it won't cause problems
> > > > on an arch without cache coherency and with a writeback cache.
> > >
> > > And how about we don't call it SMP_CACHE_BYTES too?  The processors
> > > where this matters certainly aren't doing SMP...
> >
> > Definitely we should call it something different so we can limit it to
> > architectures that need it.
>
> No.  We should just make it come out to a nop for arches that don't need
> it.  Otherwise we'll end up with ugly things like:
> #ifdef CONFIG_NOT_CACHE_COHERENT
> ...
> #else
> ...
> #endif
>
> All over things like USB...

You are right.

	Regards
		Oliver


