Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274170AbRISUbZ>; Wed, 19 Sep 2001 16:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274168AbRISUbQ>; Wed, 19 Sep 2001 16:31:16 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:50189 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S274169AbRISUbL> convert rfc822-to-8bit; Wed, 19 Sep 2001 16:31:11 -0400
Message-ID: <200109192236080281.11BCB708@scispor.dolphinics.no>
In-Reply-To: <3BA8EA04.E55BAA02@redhat.com>
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com>
 <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
 <3BA8EA04.E55BAA02@redhat.com>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Wed, 19 Sep 2001 22:36:08 +0200
From: "Simen Thoresen" <simen-tt@online.no>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Dan Hollis wrote:
>> 
>> On Wed, 19 Sep 2001, Linus Torvalds wrote:
>> > It is _probably_ an undocumented performance thing, and clearing that
>> > bit may slow something down. But it might also change some behaviour,
>> > and knowing _what_ the behaviour is might be very useful for figuring
>> > out what it is that triggers the problem.
>> 
>> AFAIK noone has even tested it yet to see what it does to performance! Eg
>> it might slow down memory access so that athlon-optimized memcopy is now
>> slower than non-athlon-optimized memcopy. And if it turns out to be the
>> case, we might as well just use the non-athlon-optimized memcopy instead
>> of twiddling undocumented northbridge bits...
>
>Ok but that part is simple:
>
>run
>
>http://www.fenrus.demon.nl/athlon.c
>

On my non-buggy(*) KT133A board with the 55th register set to 09 I get these results;

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 21729 cycles per page
clear_page function '2.4 non MMX'        took 13341 cycles per page
clear_page function '2.4 MMX fallback'   took 13346 cycles per page
clear_page function '2.4 MMX version'    took 15574 cycles per page
clear_page function 'faster_clear_page'  took 4965 cycles per page
clear_page function 'even_faster_clear'  took 4884 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 21294 cycles per page
copy_page function '2.4 non MMX'         took 38093 cycles per page
copy_page function '2.4 MMX fallback'    took 38270 cycles per page
copy_page function '2.4 MMX version'     took 21380 cycles per page
copy_page function 'faster_copy'         took 10775 cycles per page
copy_page function 'even_faster'         took 11262 cycles per page

Setting the register to 00
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 21719 cycles per page
clear_page function '2.4 non MMX'        took 13392 cycles per page
clear_page function '2.4 MMX fallback'   took 13354 cycles per page
clear_page function '2.4 MMX version'    took 15615 cycles per page
clear_page function 'faster_clear_page'  took 4963 cycles per page
clear_page function 'even_faster_clear'  took 4886 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 21033 cycles per page
copy_page function '2.4 non MMX'         took 37879 cycles per page
copy_page function '2.4 MMX fallback'    took 37938 cycles per page
copy_page function '2.4 MMX version'     took 21124 cycles per page
copy_page function 'faster_copy'         took 10717 cycles per page
copy_page function 'even_faster'         took 11130 cycles per page

In my view these are pretty similar.

(*) - Yes, I did report a buggy KT133A Epox 8KTA/3 board, but the board and processor croaked, and my vendor replaced them with an Epox 8KTA/3 Pro board, and I've had no problems with it so far.

Yours,
-Simen
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


