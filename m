Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268560AbTBYVVh>; Tue, 25 Feb 2003 16:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268505AbTBYVVh>; Tue, 25 Feb 2003 16:21:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:20146 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268560AbTBYVU7>;
	Tue, 25 Feb 2003 16:20:59 -0500
Date: Tue, 25 Feb 2003 13:27:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: zilvinas@gemtek.lt, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.62-mm3 - no X for me
Message-Id: <20030225132755.241e85ac.akpm@digeo.com>
In-Reply-To: <131360000.1046195828@[10.1.1.5]>
References: <20030223230023.365782f3.akpm@digeo.com>
	<3E5A0F8D.4010202@aitel.hist.no>
	<20030224121601.2c998cc5.akpm@digeo.com>
	<20030225094526.GA18857@gemtek.lt>
	<20030225015537.4062825b.akpm@digeo.com>
	<131360000.1046195828@[10.1.1.5]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 21:31:03.0541 (UTC) FILETIME=[32C1D250:01C2DD15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Tuesday, February 25, 2003 01:55:37 -0800 Andrew Morton
> <akpm@digeo.com> wrote:
> 
> > Ah, thank you.
> > 
> > 	kernel BUG at mm/rmap.c:248!
> > 
> > The fickle finger of fate points McCrackenwards.
> 
> Yep.  He tripped over my sanity check that pages not marked anon actually
> have a real mapping pointer.  Apparently X allocates a page that should be
> marked anon but isn't.

Wonder where that came from?

> My main reason for adding the anon flag was to prove to myself that the
> mapping pointer can be trusted.  Apparently it can, generally, but it looks
> like I haven't successfully tracked down all the places that should set it.
> It looks like anon pages can come from random sources, so it might be an
> impossible task to find them all.

Yes, the debug check is important at this time.

> I know you said you like the idea of having the flag, but I think the
> cleanest fix would be to change the check from
> 
> 	if (PageAnon(page))
> to
> 	if (page->mapping && !PageSwapCache(page))

Well I'm not particularly overjoyed by the flag.  What I liked was that we
have a place where we can implement anonymous page counting, so we get
another interesting number in /proc/meminfo.  Minor point.

> Or I could set the anon flag based on that test.  I know page flags are
> getting scarce, so I'm leaning toward removing the flag entirely.
> 
> What would you recommend?

Keep the flag for now, find the escaped page under X, remove the flag later?

