Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVGIMGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVGIMGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 08:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVGIMEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 08:04:11 -0400
Received: from [203.171.93.254] ([203.171.93.254]:2458 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261343AbVGIMAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 08:00:49 -0400
Subject: Re: [PATCH] [9/48] Suspend2 2.1.9.8 for 2.6.12:
	354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050709114936.GA1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164401343@foobar.com>
	 <20050709114936.GA1878@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120910522.7716.126.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 09 Jul 2005 22:02:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-07-09 at 21:49, Pavel Machek wrote:
> Hi!
> 
> > diff -ruNp 360-reset-kswapd-max-order-after-resume.patch-old/mm/vmscan.c 360-reset-kswapd-max-order-after-resume.patch-new/mm/vmscan.c
> > --- 360-reset-kswapd-max-order-after-resume.patch-old/mm/vmscan.c	2005-07-06 11:18:05.000000000 +1000
> > +++ 360-reset-kswapd-max-order-after-resume.patch-new/mm/vmscan.c	2005-07-04 23:14:20.000000000 +1000
> > @@ -1228,8 +1228,10 @@ static int kswapd(void *p)
> >  	order = 0;
> >  	for ( ; ; ) {
> >  		unsigned long new_order;
> > -
> > -		try_to_freeze();
> > +		if (freezing(current)) {
> > +			try_to_freeze();
> > +			pgdat->kswapd_max_order = 0;
> > +		}
> 
> Why not
> 	if (try_to_freeze())
> 		pgdat->... = 0;
> 
> ?

I have no idea. Fixed. Thanks!

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

