Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265576AbSJXS4B>; Thu, 24 Oct 2002 14:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265597AbSJXS4B>; Thu, 24 Oct 2002 14:56:01 -0400
Received: from trillium-hollow.org ([209.180.166.89]:31154 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S265576AbSJXS4A>; Thu, 24 Oct 2002 14:56:00 -0400
To: Matthias Welk <matthias.welk@fokus.gmd.de>
cc: Manfred Spraul <manfred@colorfullife.com>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation 
In-Reply-To: Your message of "Thu, 24 Oct 2002 19:48:38 +0200."
             <200210241948.38490.matthias.welk@fokus.fraunhofer.de> 
Date: Thu, 24 Oct 2002 12:01:54 -0700
From: erich@uruk.org
Message-Id: <E184nEw-00071m-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthias Welk <matthias.welk@fokus.gmd.de> wrote:

> Running on an Athlon XP2000+, ASUS A7V333, 768MB DDR2100:

...[snip]...

> 1019 [maw] (buruk) /tmp/athlon # athlon_test
> Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
> 
> copy_page() tests
> copy_page function 'warm up run'         took 18081 cycles per page
> copy_page function '2.4 non MMX'         took 19487 cycles per page
> copy_page function '2.4 MMX fallback'    took 19403 cycles per page
> copy_page function '2.4 MMX version'     took 18086 cycles per page
> copy_page function 'faster_copy'         took 11372 cycles per page
> copy_page function 'even_faster'         took 11183 cycles per page
> copy_page function 'no_prefetch'         took 7815 cycles per page
> 1020 [maw] (buruk) /tmp/athlon # athlon_test


Whoa!  Hmm.

If I'm reading this right, with a processor speed of 1.666 GHz,
you're getting:

    (4096 bytes / 7815 clocks) * 1.666 GHz  =  873 MB/sec

The perfect peak performance of your setup, if the cache implements
standard write-allocate behavior (the target cache line is read before it
is written because the write logic doesn't know you're going to overwrite
the whole line in cases like this), should be:

    MIN( Memory speed / FSB speed ) / 3  =  700 MB/sec


So what gives?  Did I misinterpret the output of your program?
Is the test flawed?

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
