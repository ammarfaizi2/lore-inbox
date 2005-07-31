Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVGaUVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVGaUVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVGaUVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:21:50 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:54410 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261990AbVGaUVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:21:50 -0400
Message-ID: <42ED32D3.9070208@andrew.cmu.edu>
Date: Sun, 31 Jul 2005 16:21:39 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Lee Revell <rlrevell@joe-job.com>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
In-Reply-To: <20050730201049.GE2093@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> First numbers were 0.5W on idle system; that shows what kind of
> powersaving can be done. Powersaving is no longer possible when artsd
> is not running, but that should not be used as argument against it.

It was an idle system with no display, zero daemons running, and the 
hard drive off.  In other words, a machine that nobody could use which 
might as well be hibrinating.  While it was an important test to find 
out the most one could hope to save, its unrealistic for an actual usage 
case.  The later test was more realistic, and not suprisingly showed 
quite a bit less power savings.

I really like having 250HZ as an _option_, but what I don't see is why 
it should be the _default_.  I believe this is Lee's position as well. 
Last I checked, ACPI and CPU speed scaling were not enabled by default; 
If users are willing to change all those other options, why can't we 
expect them to select 250HZ/100HZ?  Instead, we are quadrupling latency 
for desktop users (for little or no power savings), just so that laptop 
users can save enabling one option out of the many they already need to 
change.

I have a fixed-framerate app that had to busywait in the days of 2.4.x. 
  It was nice in 2.6.x to not have to busywait, but with 250HZ that code 
will be coming back again.  And unfortunately this app can't be made 
variable-framerate, as it is simulating video hardware.  The same goes 
for apps playing movies/animations; Sometimes programs just need a 
semi-accurate sleep, and can't demand root priveledges to get it.

I remember that 1000HZ was chosen in part so that fewer people would 
complain about the need for the Posix highres timers.  Well now that 
1000HZ is going away, can we have our highres timers or not?  My guess 
is no.  Thus we've predictably come back out here to complain.  All 
we're asking is that the default value be left alone until tick-skipping 
approaches and/or highres timers are given a chance to work.  That way 
we can see if we can find a solution that truly makes everyone happy.

In a sense I feel this whole thing boils down to the fact that we don't 
have something like "make laptop-config" and "make server-config".  I'm 
glad we could save 5.2% of the power for a laptop user by changing the 
defaults (as long as you remember to change other options too).  However 
I'm not sure it should come at the expense of those doing video or audio 
on a desktop.  Right now with the one-size-fits-all defaults, we end up 
having to make that tradeoff.

  - Jim Bruce
