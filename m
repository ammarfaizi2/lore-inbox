Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWCXPaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWCXPaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWCXPaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:30:52 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:10947 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750818AbWCXPav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:30:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] mm: swsusp shrink_all_memory tweaks
Date: Sat, 25 Mar 2006 02:30:07 +1100
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200231.50666.kernel@kolivas.org> <200603241807.41175.kernel@kolivas.org> <200603241616.06687.rjw@sisk.pl>
In-Reply-To: <200603241616.06687.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603250230.08140.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 02:16, Rafael J. Wysocki wrote:
> On Friday 24 March 2006 08:07, Con Kolivas wrote:
> > On Tuesday 21 March 2006 05:46, Rafael J. Wysocki wrote:
> > > swsusp_shrink_memory() is still wrong, because it will always fail for
> > > image_size = 0.  My bad, sorry.
> > >
> > > The appended patch (on top of yours) should fix that (hope I did it
> > > right this time).
> >
> > Well I discovered that if all the necessary memory is freed in one call
> > to shrink_all_memory we don't get the nice updating printout from
> >  swsusp_shrink_memory telling us we're making progress. So instead of
> >  modifying the function to call shrink_all_memory with the full amount
> > (and since we've botched swsusp_shrink_memory a few times between us), we
> > should limit it to a max of SHRINK_BITEs instead.
> >
> >  This patch is fine standalone.
> >
> >  Rafael, Pavel what do you think of this one?
>
> In principle it looks good to me, but when I tested the previous one I
> noticed shrink_all_memory() tended to return 0 prematurely (ie. when it was
> possible to free some more pages).  It only happened if more than 50% of
> memory was occupied by application data.
>
> Unfortunately I couldn't find the reason.

Perhaps it was just trying to free up too much in one go. There are a number 
of steps a mapped page needs to go through before being finally swapped and 
there are a limited number of iterations over it. Limiting it to SHRINK_BITEs 
at a time will probably improve that.

Cheers,
Con
