Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSJAKVf>; Tue, 1 Oct 2002 06:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJAKVf>; Tue, 1 Oct 2002 06:21:35 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:57496 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261565AbSJAKVe>;
	Tue, 1 Oct 2002 06:21:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Richard Zidlicky <rz@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.4 mm trouble [possible lru race]
Date: Tue, 1 Oct 2002 12:26:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux m68k <linux-m68k@lists.linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20020925122439.C198@linux-m68k.org> <Pine.LNX.4.44.0209281634240.338-100000@serv> <20021001112229.A235@linux-m68k.org>
In-Reply-To: <20021001112229.A235@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wKEl-0005tB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The theoretical lru race possibly spotted in the wild...

On Tuesday 01 October 2002 11:22, Richard Zidlicky wrote:
> On Sat, Sep 28, 2002 at 04:38:50PM +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Wed, 25 Sep 2002, Richard Zidlicky wrote:
> > 
> > > First I suspected a stale TLB entry so I've added pretty many
> > > extra flushes througout the code. This does very much reduce the
> > > risk of the problem, but the problem still happens if swapping is
> > > increased so it might very well be something else.
> > >
> > > Any ideas?
> > 
> > It sounds like a cache problem. I had to fix one early 2.4, so maybe there
> > is another one.
> > It would help a lot if you could reproduce it within gdb to get some more
> > information about the context of the crash (e.g. invalid data or code, the
> > type of mapping (from /proc/<pid>/maps)).
> 
> hm, I am now testing the appended patch, which is a backport to 2.4.19
> of this:
> 
<<<<<<<<<<<<
>
> From: Daniel Phillips <phillips@arcor.de>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>,
>         "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
> Subject: [CFT] [PATCH] LRU race fix
> Date: 	Tue, 17 Sep 2002 19:03:19 +0200
> X-Mailer: KMail [version 1.3.2]
> Cc: <linux-kernel@vger.kernel.org>
> 
> This patch against 2.4.20-pre7 fixes a theoretical race where a page could
> possibly be freed while still on the lru list.  The details have been
> discussed at length earlier, see "[RFC] [PATCH] Include LRU in page count".
> 
> The race may not even be that theoretical, it's just so rare that when it
> does happen, it might be dismissed as a driver problem or similar...
>
> [...]
>
>>>>>>>>>>>>

> Somehow this does completely fix my problem, I have taken out all
> the tlb related hacks and the testcase that caused the problem 100%
> now runs without any sign of problems :))
>
> Now I am wondering if that is just coincidence or why m68k hit that 
> error so reliably.. is it supposed to have any effect at all on
> UP?

Are you running UP+preempt?

-- 
Daniel
