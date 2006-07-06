Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWGFA4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWGFA4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWGFA4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:56:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49820 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965104AbWGFA4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:56:14 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607051406480.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
	 <Pine.LNX.4.64.0606281335380.17704@scrub.home>
	 <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu>
	 <1151695569.5375.22.camel@localhost.localdomain>
	 <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607030256581.17704@scrub.home>
	 <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607051406480.12900@scrub.home>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:56:11 -0700
Message-Id: <1152147371.24656.122.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 02:37 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 5 Jul 2006, Valdis.Kletnieks@vt.edu wrote:
> > [   29.528533] Time: tsc clocksource has been installed.
> > [   29.552855] clock changed at -296333 (4294314460971008)
> > [   29.577109] clock tsc: m:2628985,s:22,cl:47171945132,ci:1595166,xn:0,xi:4193667486510,e:0
> > [   29.601869] big adj at -296332 (4294314460971008,-16,-25522656,-11031712)
> > [   29.626688] clock tsc: m:2628985,s:22,cl:47288392250,ci:1595166,xn:148610636380190,xi:4193667486510,e:-76300711936
> > [   29.652263] big adj at -296331 (4294314460971008,512,816724992,737704960)
> > [   29.677968] clock tsc: m:2628969,s:22,cl:47368150550,ci:1595166,xn:358292745604602,xi:4193641963854,e:1193037240320
> 
> Ok, I see now the problem, the last cycle value is always at least 50 
> times incremented between adjustments and that also means any error 
> adjustment is applied at least 50 times, which quickly gets out of 
> control.
> Is it possible that your console output is really slow? Otherwise I can't 
> explain these numbers, everything looks initialized fine for a 1.6GHz 
> clock, but it seems to take ages to print a single line.

Dang! You beat me to the analysis :)  I think we're on the same page
here.


> I have to run some tests and later this week there should be a new patch 
> compensating for this.

Look forward to it.

> John, now I also know why your version survived this, it did the error 
> correction in the update loop, this kept error small, but it also caused 
> the time to jump around, since it changed the multiplier in the past.

Yep, agreed.

thanks
-john

