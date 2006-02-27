Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWB0TDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWB0TDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWB0TDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:03:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10117 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751713AbWB0TDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:03:17 -0500
Date: Mon, 27 Feb 2006 20:02:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH -mm 1/2] mm: make shrink_all_memory overflow-resistant
Message-ID: <20060227190252.GJ2955@elf.ucw.cz>
References: <200602271926.20294.rjw@sisk.pl> <200602271928.22791.rjw@sisk.pl> <9a8748490602271053q6c92a844ied947fba859201d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602271053q6c92a844ied947fba859201d1@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 27-02-06 19:53:47, Jesper Juhl wrote:
> On 2/27/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Make shrink_all_memory() overflow-resistant.
> >
> >
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
> What about the callers of shrink_all_memory() who currently expect it
> to return an int, have you checked how they will react to you changing
> the return type (and signedness) ?

That's okay, we checked all 3 callers :-).
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
