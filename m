Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265617AbSJXUDO>; Thu, 24 Oct 2002 16:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265635AbSJXUDO>; Thu, 24 Oct 2002 16:03:14 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:64225 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S265617AbSJXUDM>;
	Thu, 24 Oct 2002 16:03:12 -0400
Message-ID: <3DB85385.6030302@wmich.edu>
Date: Thu, 24 Oct 2002 16:09:41 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
References: <3DB82ABF.8030706@colorfullife.com> <200210242048.36859.earny@net4u.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I seem to be seeing compiler optimizations come into play with the 
numbers and not any mention of them that i've seen has been talked 
about. That could be causing any discrepencies with predicted values. So 
not only would we have to look at algorithms, but also the compilers and 
what optimizations we plan on using them with.  Some do better on 
certain compilers+flags than others. It's a mixmatch that seems to only 
get complicated the more realistic you make it.



athlon tbird 1133.402Mhz, 133Mhz fsb, 512MB + 128MB pc133sdram No hd

Here are 3 averages of 3 runs each

gcc (GCC) 3.2.1 20021020 (Debian prerelease)

flags : -O3 -march=athlon-tbird -mcpu=athlon-tbird -falign-loops=4

copy_page function 'warm up run'         took 17577 cycles per page
copy_page function '2.4 non MMX'         took 23659 cycles per page
copy_page function '2.4 MMX fallback'    took 23894 cycles per page
copy_page function '2.4 MMX version'     took 17549 cycles per page
copy_page function 'faster_copy'         took 10452 cycles per page
copy_page function 'even_faster'         took 10159 cycles per page
copy_page function 'no_prefetch'         took 9508 cycles per page

flags : -O0 -march=i686 -mcpu=i686

copy_page function 'warm up run'         took 18377 cycles per page
copy_page function '2.4 non MMX'         took 23688 cycles per page
copy_page function '2.4 MMX fallback'    took 23671 cycles per page
copy_page function '2.4 MMX version'     took 18407 cycles per page
copy_page function 'faster_copy'         took 10091 cycles per page
copy_page function 'even_faster'         took 10283 cycles per page
copy_page function 'no_prefetch'         took 9907 cycles per page


gcc 2.95.4

flags : -O0 -march=i686 -mcpu=i686

copy_page function 'warm up run'         took 18343 cycles per page
copy_page function '2.4 non MMX'         took 23655 cycles per page
copy_page function '2.4 MMX fallback'    took 23646 cycles per page
copy_page function '2.4 MMX version'     took 18324 cycles per page
copy_page function 'faster_copy'         took 10146 cycles per page
copy_page function 'even_faster'         took 10438 cycles per page
copy_page function 'no_prefetch'         took 9913 cycles per page


----------------------------------------------------------------------


avg difference due to compiler
copy_page function 'warm up run'	 took +-533 cycles per page
copy_page function '2.4 non MMX'         took +-22 cycles per page
copy_page function '2.4 MMX fallback'    took +-496 cycles per page
copy_page function '2.4 MMX version'     took +-572 cycles per page
copy_page function 'faster_copy'         took +-241 cycles per page
copy_page function 'even_faster'         took +-186 cycles per page

Other options may give even greater differences but it's difficult to 
try them all so I thought this should give an example of proof. The 
options did not do better than all of the runs of another option but 
instead did better and worse depending on the test.

copy_page function 'warm up run'	test1
copy_page function '2.4 non MMX'        test3
copy_page function '2.4 MMX fallback'   test3
copy_page function '2.4 MMX version'    test1
copy_page function 'faster_copy'        test2
copy_page function 'even_faster'        test1
copy_page function 'no_prefetch'        test1


bandwidth test1 = 488.3MB/sec   (not ddr like other setups)
bandwidth test2 = 468.6MB/sec
bandwidth test3 = 468.3MB/sec



