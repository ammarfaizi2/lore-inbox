Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSIZVWP>; Thu, 26 Sep 2002 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbSIZVWP>; Thu, 26 Sep 2002 17:22:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61149 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261507AbSIZVWO>; Thu, 26 Sep 2002 17:22:14 -0400
Date: Thu, 26 Sep 2002 17:27:24 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200209262127.g8QLROv26197@devserv.devel.redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
In-Reply-To: <mailman.1033072381.13688.linux-kernel2news@redhat.com>
References: <mailman.1033072381.13688.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

1. diff -urN -X dontdiff linux-2.4.19 linux-2.4.20-pre2 > x.diff
   vi x.diff
I've got Tigran's dontdiff updated at
 http://people.redhat.com/zaitcev/linux/dontdiff.fix

2. make vmlinux modules > build.out 2>&1 </dev/null
   grep -i warning build.out

-- Pete
