Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbRFBRjG>; Sat, 2 Jun 2001 13:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262640AbRFBRiz>; Sat, 2 Jun 2001 13:38:55 -0400
Received: from ch-12-44-140-126.lcisp.com ([12.44.140.126]:4876 "EHLO
	debian-home") by vger.kernel.org with ESMTP id <S262639AbRFBRim>;
	Sat, 2 Jun 2001 13:38:42 -0400
To: linux-kernel@vger.kernel.org
Posted-To: fa.linux.kernel
Subject: Re: Athlon fast_copy_page revisited
In-Reply-To: <fa.f5i683v.igqsp3@ifi.uio.no>
Reply-To: gbsadler1@lcisp.com
Message-Id: <E156FM7-0001vm-00@debian-home>
From: Gordon Sadler <gbsadler1@lcisp.com>
Date: Sat, 02 Jun 2001 12:38:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This message has also been posted.]
On Wed, 30 May 2001 18:09:35 GMT, Jimmie Mayfield
<mayfield+kernel@sackheads.org> wrote:
<SNIP explanation> 
> Arjan's original code is at: http://www.fenrus.demon.nl/athlon.c
> My modifications are at: http://sackheads.org/~mayfield/jrm_athlon.c
> 
> Example test runs:
> 
> copy_page() tests 
> copy_page function 'warm up run'         took 21350 cycles per page
> copy_page function '2.4 non MMX'         took 27706 cycles per page
> copy_page function '2.4 MMX fallback'    took 28600 cycles per page
> copy_page function '2.4 MMX version'     took 21370 cycles per page
> copy_page function 'faster_copy'         took 13119 cycles per page
> copy_page function 'even_faster'         took 14767 cycles per page
> copy_page function 'jrm_copy_page_8nop'  took 12774 cycles per page
> copy_page function 'jrm_copy_page_10nop'         took 12746 cycles per page
> copy_page function 'jrm_copy_page_12nop'         took 12740 cycles per page
> 
> copy_page() tests 
> copy_page function 'warm up run'         took 22499 cycles per page
> copy_page function '2.4 non MMX'         took 27769 cycles per page
> copy_page function '2.4 MMX fallback'    took 27696 cycles per page
> copy_page function '2.4 MMX version'     took 22666 cycles per page
> copy_page function 'faster_copy'         took 13058 cycles per page
> copy_page function 'even_faster'         took 13169 cycles per page
> copy_page function 'jrm_copy_page_8nop'  took 12691 cycles per page
> copy_page function 'jrm_copy_page_10nop'         took 12750 cycles per page
> copy_page function 'jrm_copy_page_12nop'         took 14786 cycles per page
> 
> The values obviously fluctuate depending on system activity but the jrm_*
> routines were faster in 13 out of 15 trials.
> 
I have a Duron 800 socket A on an Epox 8KTA3.
Has anyone noticed fluctuations with these tests.. such as
jrm_athlon1:
...
copy_page function 'faster_copy'         took 9869 cycles per page
copy_page function 'even_faster'         took 9822 cycles per page
...
jrm_athlon2:
...
copy_page function 'faster_copy'         took 9939 cycles per page
copy_page function 'even_faster'         took 17728 cycles per page
...
jrm_athlon3:
...
copy_page function 'faster_copy'         took 17711 cycles per page
copy_page function 'even_faster'         took 9843 cycles per page
...

I see these with gcc 2.95.4(Debian unstable) and a local build of
gcc-3.0 from CVS last night.

Almost as though some stall and/or caching is corrupting the results.


-- 
Gordon Sadler

