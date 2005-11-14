Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVKNSXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVKNSXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKNSXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:23:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16304 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751222AbVKNSXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:23:53 -0500
Date: Mon, 14 Nov 2005 19:23:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
Message-ID: <20051114182341.GA28410@elte.hu>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com> <p73lkzt49wr.fsf@verdi.suse.de> <20051113073228.GA31468@elte.hu> <200511131153.25978.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511131153.25978.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> My point was basically that there is a lot of feature work going on on 
> x86-64 in this area, and that has priority over any "cleanups" like 
> this from my side. [...]

i think we are in agreement mostly, but this approach of yours is just 
... totally wrong. We are seeing an exponential increase in the 'cost' 
of new time features because they are being built ontop of a naive base 
that did not anticipate them. HRT was 'coming soon' for how many years - 
eight?

just take a look at all the VFS work Al Viro has done and is doing. 90% 
"cleanups", in preparation of a small 1000-line (or smaller) real 
feature thing. If it were done the other way around, we'd still be at 
5-10 poorly integrated filesystems and a poor VFS landscape - not at the 
current 50+ filesystems supported by the best VFS on this planet ...

or just take a look at all the work Jens Axboe & co has done in the past 
2 years, resurrecting the block IO code from the grave. Jens started at 
the basics (replacing bhs with bio's), cleaning up the mess at its root.  
Had they started adding pluggable IO schedulers and IO barriers as the 
_first_ step, the block IO layer would still be a pain point, instead of 
a poster-child.

i could go on with other examples. Networking. Firewall code. The MM.  
Driver architecture - and more. x86_64 did get rid of lots of i386 
legacies as well, so you are doing it too. Today's cleanliness is the 
basis for tomorrow's features, not the other way around. New features 
_always_ deform the code's internal structure, and if piled upon each 
other without cleanups inbetween then they form a massive, hard to 
change and hard to maintain chunk of spaghetti. The time code has been 
long overdue for a massive cleanup.

the Linux CPU architecture code is currently where the VFS was 5 years 
ago. Lots of consolidation work was done in the past 1-2 years, but both 
i386 and x86_64 still have at least 30% of code bloat that does not 
truly belong into architecture code. Now we have 25 main architectures, 
and every unnecessary unit of complexity gets multiplied by 25!  
Suggesting that generalization, common code and cleanups have a lower 
priority than features is really ignoring history and common sense.

	Ingo
