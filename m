Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWDHQQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWDHQQO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWDHQQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:16:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965009AbWDHQQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:16:13 -0400
Date: Sat, 8 Apr 2006 18:15:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Fabio Comolli <fabio.comolli@gmail.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Userland swsusp failure (mm-related)
Message-ID: <20060408161555.GA1722@elf.ucw.cz>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604081716.31836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604081716.31836.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
 
> > This is my first (and unique) failure since I began testing uswsusp
> > (2.6.17-rc1 version). It happened (I think) because more than 50% of
> > physical memory was occupied at suspend time (about 550 megs out og
> > 1G) and that was what I was trying to test. After freeing some memory
> > suspend worked (there was no need to reboot).
> 
> Well, it looks like we didn't free enough RAM for suspend in this case.
> Unfortunately we were below the min watermark for ZONE_NORMAL and
> we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
> ZONE_DMA in this case?).
> 
> I think we can safely ignore the watermarks in swsusp, so probably
> we can set PF_MEMALLOC for the current task temporarily and reset
> it when we have allocated memory.  Pavel, what do you think?

Seems little hacky but okay to me.

Should not fixing "how much to free" computation to free a bit more be
enough to handle this?
								Pavel
-- 
Thanks for all the (sleeping) penguins.
