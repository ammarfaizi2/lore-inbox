Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUH3Xjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUH3Xjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUH3Xjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:39:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2041 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265331AbUH3Xjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:39:43 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
In-Reply-To: <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	 <1092787863.2429.311.camel@cog.beaverton.ibm.com>
	 <1092781172.2301.1654.camel@cube>
	 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
	 <20040819191537.GA24060@elektroni.ee.tut.fi>
	 <20040826040436.360f05f7.akpm@osdl.org>
	 <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1093909116.14662.105.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 30 Aug 2004 16:38:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 16:00, Tim Schmielau wrote:
> So I think we should not apply the patch, but rather back out the patch 
> that rebased uptime on a ntp-corrected timesource.
> There are too many statistics that are still based on jiffies or clock 
> ticks, and we cannot immediately change that without a large rework
> (although this might eventually happen according to John's proposal).
> And mixing two different timesources just won't work, regardles where we 
> draw the borderline between them.
> 
> George, please excuse my lack of understanding. What again where the
> precise reasons to have an ntp-corrected uptime?

If I remember correctly, folks were complaining that boot time was
drifting due to the same issue. 

So yes, a full rework of the time subsystem is needed, but it alone
won't fix all of these problems, its just the first step. Once we have a
sane time base that isn't dependent on regular timer ticks, we then need
to make the timer subsystem and every other subsystem to use that time
base instead of Jiffies/HZ. 

This isn't going to happen instantly by any means. I'm trying to get the
time of day rework finished as soon as I can, but I've got the day job
to do as well. In the mean time, we can staple gun any user visible
exported HZ/jiffies values so they are accurate (using ACTHZ or
gettimeofday), and also look into changing HZ to a less error-ful
value.  HZ=1001 has been suggested and looks quite promising (although
/net/schec/estimator.c wants a power of 4).

thanks
-john

