Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbTGMXvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270457AbTGMXvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:51:21 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:49097 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270458AbTGMXvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:51:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Guillaume Chazarain <gfc@altern.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Mon, 14 Jul 2003 10:07:34 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de, smiler@lanil.mine.nu
References: <ZTEANKTPFA5YUR93JFQE096KF85YA8.3f1172b0@monpc>
In-Reply-To: <ZTEANKTPFA5YUR93JFQE096KF85YA8.3f1172b0@monpc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141007.34608.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 00:54, Guillaume Chazarain wrote:
> 13/07/03 14:53:12, Con Kolivas <kernel@kolivas.org> wrote:
> >On Sun, 13 Jul 2003 20:41, Guillaume Chazarain wrote:
> >> Hi Con,
> >>
> >> I am currently testing SCHED_ISO, but I have noticed a regression:
> >> I do a make -j5 in linux-2.5.75/ everything is OK since gcc prio is 25.
> >> X and fvwm prio are 15, but when I move a window it's very jerky.
> >
> >Interesting. I don't know how much smaller the timeslice can be before
> >different hardware will be affected. Can you report what cpu and video
> > card you're using? Unfortunately I don't have a range of hardware to test
> > it on and I chose the aggressive 1/5th timeslice size. Can you try with
> > ISO_PENALTY set to 2 instead?
>
> Pentium3 450, 320 Mo RAM, Voodoo Banshee
>
> Good, with ISO_PENALTY == 2, I can smoothly move big windows (with
> ISO_PENALTY == 5 it was smooth only with very small windows), but it lets
> me move them smoothly during less time than stock :(

Less time than stock? I don't understand you. You can only move them smoothly 
for a small time or they move faster or... ?

> >> And btw, as I am interested in scheduler improvements, do you have a
> >> testcase where the stock scheduler does the bad thing? Preferably
> >> without KDE nor Mozilla (I don't have them installed, and I'll have
> >> access to a decent connection in september).
> >
> >Transparency and antialiased fonts are good triggers. Launcing Xterm with
> >transparency has been known to cause skips. Also the obvious make -j 4
> > kernel compiles, and
> >while true ; do a=2 ; done
> >as a fast onset full cpu hog
>
> Well, I had a hard time at making xmms skip with a transparent
> gnome-terminal. I could easily make xmms skip with this, but it's quite
> artificial.

Indeed it is artificial, and probably never a real world condition unless it 
was specifically an attack, but it would never bring the system to a halt, 
just some minor audio hiccups while it adjusted. 

> >The logical conclusion of this idea where there is a dynamic policy
> > assigned to interactive tasks is a dynamic policy assigned to non
> > interactive tasks that get treated in the opposite way. I'll code
> > something for that soon, now that I've had more feedback on the first
> > part.
>
> Interesting, let's see :)
> But as the interactive bonus can already be negative I wonder what use
> will have another variable.

As it is, the penalty will be no different to what it currently gets to (in 
the same way sched_iso get the same bonus they normally would). The 
difference is once they are moved to the different policy it is much harder 
for them to change from that state, always getting the maximum penalty, and 
being expired each time they run out of timeslice instead of getting a chance 
to be put onto the active array. Neither of these new states is very 
different to what normal policy tasks get except for the fact they dont 
change interactive state without a lot more effort.

Con

