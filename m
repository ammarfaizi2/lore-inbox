Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274243AbRISWyT>; Wed, 19 Sep 2001 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274244AbRISWyJ>; Wed, 19 Sep 2001 18:54:09 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:21510 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S274243AbRISWx6>;
	Wed, 19 Sep 2001 18:53:58 -0400
Date: Wed, 19 Sep 2001 19:55:04 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.LNX.4.30.0109191509480.29421-100000@anime.net>
Message-ID: <Pine.GSO.4.21.0109191946550.1374-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Dan Hollis wrote:

> We definitely need more data points too. So far we dont have any athlon.c
> data for kt133a with the bit on and off, only kt133.

My system is a kt133a, that show the bug. I have run a hundred tests,
first in a Athlon optimized kernel with the patch (55.7=0) then with a non
optimized kernel (55.7=1).

Here are some typical results:

K7 optimized:
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 19862 cycles per page
clear_page function '2.4 non MMX'        took 12296 cycles per page
clear_page function '2.4 MMX fallback'   took 12068 cycles per page
clear_page function '2.4 MMX version'    took 14936 cycles per page
clear_page function 'faster_clear_page'  took 4393 cycles per page
clear_page function 'even_faster_clear'  took 4362 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 22513 cycles per page
copy_page function '2.4 non MMX'         took 26280 cycles per page
copy_page function '2.4 MMX fallback'    took 26275 cycles per page
copy_page function '2.4 MMX version'     took 22537 cycles per page
copy_page function 'faster_copy'         took 10983 cycles per page
copy_page function 'even_faster'         took 11122 cycles per page

and here without:
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
clear_page() tests 
clear_page function 'warm up run'        took 12871 cycles per page
clear_page function '2.4 non MMX'        took 12325 cycles per page
clear_page function '2.4 MMX fallback'   took 12586 cycles per page
clear_page function '2.4 MMX version'    took 12021 cycles per page
clear_page function 'faster_clear_page'  took 4401 cycles per page
clear_page function 'even_faster_clear'  took 4370 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 19568 cycles per page
copy_page function '2.4 non MMX'         took 25353 cycles per page
copy_page function '2.4 MMX fallback'    took 25316 cycles per page
copy_page function '2.4 MMX version'     took 19541 cycles per page
copy_page function 'faster_copy'         took 11052 cycles per page
copy_page function 'even_faster'         took 10785 cycles per page

I thought that when I run the program in the non-optimized kernel with
55.7=1, the program was supposed to crash the system, but it doesn't seem
to do. Isn't the program the K7 optimized fast_copy_page()? Weird.

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

