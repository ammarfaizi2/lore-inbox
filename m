Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSIZVaQ>; Thu, 26 Sep 2002 17:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSIZVaQ>; Thu, 26 Sep 2002 17:30:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47242 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261522AbSIZVaN>;
	Thu, 26 Sep 2002 17:30:13 -0400
Date: Thu, 26 Sep 2002 14:29:10 -0700 (PDT)
Message-Id: <20020926.142910.124086325.davem@redhat.com>
To: zaitcev@redhat.com
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209262127.g8QLROv26197@devserv.devel.redhat.com>
References: <mailman.1033072381.13688.linux-kernel2news@redhat.com>
	<200209262127.g8QLROv26197@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Thu, 26 Sep 2002 17:27:24 -0400

   > Since 2.4.20-pre2 or 3, sunrpc.o has had this problem on sparc32:
   > 
   > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre8/kernel/net/sunrpc/sunrpc.o
   > depmod:         ___illegal_use_of_BTFIXUP_SETHI_in_module
   > depmod:         ___f_set_pte
   > depmod:         fix_kmap_begin
   > depmod:         ___f_flush_cache_all
   > depmod:         ___f_pte_clear
   > depmod:         ___f_mk_pte
   > depmod:         ___f_flush_tlb_all
   
   Try these two things:
   
No Peter, it really does use kmap_atomic stuff from modules, and this
precludes providing those routines inline in highmem.h, they must
live statically in main kernel image so that flush/pte calls can
be properly BTFIXUP'd.

See my other email.
