Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130170AbRBZOrk>; Mon, 26 Feb 2001 09:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130222AbRBZOrT>; Mon, 26 Feb 2001 09:47:19 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:6664 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S130256AbRBZOpp>; Mon, 26 Feb 2001 09:45:45 -0500
Date: Mon, 26 Feb 2001 14:42:09 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Sven Rudolph <rudsve@drewag.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2 -> 2.4: /proc/net/tcp 10x slower ?
Message-ID: <20010226144209.A3379@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Sven Rudolph <rudsve@drewag.de>, linux-kernel@vger.kernel.org
In-Reply-To: <xfkelwlo7ny.fsf@uxrs2.drewag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <xfkelwlo7ny.fsf@uxrs2.drewag.de>; from rudsve@drewag.de on Mon, Feb 26, 2001 at 03:12:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The identd wot I wrote is still fast as anything on 2.4 :)

As you can see from this teeny sample of my ident log, I take just a little
over 1/100th of a second to respond (on average). :)

2001-02-25 16:18:35.714731500 Q [194.75.152.225] - [32907, 25]
2001-02-25 16:18:35.726085500 A [194.75.152.225] - [9a0c62e79c0df893bb96dd74/3a99305b/b0164] for [32907, 25] UID [506]
2001-02-26 09:41:02.535514500 Q [195.92.249.252] - [33363, 21]
2001-02-26 09:41:02.548884500 A [195.92.249.252] - [8c0babd7b8ab6830b7092839/3a9a24ae/8454c] for [33363, 21] UID [500]

By the way, the intention of my ident server was not to be fast, but just to be
a little simpler and less over-engineered than pidentd, and not to give out any
site-specific information (uid's etc).  The speed was a bonus.

Sean


On Mon, Feb 26, 2001 at 03:12:01PM +0100, Sven Rudolph wrote:
> Usually identd's on Linux parse /proc/net/tcp.
> 
> When migrating from Linux 2.2.17 to 2.4.2 identd became much slower.
> 
> I traced it back to the point where /proc/net/tcp is read.
> 
> On the same slightly loaded system:
> 
> 2.2.17 $ time cat /proc/net/tcp >/dev/null
> real    0m0.004s
> user    0m0.000s
> sys     0m0.010s
> 
> (Or sometimes 0.000s due to granularity)
> 
> 2.2.17 $ time cat /proc/net/tcp >/dev/null
> real    0m0.083s
> user    0m0.000s
> sys     0m0.080s
> 
> 
> Is this expected? Or is there a more efficient interface that identd
> should use?
> 
> 	Sven
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
