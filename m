Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbTGZUB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTGZUB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:01:26 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:8644 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S269296AbTGZUBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:01:24 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 15:18:11 -0500
User-Agent: KMail/1.5.2
Cc: ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <20030726113522.447578d8.akpm@osdl.org>
In-Reply-To: <20030726113522.447578d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307271517.55549.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 13:35, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > Audio players fall into a special category of application, the kind where
> > it's not unreasonable to change the code around to take advantage of new
> > kernel features to make them work better.
>
> One shouldn't even need to modify the player application to start using a
> new scheduler policy - policy is inherited, so a wrapper will suffice:
>
> 	sudo /bin/run-something-as-softrr mplayer

True, and that's roughly what I do now (except just with elevated priority as 
opposed to a realtime scheduler policy).  However, it's more friendly to the 
system if the realtime priority is limited to just the thread that needs it, 
and that's why the application itself needs to provide the hint.

Zinf already does try to provide such a hint by setting a higher priority for 
its sound servicing thread.  Unfortunately, this is ignored unless zinf is 
running as root.  Given the number of bugs in Zinf, I am uncomfortable 
running the whole application as root.  It's altogether more conservative to 
limit the risk to a single, simple thread that can be easily audited.

> > Remember this word: audiophile.
>
> That is one problem space, and I guess if we fix that, we fix the X11
> problems too.
>
> Let us not lose sight of the other problem: particular sleep/run patterns
> as demonstrated in irman are causing extremem starvation.  Arguably we
> should be addressing this as the higher priority problem.

I agree it's the more important problem, but there are also more people 
already working on it, whereas over here in the audio corner, there are just 
Davide and me (sorry if I left anyone out, please feel free to flame me so I 
know who you are).

> It is interesting that Felipe says that stock 2.5.69 was the best CPU
> scheduler of the 2.5 series.  Do others agree with that?

I never tried audio until 2.5.73.  With Con's patches, life has been pretty 
good for me from then on, from the non-starvation point of view.

> And what about the O(1) backports?  RH and UL and -aa kernels?  Are people
> complaining about those kernels?  If not, why?  What is different?

In case anybody wants to hearken back to the good old days of 2.4, forget it. 
It is only good for sound if you are lucky enough to have a configuration it 
likes.  My unlucky wife on the other hand, who gets by with a 233 MHz K6 
(because she can) is running 2.4 and says sound skips whenever she does 
anything with the machine other that just letting it sit and play.  Now that 
I think of it, this will be an ideal machine for testing audio robustness, 
and scheduler robustness in general.

Regards,

Daniel

