Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbSKKBRf>; Sun, 10 Nov 2002 20:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSKKBRe>; Sun, 10 Nov 2002 20:17:34 -0500
Received: from holomorphy.com ([66.224.33.161]:61619 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265308AbSKKBRd>;
	Sun, 10 Nov 2002 20:17:33 -0500
Date: Sun, 10 Nov 2002 17:21:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
Message-ID: <20021111012150.GO22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211091308250.10475-100000@montezuma.mastecende.com> <Pine.LNX.4.44.0211091044060.12487-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211091044060.12487-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 10:51:27AM -0800, Linus Torvalds wrote:
> No.
> You have two different cases:
>  - a kernel compiled for TSC-only. This one simply will not _work_ without 
>    a TSC, since it is statically compiled for the TSC case. Here, "notsc"
>    simply cannot do anything, so it just prints a message saying that it 
>    doesn't work.
>  - a "generic" kernel, which can do the TSC decision dynamically, will use 
>    the TSC flag in the CPU features field to decide whether to use the TSC
>    or not. Here, "notsc" will clear the flag unconditionally, so even if 
>    your CPU claims to have a TSC, it won't get used.
> NOTE! We used to do a lot more statically, and on the whole the hard-coded
> CONFIG_X86_TSC usage has pretty much disappeared in modern kernels. It's 
> used mainly by the "get_cycles()" macro, which is not all that commonly 
> used any more (it used to be used by the scheduler, I think that's gone 
> too these days).

Then the options have been mangled and it doesn't do this right anymore,
with the net result that there's no way to turn off TSC synch ever. I've
narrowed this down to config options setting CONFIG_X86_TSC for at least for
all cpu revisions > 586 plus unconditional TSC usage given CONFIG_X86_TSC.


Bill
