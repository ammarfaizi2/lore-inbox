Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSIZVLD>; Thu, 26 Sep 2002 17:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSIZVLD>; Thu, 26 Sep 2002 17:11:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32138 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261524AbSIZVLA>;
	Thu, 26 Sep 2002 17:11:00 -0400
Date: Thu, 26 Sep 2002 14:09:59 -0700 (PDT)
Message-Id: <20020926.140959.110909944.davem@redhat.com>
To: szepe@pinerecords.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020926202525.GO19015@louise.pinerecords.com>
References: <20020926202525.GO19015@louise.pinerecords.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Thu, 26 Sep 2002 22:25:25 +0200

   Since 2.4.20-pre2 or 3, sunrpc.o has had this problem on sparc32:
   
   depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre8/kernel/net/sunrpc/sunrpc.o
   depmod:         ___illegal_use_of_BTFIXUP_SETHI_in_module
   depmod:         ___f_set_pte
   depmod:         fix_kmap_begin
   depmod:         ___f_flush_cache_all
   depmod:         ___f_pte_clear
   depmod:         ___f_mk_pte
   depmod:         ___f_flush_tlb_all
   
   I'd like to fix the breakage but have no idea where to start
   looking.  Any hints will be thoroughly appreciated.

Move all the kmap atomic routines from include/asm-sparc/highmem.h
into arch/sparc/mm/highmem.c, export them from ksyms in
arch/sparc/kernel/sparc_ksyms.c when CONFIG_HIGHMEM is defined.
