Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTA3THm>; Thu, 30 Jan 2003 14:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTA3THm>; Thu, 30 Jan 2003 14:07:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32781 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267608AbTA3THl>;
	Thu, 30 Jan 2003 14:07:41 -0500
Date: Thu, 30 Jan 2003 20:16:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 __find_symbol oops
Message-ID: <20030130191600.GA960@mars.ravnborg.org>
Mail-Followup-To: Gianni Tedesco <gianni@ecsc.co.uk>,
	linux-kernel@vger.kernel.org
References: <1043938780.722.3.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043938780.722.3.camel@lemsip>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 02:59:40PM +0000, Gianni Tedesco wrote:
> Reproduce by loading a module (AFAICS).

Bug in asm-generic/vmlinux.lds.h
Apply this patch:

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
