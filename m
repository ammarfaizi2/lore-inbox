Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTBCVrv>; Mon, 3 Feb 2003 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTBCVrv>; Mon, 3 Feb 2003 16:47:51 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:24814 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S266064AbTBCVrt>; Mon, 3 Feb 2003 16:47:49 -0500
Date: Mon, 3 Feb 2003 13:57:01 -0800
From: Chris Wright <chris@wirex.com>
To: b_adlakha@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] kernel 2.5.59
Message-ID: <20030203135701.B26686@figure1.int.wirex.com>
Mail-Followup-To: b_adlakha@softhome.net, linux-kernel@vger.kernel.org
References: <courier.3E3EDB16.00007614@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <courier.3E3EDB16.00007614@softhome.net>; from b_adlakha@softhome.net on Mon, Feb 03, 2003 at 02:11:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* b_adlakha@softhome.net (b_adlakha@softhome.net) wrote:
> I get this each time I boot : 
> 
> Feb  3 02:34:38 localhost kernel: EIP is at __find_symbol+0x3e/0x84

This is a known problem.  Try the patch below which has been floating
about for a while.

thanks,
-chris

===== vmlinux.lds.h 1.4 vs 1.5 =====
--- 1.4/include/asm-generic/vmlinux.lds.h	Thu Jan 16 17:02:47 2003
+++ 1.5/include/asm-generic/vmlinux.lds.h	Fri Jan 17 17:26:31 2003
@@ -13,18 +13,18 @@
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-	__start___ksymtab = .;						\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
+		__start___ksymtab = .;					\
 		*(__ksymtab)						\
+		__stop___ksymtab = .;					\
 	}								\
-	__stop___ksymtab = .;						\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
-	__start___gpl_ksymtab = .;					\
 	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
+		__start___gpl_ksymtab = .;				\
 		*(__gpl_ksymtab)					\
+		__stop___gpl_ksymtab = .;				\
 	}								\
-	__stop___gpl_ksymtab = .;					\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
