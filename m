Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbTAJS2Z>; Fri, 10 Jan 2003 13:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbTAJS1d>; Fri, 10 Jan 2003 13:27:33 -0500
Received: from [193.158.237.250] ([193.158.237.250]:42376 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265636AbTAJS1K>; Fri, 10 Jan 2003 13:27:10 -0500
Date: Fri, 10 Jan 2003 19:35:53 +0100
Message-Id: <200301101835.h0AIZrt04678@mail.intergenia.de>
To: Your.message.of"Thu, 09 Jan 2003 18:49:23 +0900."@mail.intergenia.de
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Prevent .gnu.linkonce.this_module section from being merged with other sections  [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.55-moo.orig/Makefile	2003-01-09 14:03:45.000000000 +0900
> +++ linux-2.5.55-moo/Makefile	2003-01-09 14:07:36.000000000 +0900
> @@ -163,7 +164,7 @@
>  MODFLAGS	= -DMODULE
>  CFLAGS_MODULE   = $(MODFLAGS)
>  AFLAGS_MODULE   = $(MODFLAGS)
> -LDFLAGS_MODULE  = -r
> +LDFLAGS_MODULE  = -r --unique=.gnu.linkonce.this_module

No!  Does this not work?

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.55/arch/v850/Makefile working-2.5.55-strlen/arch/v850/Makefile
--- linux-2.5.55/arch/v850/Makefile	2003-01-02 12:46:15.000000000 +1100
+++ working-2.5.55-strlen/arch/v850/Makefile	2003-01-10 19:32:09.000000000 +1100
@@ -24,7 +24,7 @@ CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uC
 
 LDFLAGS_BLOB := -b binary --oformat elf32-little
 OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
-
+LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module
 
 HEAD := $(arch_dir)/kernel/head.o $(arch_dir)/kernel/init_task.o
 core-y += $(arch_dir)/kernel/

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

