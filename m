Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWAEA61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWAEA61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWAEA6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:58:09 -0500
Received: from smtp-out.google.com ([216.239.45.12]:14607 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751082AbWAEA5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:57:53 -0500
Message-ID: <43BC6E82.1020701@google.com>
Date: Wed, 04 Jan 2006 16:55:30 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, mingo@elte.hu, tim@physik3.uni-rostock.de,
       arjan@infradead.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <43BB0B8B.1000703@mbligh.org> <20060104042822.GA3356@waste.org> <43BB6255.2030903@mbligh.org> <Pine.LNX.4.64.0601041356200.3668@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601041356200.3668@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > ...
> But even then it's actually really hard to measure. Cache effects tend to 
> be hard _anyway_ to measure, it's really hard when the interesting case is 
> the cold-cache case and can't even do simple microbenchmarks that repeat a 
> million times to get stable results.
> 
> So the best we can usually do is "microbenchmarks don't show any 
> noticeable _worse_ behaviour, and code size went down by 10%".

OK, that makes a lot of sense to me. It was just worrying that nobody 
seemed to be measuring performance _at all_, just talking about code 
size, which is all very nice, but not really an end goal (for most 
systems). It seems to me like a simple tradeoff - cycles vs cache 
misses, and people seem to be only looking at one side.

I wasn't trying to say it was bad ... just seemed insufficently 
justified to me (at least regression tested, as you say).

> So at a total guess, and taking the above numbers (that are questionable, 
> but hey, they should be ok as a starting point for WAGging), reducing code 
> size by 10% should give about 0.007 cycles per instruction in user space. 
> Whee. Not very noticeable. But on system code (the only thing the kernel 
> can help), it's actually a much more visible 0.05 CPI.
> 
> Yeah, the math is bogus, the numbers may be irrelevant, but it does show 
> why I$ should matter, even though it's much harder to measure.

The IBM PPC people had some fancy way of measuring CPI and were very 
interested in it. Perhaps we can taunt them into helping measure things.

M.
