Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274164AbRISUgZ>; Wed, 19 Sep 2001 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274178AbRISUgR>; Wed, 19 Sep 2001 16:36:17 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:20489 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274176AbRISUgE>; Wed, 19 Sep 2001 16:36:04 -0400
Date: Wed, 19 Sep 2001 22:36:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dan Hollis <goemon@anime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010919223626.B3775@suse.cz>
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com> <Pine.LNX.4.30.0109191141560.24917-100000@anime.net> <3BA8EA04.E55BAA02@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA8EA04.E55BAA02@redhat.com>; from arjanv@redhat.com on Wed, Sep 19, 2001 at 07:55:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 07:55:00PM +0100, Arjan van de Ven wrote:
> Dan Hollis wrote:
> > 
> > On Wed, 19 Sep 2001, Linus Torvalds wrote:
> > > It is _probably_ an undocumented performance thing, and clearing that
> > > bit may slow something down. But it might also change some behaviour,
> > > and knowing _what_ the behaviour is might be very useful for figuring
> > > out what it is that triggers the problem.
> > 
> > AFAIK noone has even tested it yet to see what it does to performance! Eg
> > it might slow down memory access so that athlon-optimized memcopy is now
> > slower than non-athlon-optimized memcopy. And if it turns out to be the
> > case, we might as well just use the non-athlon-optimized memcopy instead
> > of twiddling undocumented northbridge bits...
> 
> Ok but that part is simple:
> 
> run
> 
> http://www.fenrus.demon.nl/athlon.c

Here we go, a TBird 1.1G with KT133 (non-A), normally working with value
89 in reg 55, not exhibiting the bug under any setting.

with 89 (working, default):

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 20842 cycles per page
clear_page function '2.4 non MMX'        took 13737 cycles per page
clear_page function '2.4 MMX fallback'   took 14071 cycles per page
clear_page function '2.4 MMX version'    took 13269 cycles per page
clear_page function 'faster_clear_page'  took 5485 cycles per page
clear_page function 'even_faster_clear'  took 5611 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 20049 cycles per page
copy_page function '2.4 non MMX'         took 29783 cycles per page
copy_page function '2.4 MMX fallback'    took 29679 cycles per page
copy_page function '2.4 MMX version'     took 20173 cycles per page
copy_page function 'faster_copy'         took 12641 cycles per page
copy_page function 'even_faster'         took 12443 cycles per page

with 09 (working, set using "setpci -d 1106:0305 55=09"):

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 20763 cycles per page
clear_page function '2.4 non MMX'        took 13754 cycles per page
clear_page function '2.4 MMX fallback'   took 13771 cycles per page
clear_page function '2.4 MMX version'    took 13340 cycles per page
clear_page function 'faster_clear_page'  took 5578 cycles per page
clear_page function 'even_faster_clear'  took 5774 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 20415 cycles per page
copy_page function '2.4 non MMX'         took 29629 cycles per page
copy_page function '2.4 MMX fallback'    took 29509 cycles per page
copy_page function '2.4 MMX version'     took 20287 cycles per page
copy_page function 'faster_copy'         took 12626 cycles per page
copy_page function 'even_faster'         took 12587 cycles per page

So there is no noticeable difference. The values for 'even_faster' vary
between 10000 and 13000 between different runs with either setting of
register 55.

-- 
Vojtech Pavlik
SuSE Labs
