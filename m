Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWDHXYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWDHXYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWDHXYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 19:24:38 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:20916 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965051AbWDHXYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 19:24:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Userland swsusp failure (mm-related)
Date: Sun, 9 Apr 2006 09:24:04 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Fabio Comolli <fabio.comolli@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <20060408161555.GA1722@elf.ucw.cz> <200604090047.17372.rjw@sisk.pl>
In-Reply-To: <200604090047.17372.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604090924.04951.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 April 2006 08:47, Rafael J. Wysocki wrote:
> Hi,
>
> On Saturday 08 April 2006 18:15, Pavel Machek wrote:
> > > > This is my first (and unique) failure since I began testing uswsusp
> > > > (2.6.17-rc1 version). It happened (I think) because more than 50% of
> > > > physical memory was occupied at suspend time (about 550 megs out og
> > > > 1G) and that was what I was trying to test. After freeing some memory
> > > > suspend worked (there was no need to reboot).
> > >
> > > Well, it looks like we didn't free enough RAM for suspend in this case.
> > > Unfortunately we were below the min watermark for ZONE_NORMAL and
> > > we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
> > > ZONE_DMA in this case?).
> > >
> > > I think we can safely ignore the watermarks in swsusp, so probably
> > > we can set PF_MEMALLOC for the current task temporarily and reset
> > > it when we have allocated memory.  Pavel, what do you think?
> >
> > Seems little hacky but okay to me.
> >
> > Should not fixing "how much to free" computation to free a bit more be
> > enough to handle this?
>
> Yes, but in that case we'll leave some memory unused. ;-)

How's the shrink_all_memory tweaks I sent performing for you Rafael? It may 
theoretically be prone to the same issue but I tried to make it less likely.

-- 
-ck
