Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268322AbTBMX30>; Thu, 13 Feb 2003 18:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268325AbTBMX30>; Thu, 13 Feb 2003 18:29:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:179 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268322AbTBMX3Y>;
	Thu, 13 Feb 2003 18:29:24 -0500
Date: Thu, 13 Feb 2003 15:37:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: larry@minfin.bg, linux-kernel@vger.kernel.org
Subject: Re: Strange TCP with 2.5.60
Message-Id: <20030213153748.1e4df3cc.akpm@digeo.com>
In-Reply-To: <Pine.LNX.3.96.1030213182617.13463A-100000@gatekeeper.tmr.com>
References: <20030212102418.3a15b4a8.akpm@digeo.com>
	<Pine.LNX.3.96.1030213182617.13463A-100000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 23:39:07.0556 (UTC) FILETIME=[19D47640:01C2D3B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
>
> On Wed, 12 Feb 2003, Andrew Morton wrote:
> 
> > Could you pelase retest with this patch, and tell us how many of these
> > problems go away?
> > 
> > diff -puN net/ipv4/fib_hash.c~a net/ipv4/fib_hash.c
> > --- 25/net/ipv4/fib_hash.c~a	2003-02-12 10:23:55.000000000 -0800
> > +++ 25-akpm/net/ipv4/fib_hash.c	2003-02-12 10:24:00.000000000 -0800
> > @@ -941,7 +941,7 @@ static __inline__ struct fib_node *fib_g
> >  
> >  			if (!iter->zone)
> >  				goto out;
> > -			if (iter->zone->fz_next)
> > +			if (iter->zone->fz_next);
> >  				break;
> >  		}
> >  		
> > 
> > _
> 
> is that patch reversed, I hope? The if doesn't do a great deal.

It is deliberate.  It directly reverts a bugfix which was recently merged.

Apparently the problem is that this combined with recent seq_file conversions
has resulted in changed format of some /proc/net/foo files, which is
confusing some network admin apps.

It is being worked on.
