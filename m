Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUEDGNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUEDGNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 02:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEDGNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 02:13:55 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:22945 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264244AbUEDGNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 02:13:52 -0400
Date: Tue, 4 May 2004 08:12:34 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, george@mvista.com,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
In-Reply-To: <1083638458.9664.134.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0405040804180.2215@gockel.physik3.uni-rostock.de>
References: <403D0F63.3050101@mvista.com>  <1077760348.2857.129.camel@cog.beaverton.ibm.com>
  <403E7BEE.9040203@mvista.com>  <1077837016.2857.171.camel@cog.beaverton.ibm.com>
  <403E8D5B.9040707@mvista.com>  <1081895880.4705.57.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de> 
 <1081967295.4705.96.camel@cog.beaverton.ibm.com>  <20040415103711.GA320@elektroni.ee.tut.fi>
  <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de> 
 <20040415161436.GA21613@elektroni.ee.tut.fi> 
 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de> 
 <20040501184105.2cd1c784.akpm@osdl.org>  <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>
 <1083638458.9664.134.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, john stultz wrote:

> On Sat, 2004-05-01 at 18:59, Tim Schmielau wrote:
> >
> > Yep, we'd need to include timex.h for it. This get's messy. 
> 
> Well, not too messy. Including timex.h looks to resolve the issue
> without trouble. Let me know if I somehow stepped over an issue. 

It looks ok, but somehow defeats the whole purpose of having separate
include files. Someday we may consolidate all the time related things
into just one ore two header files then.

> jiffies-to-clockt-fix_A1:
> -------------------------

Thanks, John!

> All, 
> 	This patch polishes up Tim Schmielau's (tim@physik3.uni-rostock.de) fix
> for jiffies_to_clock_t() and jiffies_64_to_clock_t(). The issues
> observed was w/ /proc output not matching up to wall time due to
> accumulated error caused by HZ not being exactly 1000 on i386 systems.
> The solution is to correct that error by using the more accurate
> TICK_NSEC in our calculation. 

I wonder whether it's conceptually correct to use jiffies for accurate 
long-time measurements at all. ntpd is there for a reason. Using both
corrected, accurate and freely running clocks IMHO is calling for trouble. 
This might be something to think about for 2.7.

Thanks,
Tim
