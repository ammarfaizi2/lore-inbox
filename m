Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130301AbQKGKAB>; Tue, 7 Nov 2000 05:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbQKGJ7w>; Tue, 7 Nov 2000 04:59:52 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:42247 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S130828AbQKGJ7n>;
	Tue, 7 Nov 2000 04:59:43 -0500
Date: Tue, 7 Nov 2000 10:59:34 +0100
From: Martin Mares <mj@suse.cz>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Message-ID: <20001107105934.B415@albireo.ucw.cz>
In-Reply-To: <mj@suse.cz> <200011070117.eA71H4v05257@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011070117.eA71H4v05257@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Mon, Nov 06, 2000 at 10:17:04PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Horst!

> Strange somebody from a distribution forgets _the_ most important use of
> modules: Remember old-time Slackware, with dozens of different boot
> diskettes, and the imperative to compile a kernel to your machine once you
> got it running?

But how is this related to automatic unloading of modules???

Even automatic loading is not needed for this purpose -- just make the startup
scripts load all the modules needed and you don't have to maintain complex
mappings from userspace device names to kernel drivers.

> The cases mentioned are cases where unloading (automatic or manual, doesn't
> matter) would break things. Just don't allow it, ever (IPv6 does this, for
> one example). Or fix the loading/unloading somehow. Strategies to be able
> to do so is what is being discussed here, BTW...

No, the cases mentioned are cases where automatic unloading breaks things,
but manual unloading is perfectly okay. Nobody expects you to preserve exact
hardware state and keep things working if you unload the driver manually,
but automatic unload should be perfectly transparent.

> Just force a non-zero count as long as the module is in use. Wait a
> minute... that is exactly what a non-zero count is supposed to mean!

Yes, but define "in use".  Does your "in use" mean "referenced by user space
or by other drivers" (== cannot be unloaded without crashing the system)
or "unloading this module makes something cease to work"?  Currently, the
use counts maintained by the drivers correspond to the first definition
which is the right definition when it comes to manual unloading, but it
gives you no clue when it comes to transparent automatic unloading.

> What is a "minimal ammount of memory" on the 1+Gb RAM machines I've seen
> discussed here isn't at all "minimal" for somebody who has to run Linux in
> 4Mb, preferably less...
 
> Linux came to be what it is today in large part because the PC nobody
> wanted anymore ("too slow", "can't run XYZ") became the router/firewall/web
> server/mail server/... over in some closet, and soon nobody even remembered
> where the machine was physically. Don't kill this.

In routers dreaming the ancient dreams from the elder days of their creation,
you need all the modules loaded all the time anyway, hence automatic unloading
doesn't apply. Even better use a monolithic kernel since it saves in average
half a page per driver. (Yes, I know that current distributions don't ship with
precompiled kernels suiting your machine, but current distributions don't run
on a 4MB 386 anyway.)

Also, I'm not advocating killing compatibility with such old hardware (which
I frequently use), but I'd very much like to avoid hacking all the drivers
just to support correctly some (although sometimes useful) ill defined feature.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"ADA -- A Dumb Acronym"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
