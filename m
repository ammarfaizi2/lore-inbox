Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292583AbSB0XdB>; Wed, 27 Feb 2002 18:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293057AbSB0Xb1>; Wed, 27 Feb 2002 18:31:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43913 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293055AbSB0XbE>;
	Wed, 27 Feb 2002 18:31:04 -0500
Date: Wed, 27 Feb 2002 15:32:23 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <31490000.1014852743@w-hlinder.des>
In-Reply-To: <Pine.GSO.4.21.0202271645560.12074-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202271645560.12074-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, February 27, 2002 16:48:07 -0500 Alexander Viro <viro@math.psu.edu> wrote:

> 
> ed mm/vmscan.c <<EOF
> /shrink_icache_memory/s/priority/1/
> w
> q
> EOF
> 
> and repeat the tests.  Unreferenced inodes == useless inodes.  Aging is
> already taken care of in dcache and anything that had fallen through
> is fair game.
> 

FYI:

The patch does this:

*** vmscan.c.orig	Wed Feb 27 14:09:49 2002
--- vmscan.c	Wed Feb 27 14:10:16 2002
***************
*** 578,584 ****
  		return 0;
  
  	shrink_dcache_memory(priority, gfp_mask);
! 	shrink_icache_memory(priority, gfp_mask);
  #ifdef CONFIG_QUOTA
  	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
  #endif
--- 578,584 ----
  		return 0;
  
  	shrink_dcache_memory(priority, gfp_mask);
! 	shrink_icache_memory(1, gfp_mask);
  #ifdef CONFIG_QUOTA
  	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
  #endif

