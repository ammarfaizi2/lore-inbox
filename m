Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUK2WdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUK2WdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUK2WdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:33:10 -0500
Received: from mail.dif.dk ([193.138.115.101]:25277 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261847AbUK2W2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:28:02 -0500
Date: Mon, 29 Nov 2004 23:37:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Domen Puncer <domen@coderock.org>
Cc: janitor@sternwelten.at, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ds1620: replace schedule_timeout() with 	msleep()
In-Reply-To: <20041129140929.GC7889@nd47.coderock.org>
Message-ID: <Pine.LNX.4.61.0411292336320.3389@dragon.hygekrogen.localhost>
References: <E1C2cAP-0007Rx-JK@sputnik> <Pine.LNX.4.61.0411281835430.3389@dragon.hygekrogen.localhost>
 <20041129140929.GC7889@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Domen Puncer wrote:

> On 28/11/04 18:39 +0100, Jesper Juhl wrote:
> > > +++ linux-2.6.9-rc1-bk7-max/drivers/char/ds1620.c	2004-09-01 19:34:43.000000000 +0200
> > > @@ -373,8 +373,7 @@ static int __init ds1620_init(void)
> > >  	th_start.hi = 1;
> > >  	ds1620_write_state(&th_start);
> > >  
> > > -	set_current_state(TASK_INTERRUPTIBLE);
> > > -	schedule_timeout(2*HZ);
> > > +	msleep(2000);
> > >  
> > >  	ds1620_write_state(&th);
> > >  
> > I'm wondering if 2000 is really the value we want here. As far as I can 
> > see, the  schedule_timeout(2*HZ);  line has been there as long back as 
> > since HZ was 100, so back then the delay would have been 200. if 200 is 
> > all it needs, then we are now sleeping 10 times as long as really needed.
> > What is the argument behind the value used?
> 
> It's right:
> schedule_timeout(2*HZ) sleeps for 2 seconds;
> msleep(2000) sleeps for 2000 miliseconds, and does not depend on what
> HZ is.
> 
It seems I didn't understand schedule_timeout() properly, thank you for 
the clarification.

-- 
Jesper

