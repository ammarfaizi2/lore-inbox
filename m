Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269236AbUICHSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbUICHSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUICHSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:18:24 -0400
Received: from [139.30.44.16] ([139.30.44.16]:28836 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S269387AbUICHR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:17:56 -0400
Date: Fri, 3 Sep 2004 09:15:14 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: george@mvista.com, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <87u0uggxme.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.53.0409030910140.20165@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp> <20040816124136.27646d14.akpm@osdl.org>
 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
 <412285A5.9080003@mvista.com> <1092782243.2429.254.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
 <1092787863.2429.311.camel@cog.beaverton.ibm.com> <1092781172.2301.1654.camel@cube>
 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
 <20040819191537.GA24060@elektroni.ee.tut.fi> <20040826040436.360f05f7.akpm@osdl.org>
 <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
 <1093916047.14662.144.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>
 <87fz61yf75.fsf@devron.myhome.or.jp> <4137896E.5080802@mvista.com>
 <87u0uggxme.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, OGAWA Hirofumi wrote:

> Since INITIAL_JIFFIES is -5 minutes, so I though tv.tv_nsec should be 0.
> The cause of this is
> 
>      INITIAL_JIFFIES % HZ (4294667296 % 1000)
> 
> because INITIAL_JIFFIES is unsigned long.
> 
> So, I guessed this is not intention.
> Looks like this should be (-300*1000) % 1000.

I think actually the whole xtime initialisation

        xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);

is bogus. INITIAL_JIFFIES should not be connected to any actual time, so 
this should really just be

        xtime.tv_nsec = 0;

I'll try to do a patch later on, and see what happens. Have to do some  
work-related things now.

Tim
