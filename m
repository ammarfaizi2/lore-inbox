Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266774AbUGLJv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbUGLJv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUGLJv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:51:59 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:53146 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266774AbUGLJv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:51:56 -0400
Message-ID: <40F25F0A.3060900@kolivas.org>
Date: Mon, 12 Jul 2004 19:51:06 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aivils@unibanka.lv
Cc: Ingo Molnar <mingo@elte.hu>, ck kernel mailing list <ck@vds.kolivas.org>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: Voluntary Preemption + concurent games
References: <20040709182638.GA11310@elte.hu> <20040711143853.GA6555@elte.hu> <20040711201753.GA11073@elte.hu> <200407121123.11520.aivils@unibanka.lv>
In-Reply-To: <200407121123.11520.aivils@unibanka.lv>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6568BF296D860409AF3C13FB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6568BF296D860409AF3C13FB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Aivils writes:

> Hi All!
> 
> 	I still use in my home minicomputer under Linux, where
> 3 users use one CPU/RAM , but own video.
> 	By default 2.6.XX task scheduler don' t like concurent applications
> at all. 2.6.XX task scheduler allways raise on top of tasks only one
> task and keep it on top until user stop it.
> 	This rule is very unwanted for minicomputers, because multile
> local users will use one CPU and feel lucky.
> 
> 	As point of reference i use 2.4.XX tack scheduler, which is very
> "righteous" and allways give CPU time for all tasks. Under 2.4.XX
> concurent games run smooth.
> 
> 	2.6.XX non-preemptive and 2.6.XX voluntary-preemptive task
> scheduling looks very similar. My gamer' s eye report me very
> thiny and very subjective difference - preferable is voluntary-preemtive.
> Anyway all concurent CPU intensive tasks should be started with
> nice -n +19 game-bin . Any other nice value remake one of
> running game to slide show or both running games became slide show.
> 
> 	So we should start any game with nice +19. In is this set goes in
> netscape and konqueror because of java web-chat and games.
> 
> 	At least voluntary-preemptive allow me move away from 2.4.26

I'm not sure I understand you. You said that voluntary preempt and 
preempt look the same yet in your last line you say voluntary preempt 
allows you to move away from 2.4.26?

Anyway apart from that comment I'm not really sure how you can address 
this because if nice +19 works at smoothing out the games then that 
almost surely suggests a yield() implementation in your games. 
Unfortunately this, I noticed while coding my new scheduler policy, 
seems to be _very_ common. There were lots of "big name" new games that 
did the same thing. It was decided quite a while back in 2.5 development 
that applications that use yield() for locking were broken by design. If 
nice +19 fixes the problem then all I can suggest for the time being is 
to use nice +19. The fact that the current processor is much more 
out-of-order in it's scheduling is what is fooling these applications 
now, and their unfortunate programming suffers in that setting.

What you need to cope with this is gang scheduling, but that's absurd to 
implement such a complicated policy to cope with poor application 
coding. Gang may be implemented in the future for different reasons, though.

Con

--------------enig6568BF296D860409AF3C13FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8l8NZUg7+tp6mRURAiQkAJ9JkQxLu/+j6l11wyJza5nFHhenQQCfS7hp
ziMIPE/ZsmV7XT7zCVogGh0=
=0vap
-----END PGP SIGNATURE-----

--------------enig6568BF296D860409AF3C13FB--
