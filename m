Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVC3TDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVC3TDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVC3TBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:01:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:38565 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262402AbVC3SzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:55:17 -0500
Date: Wed, 30 Mar 2005 20:57:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, davej@redhat.com, jengelh@linux01.gwdg.de,
       penberg@gmail.com, rlrevell@joe-job.com, linux-os@analogic.com,
       arjan@infradead.org, vda@ilport.com.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050327205334.14a7b3c4.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0503302053100.2463@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
 <20050327174026.GA708@redhat.com> <Pine.LNX.4.62.0503280033130.2459@dragon.hyggekrogen.localhost>
 <20050327205334.14a7b3c4.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

Sorry about the late reply.


On Sun, 27 Mar 2005, Paul Jackson wrote:

> Jesper wrote:
> > What I'm trying to find out now is if there's a general consensus that 
> > these patches are worthwile and wanted or if they are unwanted and I'm 
> > wasting my time. 
> 
> Thanks for your good work so far, and your good natured tolerance of
> the excessively detailed discussions resulting.
> 
> I don't have a big preference either way - but a couple of questions:
> 
>  1) Do you have any wild guess of how many of these you've done so far,
>     and how many potentially remain that could be done?  Tens, hundreds,
>     thousands?
> 
That would indeed be a wild guess, I guess I've done somewhere inbetween 
50 and 200 so far, and I guess there's probably somewhere around 1-2000 
left... but, I'm guessing.


>  2) Any idea what was going on with the numbers you posted yesterday,
>     which, at least from what I saw at first glance, seemed to show
>     "if (likely(p)) kfree(p);" to be a good or best choice, for all
>     cases, including (p != NULL) being very unlikely?  That seemed
>     like a weird result.
> 
> If the use of "likely(p)" is almost always a winner, then the changes
> you've been doing, followed by a header file change:
> 
> 	static inline void kfree(const void *p)
> 	{
> 		if (likely(p))
> 			__kfree(p);	/* __kfree(p) doesn't check for NULL p */
> 	}
> 
> along the lines that Jan considered a few posts ago, might be a winner.
> 
> But since this "likely(p)" result seems so bizarre, it seems unlikely that
> the above kfree wrapper would be a winner.
> 
I don't think it matters much really. The way I read the numbers they seem 
to indicate that the performance impact is very small in any case, and I'm 
not even entirely sure my way of trying to measure is accurate, so I don't 
know how much should be read into those numbers... 


-- 
Jesper


