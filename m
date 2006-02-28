Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWB1Raj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWB1Raj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWB1Raj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:30:39 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:38585 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932278AbWB1Raj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:30:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH -mm 1/2] mm: make shrink_all_memory overflow-resistant
Date: Tue, 28 Feb 2006 18:28:13 +0100
User-Agent: KMail/1.9.1
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200602271926.20294.rjw@sisk.pl> <200602271928.22791.rjw@sisk.pl> <20060227191630.467846d7.akpm@osdl.org>
In-Reply-To: <20060227191630.467846d7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281828.14277.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 04:16, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Make shrink_all_memory() overflow-resistant.
> > 
> 
> As you've probably noticed, I'm moving toward making all the scalars which
> hold counts of pages in the VM toward unsigned long.  For uniformity, and
> because there is a small risk that a huge machine with 4k pages could
> actually overflow a 32-bit counter.
> 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  include/linux/swap.h |    2 +-
> >  mm/vmscan.c          |    9 +++++----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
> > ===================================================================
> > --- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
> > +++ linux-2.6.16-rc4-mm2/mm/vmscan.c
> > @@ -1785,18 +1785,19 @@ void wakeup_kswapd(struct zone *zone, in
> >   * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
> >   * pages.
> >   */
> > -int shrink_all_memory(unsigned long nr_pages)
> > +unsigned long shrink_all_memory(unsigned int nr_pages)
> 
> So nr_pages should remain unsigned long.
> 
> > +	long long nr_to_free = nr_pages;
> 
> As should nr_to_free.

OK

> The actual bug is the (unsigned <= 0) thing.   So how's about this?

I like it (if my opinion matters here ;-)).  Thanks a lot.

