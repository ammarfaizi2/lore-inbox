Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268189AbTBNBLe>; Thu, 13 Feb 2003 20:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268191AbTBNBLe>; Thu, 13 Feb 2003 20:11:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62355 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268189AbTBNBLd>; Thu, 13 Feb 2003 20:11:33 -0500
Date: Thu, 13 Feb 2003 17:18:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Bill Davidsen <davidsen@tmr.com>
cc: larry@minfin.bg, linux-kernel@vger.kernel.org
Subject: Re: Strange TCP with 2.5.60
Message-ID: <17320000.1045185481@[10.10.2.4]>
In-Reply-To: <20030213153748.1e4df3cc.akpm@digeo.com>
References: <20030212102418.3a15b4a8.akpm@digeo.com>
 <Pine.LNX.3.96.1030213182617.13463A-100000@gatekeeper.tmr.com>
 <20030213153748.1e4df3cc.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Could you pelase retest with this patch, and tell us how many of these
>> > problems go away?
>> > 
>> > diff -puN net/ipv4/fib_hash.c~a net/ipv4/fib_hash.c
>> > --- 25/net/ipv4/fib_hash.c~a	2003-02-12 10:23:55.000000000 -0800
>> > +++ 25-akpm/net/ipv4/fib_hash.c	2003-02-12 10:24:00.000000000 -0800
>> > @@ -941,7 +941,7 @@ static __inline__ struct fib_node *fib_g
>> >  
>> >  			if (!iter->zone)
>> >  				goto out;
>> > -			if (iter->zone->fz_next)
>> > +			if (iter->zone->fz_next);
>> >  				break;
>> >  		}
>> >  		
>> > 
>> > _
>> 
>> is that patch reversed, I hope? The if doesn't do a great deal.
> 
> It is deliberate.  It directly reverts a bugfix which was recently merged.
> 
> Apparently the problem is that this combined with recent seq_file
> conversions has resulted in changed format of some /proc/net/foo files,
> which is confusing some network admin apps.
> 
> It is being worked on.

Can't we do: 

-			if (iter->zone->fz_next)
+			/* if (iter->zone->fz_next) */

or something similar? Is much less confusing ...

M.

