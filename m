Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVAaSwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVAaSwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVAaSwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:52:30 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:29630 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261309AbVAaSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:52:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order memory allocations on suspend
Date: Mon, 31 Jan 2005 19:52:50 +0100
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <200501281454.23167.rjw@sisk.pl> <200501311510.12979.rjw@sisk.pl> <20050131182055.GB1507@elf.ucw.cz>
In-Reply-To: <20050131182055.GB1507@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501311952.51144.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 31 of January 2005 19:20, Pavel Machek wrote:
> Hi!
> 
> > > static inline void free_pagedir(struct pbe *pblist)
> > > {
> > >         struct pbe *pbe;
> > > 
> > >         while (pblist) {
> > >                 pbe = pblist + PB_PAGE_SKIP;
> > >                 pblist = pbe->next;
> > >                 free_page((unsigned long)pbe);
> > >         }
> > >         pr_debug("free_pagedir(): done\n");
> > > }
> > > 
> > > Should not you free_page(pblist) instead? This passes address in
> > > middle of page to free_page, that seems wrong.
> > 
> > Certainly.  It should be something like that:
> > 
> > while (pblist) {
> > 	pbe = pblist;
> > 	pblist = (pbe + PB_PAGE_SKIP)->next;
> > 	free_page((unsigned long)pbe);
> > }
> 
> Hmm, I see, my "fix" leaks one page of memory during each
> suspend... I've fixed it properly now and will eventually propagete it
> back.
> 
> This should be right..
> 
>         while (pblist) {
>                 pbe = (pblist + PB_PAGE_SKIP)->next;
>                 free_page((unsigned long)pblist);
>                 pblist = pbe;
>         }

Sure it is.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
