Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbSLSXcj>; Thu, 19 Dec 2002 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbSLSXcj>; Thu, 19 Dec 2002 18:32:39 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:14208 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267668AbSLSXcf> convert rfc822-to-8bit; Thu, 19 Dec 2002 18:32:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Fri, 20 Dec 2002 10:42:43 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212200850.32886.conman@kolivas.net> <1040337982.2519.45.camel@phantasy> <3E0253D9.94961FB@digeo.com>
In-Reply-To: <3E0253D9.94961FB@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201042.48161.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Robert Love wrote:
>> ...
>> Not too sure what to make of it.  It shows the interactivity estimator
>> does indeed help... but only if what you consider "important" is what is
>> considered "interactive" by the estimator.  Andrew will say that is too
>> often not the case.
>
>That is too often not the case.
>
>I can get the desktop machine working about as comfortably
>as 2.4.19 with:
>
># echo 10 > max_timeslice
># echo 0 > prio_bonus_ratio
>
>ie: disabling all the fancy new scheduler features :(
>
>Dropping max_timeslice fixes the enormous stalls which happen
>when an interactive process gets incorrectly identified as a
>cpu hog.  (OK, that's expected)
>
>But when switching virtual desktops some windows still take a
>large fraction of a second to redraw themselves.  Disabling the
>interactivity estimator fixes that up too.  (Not OK.  That's bad)
>
>hm.  It's actually quite nice.  I'd be prepared to throw away
>a few cycles for this.
>
>I don't expect the interactivity/cpuhog estimator will ever work
>properly on the desktop, frankly.  There will always be failure
>cases when a sudden swing in load causes it to make the wrong
>decision.
>
>So it appears that to stem my stream of complaints we need to
>merge scheduler_tunables.patch and edit my /etc/rc.local.

I guess this explains why my variable timeslice thingy in -ck helps on the 
desktop. Basically by shortening the timeslice it is masking the effect of 
the interactivity estimator under load. That is, it is treating the symptoms 
of having an interactivity estimator rather than tackling the cause.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+AllzF6dfvkL3i1gRAurrAJ97s1tW96zf+C6NfF2aDpdQM5iUkwCgjxc9
9uNvOEBjvsYIiQxc6yBZcks=
=pvhz
-----END PGP SIGNATURE-----
