Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269340AbUICHzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269340AbUICHzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbUICHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:55:21 -0400
Received: from [139.30.44.16] ([139.30.44.16]:32164 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S269340AbUICHxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:53:54 -0400
Date: Fri, 3 Sep 2004 09:51:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: George Anzinger <george@mvista.com>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <41381DC6.8050001@mvista.com>
Message-ID: <Pine.LNX.4.53.0409030949460.20327@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp> <412285A5.9080003@mvista.com>
 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
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
 <87u0uggxme.fsf@devron.myhome.or.jp> <4137C1FA.7070000@mvista.com>
 <87wtzct47h.fsf@ibmpc.myhome.or.jp> <41381DC6.8050001@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, George Anzinger wrote:

> OGAWA Hirofumi wrote:
> > in time_init(), and hpet_time_init(),
> >         xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> > should be
> >         xtime.tv_nsec = ((long)INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> > 
> > because
> > 	(INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ)		== 296000000
> > and
> > 	((long)INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ)	== 0
> 
> It is possible that I am missing something here, but I just don't see that it 
> matters.  If the wall clock is set jiffies is not changed so there is no implied 
> or actual alignment between these two.
> 
> Is there a calculation in the system that would differ if this were changed?

Yep, I also think it _should_ not matter at all. That's why I suggested 
setting it to zero, but maybe we just shouldn't touch it..

Tim
