Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319546AbSIHAEl>; Sat, 7 Sep 2002 20:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319547AbSIHAEl>; Sat, 7 Sep 2002 20:04:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319546AbSIHAEl>;
	Sat, 7 Sep 2002 20:04:41 -0400
Date: Sat, 07 Sep 2002 17:01:51 -0700 (PDT)
Message-Id: <20020907.170151.84915731.davem@redhat.com>
To: phillips@arcor.de
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17nUee-0006Lc-00@starship>
References: <00d301c25556$4290f5e0$9e10a8c0@IMRANPC>
	<E17nUee-0006Lc-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Sat, 7 Sep 2002 03:44:53 +0200
   
   It looks good to me.  Note that somebody has added some new voodoo in 2.5
   so that page table pages can be in highmem, with the result that the above
   code won't work in 2.5, whether or not highmem is configured.

The example given won't work for kernel text/data addresses on a few
platforms (sparc64 is one).  And in fact on MIPS the KSEG0 pages lack
any page tables.

There are only three things one can portably obtain a physical address
of:

1) A user address, for a known MM

2) a kmalloc/get_free_page kernel page

3) A vmalloc page

For anything else you're in non-portablt land, including and
in partiular:

1) kernel stack addresses
2) addresses within the main kernel image text/data/bss
