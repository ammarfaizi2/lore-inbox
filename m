Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbRAJHoG>; Wed, 10 Jan 2001 02:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131941AbRAJHn4>; Wed, 10 Jan 2001 02:43:56 -0500
Received: from ns.caldera.de ([212.34.180.1]:51986 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130846AbRAJHno>;
	Wed, 10 Jan 2001 02:43:44 -0500
Date: Wed, 10 Jan 2001 08:42:35 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@ns.caldera.de>, migo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110084235.A365@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@ns.caldera.de>, migo@elte.hu,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010109221254.A10085@caldera.de> <Pine.LNX.4.10.10101091318181.2331-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10101091318181.2331-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 01:26:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 01:26:44PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 9 Jan 2001, Christoph Hellwig wrote:
> > > 
> > > Look at sendfile(). You do NOT have a "bunch" of pages.
> > > 
> > > Sendfile() is very much a page-at-a-time thing, and expects the actual IO
> > > layers to do it's own scatter-gather. 
> > > 
> > > So sendfile() doesn't want any array at all: it only wants a single
> > > page-offset-length tuple interface.
> > 
> > The current implementations does.
> > But others are possible.  I could post one in a few days to show that it is
> > possible.
> 
> Why do you bother arguing, when I've shown you that even if sendfile()
> _did_ do multiple pages, it STILL wouldn't make kibuf's the right
> interface. You just snipped out that part of my email, which states that
> the networking layer would still need to do better scatter-gather than
> kiobuf's can give it for multiple send-file invocations.

Simple.  Because I stated before that I DON'T even want the networking
to use kiobufs in lower layers.  My whole argument is to pass a kiovec
into the fileop instead of a page, because it makes sense for other
drivers to use multiple pages, and doesn't hurt networking besides
the cost of one kiobuf (116k) and the processor cycles for creating
and destroying it once per sys_sendfile.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
