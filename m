Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUHaVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUHaVGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUHaVCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:02:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58821 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267705AbUHaU7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:59:19 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
In-Reply-To: <4134D11B.7050800@mvista.com>
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
	 <1093916047.14662.144.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>
	 <4134D11B.7050800@mvista.com>
Content-Type: text/plain
Message-Id: <1093985817.14662.155.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 31 Aug 2004 13:56:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 12:27, George Anzinger wrote:
> Tim Schmielau wrote:
> > On Mon, 30 Aug 2004, john stultz wrote:
> >>On Mon, 2004-08-30 at 16:00, Tim Schmielau wrote:
> >>
> >>>George, please excuse my lack of understanding. What again where the
> >>>precise reasons to have an ntp-corrected uptime?
> >>
> >>Ah, here's the thread with the first mention of it that I could find.
> >>
> >>http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.1/1471.html
> 
> As I recall the problem was that jiffies since boot was being converted to get 
> uptime base on 1/HZ = 1 jiffie.  Since it is really not quite that, there was an 
> error.  Using clock_monotonic seemed like the right answer as it eliminated the 
> error AND made the result consistant with get_clock(CLOCK_MONOTONIC,..).
> 
> The alternate answer is, of course, to directly convert the elapsed jiffies. 
> The main problem with this is that this can be a BIG number and, therefor, the 
> math needs to be carefully.  And, of course, it is inconsistant with 
> get_clock(), but that is a new interface...

Hmmm. Well, I may be starting to lean in Tim's direction of pulling the
clock_monotonic based uptime and going back to the jiffies based uptime.
Atleast until we can make all the /proc/ output consistent. 

I just worry that it actually fixed a problem for someone, and backing
it out would just reopen that.

Thoughts?

-john


