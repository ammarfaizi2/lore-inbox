Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTAROb2>; Sat, 18 Jan 2003 09:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbTAROb2>; Sat, 18 Jan 2003 09:31:28 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:53897 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264838AbTAROb1>;
	Sat, 18 Jan 2003 09:31:27 -0500
Date: Sat, 18 Jan 2003 15:36:40 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301181436.PAA14723@harpo.it.uu.se>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003 18:11:01 -0600 (CST), Kai Germaschewski wrote:
>Okay, the details I received so far seem to indicate that the appended 
>patch will fix it, though I didn't get actual confirmation it does.
>
>If you experience crashes when loading modules (and have RH 8 binutils), 
>please give it a shot.
...
>diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>--- a/include/asm-generic/vmlinux.lds.h	Fri Jan 17 10:09:57 2003
>+++ b/include/asm-generic/vmlinux.lds.h	Fri Jan 17 10:09:57 2003
>@@ -13,18 +13,18 @@
> 	}								\
> 									\
> 	/* Kernel symbol table: Normal symbols */			\
>-	__start___ksymtab = .;						\
> 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
>+		__start___ksymtab = .;					\
> 		*(__ksymtab)						\
>+		__stop___ksymtab = .;					\
> 	}								\
>-	__stop___ksymtab = .;						\
> 									\
> 	/* Kernel symbol table: GPL-only symbols */			\
>-	__start___gpl_ksymtab = .;					\
> 	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
>+		__start___gpl_ksymtab = .;				\
> 		*(__gpl_ksymtab)					\
>+		__stop___gpl_ksymtab = .;				\
> 	}								\
>-	__stop___gpl_ksymtab = .;					\
> 									\
> 	/* Kernel symbol table: strings */				\
>         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
>

This patch fixed the module-loading problem for me. Thanks.

Note that the problem wasn't specific to RH8.0 binutils:
I've also seen it with binutils-2.10.91 from RH7.1.

/Mikael
