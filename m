Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbVKYRhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVKYRhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 12:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVKYRhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 12:37:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932703AbVKYRhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 12:37:39 -0500
Date: Fri, 25 Nov 2005 09:33:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <20051125073854.GA16771@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.64.0511250918410.13959@g5.osdl.org>
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
 <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de>
 <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
 <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
 <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
 <20051125073854.GA16771@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Nov 2005, Chris Wedgwood wrote:
> 
> CPUs in embedded the space could outnumber desktops & servers greatly
> (cell phones, access pointers, routers, media players, etc).  Most of
> these will be UP for some time.

That's not entirely clear either.

There are definite advantages to SMP even in the embedded space - or, to 
put it more strongly: _especially_ in the embedded space.

Not only does power usage go up cubically with frequency (which means that 
two cores are a lot more efficient than one at double the frequency), but 
embedded space also often has some clear separation between tasks that 
-can- be threaded (and often part of is has real-time characteristics, so 
getting a core of its own can be a good thing). Often more so than in the 
desktop space.

Now, obviously, in the "4- or 8-bit microcontroller" kind of embedded 
space, SMP isn't going to be a big issue. But anything that already uses 
an ARM, MIPS or a PowerPC-like chip, going SMP is not at all ridiculous. 
That includes things like cellphones, where one core might be for 
communication functions, and one for smartphones. 

None of the cellphone manufacturers seem to be in the least interested in 
doing a "phone only" solution. They can already do that cheaply, they 
can't make much money off it, and they are all interested in features. And 
it really _is_ more power-efficient to have, say, a dual-core 200MHz chip 
than it is to have a single-core 300MHz one.

Now, sometimes those SMP systems will actually be used as "tightly coupled 
UP", where one of the CPU's is just basically a DSP. And from a power 
efficiency standpoint, having specialized hardware (and thus _A_MP rather 
than SMP) is obviously better, but in complex tasks - and communication 
tends to be that - general-purpose is often desirable enough that people 
will take the inefficiencies of a GP CPU over a fixed-function specialized 
DSP-kind of environment.

But SMP is absolutely _not_ unusual in embedded. It's been there for years 
already, and it's clearly moving downwards there too.

			Linus
