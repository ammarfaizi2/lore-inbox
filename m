Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWB0TGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWB0TGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWB0TGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:06:16 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:13691 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751719AbWB0TGO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:06:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kxl4MLs8edKQPNzue49kabW0EVYy9bjl/TDO3TwcxBtkfyKgOxCRvrvwoNVU1MKLz0H2PpwTX9A/trKS5NM7SQARNnGZdw2kJJ0UE+YvYi+Z85CqOY+4FlYbpVsIr3+0U4zEOAGBr0yr78ciiEZhpiuLuu8eUyweh4iJMM6wtG0=
Message-ID: <9a8748490602271106r7589450bt6c0a56a03cfc3f1b@mail.gmail.com>
Date: Mon, 27 Feb 2006 20:06:13 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 1/2] mm: make shrink_all_memory overflow-resistant
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060227190252.GJ2955@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602271926.20294.rjw@sisk.pl> <200602271928.22791.rjw@sisk.pl>
	 <9a8748490602271053q6c92a844ied947fba859201d1@mail.gmail.com>
	 <20060227190252.GJ2955@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, Pavel Machek <pavel@suse.cz> wrote:
> On Po 27-02-06 19:53:47, Jesper Juhl wrote:
> > On 2/27/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > Make shrink_all_memory() overflow-resistant.
> > >
> > >
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  include/linux/swap.h |    2 +-
> > >  mm/vmscan.c          |    9 +++++----
> > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > >
> > > Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
> > > ===================================================================
> > > --- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
> > > +++ linux-2.6.16-rc4-mm2/mm/vmscan.c
> > > @@ -1785,18 +1785,19 @@ void wakeup_kswapd(struct zone *zone, in
> > >   * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
> > >   * pages.
> > >   */
> > > -int shrink_all_memory(unsigned long nr_pages)
> > > +unsigned long shrink_all_memory(unsigned int nr_pages)
> >
> > What about the callers of shrink_all_memory() who currently expect it
> > to return an int, have you checked how they will react to you changing
> > the return type (and signedness) ?
>
> That's okay, we checked all 3 callers :-).

I'm sure you did, I'm not saying you didn't.
All I'm asking for is a short explanation of why the changes the patch
makes are correct since that's not obvious to me, and I'd like to
understand the patch.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
