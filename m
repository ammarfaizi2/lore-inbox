Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265482AbSJXSsa>; Thu, 24 Oct 2002 14:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265576AbSJXSsa>; Thu, 24 Oct 2002 14:48:30 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8075 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265482AbSJXSs3>;
	Thu, 24 Oct 2002 14:48:29 -0400
Date: Thu, 24 Oct 2002 19:56:37 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024185637.GB10584@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com> <20021024184328.GA5667@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024184328.GA5667@himi.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 04:43:28AM +1000, Simon Fowler wrote:
 > <deletia>
 > 
 > copy_page() tests 
 > copy_page function 'warm up run'         took 12855 cycles per page
 > copy_page function '2.4 non MMX'         took 17267 cycles per page
 > copy_page function '2.4 MMX fallback'    took 14930 cycles per page
 > copy_page function '2.4 MMX version'     took 10642 cycles per page
 > copy_page function 'faster_copy'         took 10591 cycles per page
 > copy_page function 'even_faster'         took 13035 cycles per page
 > copy_page function 'no_prefetch'         took 11657 cycles per page
 > Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
 > 
 > copy_page() tests 
 > copy_page function 'warm up run'         took 12871 cycles per page
 > copy_page function '2.4 non MMX'         took 18482 cycles per page
 > copy_page function '2.4 MMX fallback'    took 15013 cycles per page
 > copy_page function '2.4 MMX version'     took 10679 cycles per page
 > copy_page function 'faster_copy'         took 12268 cycles per page
 > copy_page function 'even_faster'         took 10789 cycles per page
 > copy_page function 'no_prefetch'         took 11691 cycles per page
 > Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 
 > 
 > copy_page() tests 
 > copy_page function 'warm up run'         took 13110 cycles per page
 > copy_page function '2.4 non MMX'         took 14958 cycles per page
 > copy_page function '2.4 MMX fallback'    took 14952 cycles per page
 > copy_page function '2.4 MMX version'     took 12864 cycles per page
 > copy_page function 'faster_copy'         took 10581 cycles per page
 > copy_page function 'even_faster'         took 10629 cycles per page
 > copy_page function 'no_prefetch'         took 11607 cycles per page

Wow. The 612 really sucked badly here. I think this is the only
time I've seen 'even_faster' lose.  A few people (myself included)
have in the past talked about making the memory copy routines
do a boot time benchmark somewhat like the RAID code does to deduce
the best.  Seeing results like this makes me really believe this is
the way forward.

With something like that inplace, we could then have seperate
implementations for each processor revision if needbe without
pessimising for earlier revisions.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
