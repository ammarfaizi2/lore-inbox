Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289229AbSA1QKm>; Mon, 28 Jan 2002 11:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSA1QKd>; Mon, 28 Jan 2002 11:10:33 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:27273 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S289228AbSA1QKS>; Mon, 28 Jan 2002 11:10:18 -0500
Date: Mon, 28 Jan 2002 08:10:17 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com
Subject: [patch] dqcache receives uneven shrink_caches priority
Message-ID: <20020128081017.B6578@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the vmscan shrink_caches() function applies an uneven
priority for the call to shrink_dqcache_memory().  Instead of passing
the 'priority' argument as with the dcache and icache, dqcache always
receives the lowest (default) priority.  This seems unjustified...

-josh

diff -cr mm.2.5.2/vmscan.c mm/vmscan.c
*** mm.2.5.2/vmscan.c	Mon Jan 28 18:56:38 2002
--- mm/vmscan.c	Mon Jan 28 18:56:50 2002
***************
*** 578,584 ****
  	shrink_dcache_memory(priority, gfp_mask);
  	shrink_icache_memory(priority, gfp_mask);
  #ifdef CONFIG_QUOTA
! 	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
  #endif
  
  	return nr_pages;
--- 578,584 ----
  	shrink_dcache_memory(priority, gfp_mask);
  	shrink_icache_memory(priority, gfp_mask);
  #ifdef CONFIG_QUOTA
! 	shrink_dqcache_memory(priority, gfp_mask);
  #endif
  
  	return nr_pages;


-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
