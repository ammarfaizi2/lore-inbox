Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSHUQUm>; Wed, 21 Aug 2002 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318360AbSHUQUm>; Wed, 21 Aug 2002 12:20:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39919 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318358AbSHUQUl>; Wed, 21 Aug 2002 12:20:41 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <20020821161317.GI1117@dualathlon.random>
References: <1028771615.22918.188.camel@cog>
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
	<1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random>
	<1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
	<15708.64483.439939.850493@kim.it.uu.se>
	<20020821131223.GB1117@dualathlon.random>
	<1029939024.26425.49.camel@irongate.swansea.linux.org.uk>
	<20020821143323.GF1117@dualathlon.random>
	<1029942115.26411.81.camel@irongate.swansea.linux.org.uk> 
	<20020821161317.GI1117@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 17:25:35 +0100
Message-Id: <1029947135.26845.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> certainly fair enough argument in theory, but in practice you're not
> going to risk running those apps in a laptop or in general with any
> power management that will decrease the frequency of the cpu anytime.

Any PIII with speedstep, any Athlon and PIV.

> Furthmore the speedstep right now today can crash any laptop that boots
> at reduced mhz and that switches to higher mhz at runtime, that change

Actually the reduced loops in the kernel seem to work fine

> of the tsc frequency simply make udelay run faster, and it'll break
> drivers easily. I suspect there's even an unfixable race condition in
> the speedstep hardware since it's not the kernel asking for the change

Fixed in the -ac tree for the non APM triggered case because we use
cpufreq code

> significant info via the tsc to userspace, and there's no way to know
> that your app isn't breaking because of numa, unless you disable the tsc
> to userspace.

And you can test that with notsc. Oh and you might also want the code
that makes notsc on a tsc only kernel print a warning btw. badtsc lets
you say "I have a brain cell" notsc lets you select "clueless app
checking mode"


As to the other issue. As soon as we have plug in tsc handling that can
use ACPI, x86-64, summit and other timer sources I'm very keen to put
the tsc based timer in as a fallback before the PIT, and to do chip
sanity checks on it (matching clockmul, not spudstop etc)

