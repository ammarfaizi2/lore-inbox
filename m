Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277334AbRJJRbE>; Wed, 10 Oct 2001 13:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277335AbRJJRay>; Wed, 10 Oct 2001 13:30:54 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:48893 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S277334AbRJJRaf>; Wed, 10 Oct 2001 13:30:35 -0400
Date: Wed, 10 Oct 2001 18:29:12 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011010182912.A4099@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0110042054490.4835-100000@imladris.rielhome.conectiva> <E15pWQA-0006bs-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15pWQA-0006bs-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 05, 2001 at 03:57:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 05, 2001 at 03:57:49PM +0100, Alan Cox wrote:
> > > We (as in Linux) should make sure that we explicitly tell the disk when
> > > we need it to flush its disk buffers. We don't do that right, and
> > > because of _our_ problems some people claim that writeback caching is
> > > evil and bad.
> > 
> > Does this even work right for IDE ?
> 
> Current IDE drives it may be a NOP. Worse than that it would totally ruin
> high end raid performance. We need to pass write barriers. A good i2o card
> might have 256Mb of writeback cache that we want to avoid flushing - because
> it is battery backed and can be ordered.

The important thing is to flush to non-volatile storage: non-volatile
cache still qualifies.  The one thing we need to avoid is the data
lingering in volatile cache, and that's a different thing.

Sure, journaling filesystems can benefit from a write barrier, but at
some point that's not sufficient --- we really need to know, at a high
level, whether the data is permanently secured.  When your MTA
finishes its fsync(), it assumes that the mail spool file has been
securely stored and it can tell the sender to go ahead and delete the
upstream copy.  

A barrier is not sufficient there.  It's a useful primitive to have,
but not a substitute for a flush to permanent storage.

--Stephen
