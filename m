Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274166AbRISU0Z>; Wed, 19 Sep 2001 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274164AbRISU0G>; Wed, 19 Sep 2001 16:26:06 -0400
Received: from adsl-66-122-62-224.dsl.sntc01.pacbell.net ([66.122.62.224]:9040
	"HELO top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S274163AbRISUZ7>; Wed, 19 Sep 2001 16:25:59 -0400
From: brian@worldcontrol.com
Date: Wed, 19 Sep 2001 13:35:39 -0700
To: Dan Hollis <goemon@anime.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Athlon bug stomper: perf. results
Message-ID: <20010919133539.A11184@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Dan Hollis <goemon@anime.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com> <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 11:43:48AM -0700, Dan Hollis wrote:
> AFAIK noone has even tested it yet to see what it does to performance! Eg
> it might slow down memory access so that athlon-optimized memcopy is now
> slower than non-athlon-optimized memcopy. And if it turns out to be the
> case, we might as well just use the non-athlon-optimized memcopy instead
> of twiddling undocumented northbridge bits...

Ok. perhaps this will help:

System: AMD Duron 800Mhz Epox 8KAT3+ MB

I power cycled machine between tests:


Linux 2.4.9ac5 *without* althon bug stomper patch:

    oopes to death on boot.


Linux 2.4.9ac5 with athlon bug stomper patch:

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 19854 cycles per page
clear_page function '2.4 non MMX'        took 11991 cycles per page
clear_page function '2.4 MMX fallback'   took 11857 cycles per page
clear_page function '2.4 MMX version'    took 13666 cycles per page
clear_page function 'faster_clear_page'  took 4853 cycles per page
clear_page function 'even_faster_clear'  took 4819 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 19638 cycles per page
copy_page function '2.4 non MMX'         took 23855 cycles per page
copy_page function '2.4 MMX fallback'    took 24043 cycles per page
copy_page function '2.4 MMX version'     took 19550 cycles per page
copy_page function 'faster_copy'         took 10909 cycles per page
copy_page function 'even_faster'         took 11333 cycles per page


Linux 2.2.19:

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 14658 cycles per page
clear_page function '2.4 non MMX'        took 13254 cycles per page
clear_page function '2.4 MMX fallback'   took 13099 cycles per page
clear_page function '2.4 MMX version'    took 13005 cycles per page
clear_page function 'faster_clear_page'  took 4913 cycles per page
clear_page function 'even_faster_clear'  took 4887 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 19664 cycles per page
copy_page function '2.4 non MMX'         took 26431 cycles per page
copy_page function '2.4 MMX fallback'    took 26432 cycles per page
copy_page function '2.4 MMX version'     took 19537 cycles per page
copy_page function 'faster_copy'         took 11564 cycles per page
copy_page function 'even_faster'         took 11467 cycles per page



-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
