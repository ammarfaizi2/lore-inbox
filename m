Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTAJJBb>; Fri, 10 Jan 2003 04:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAJJBa>; Fri, 10 Jan 2003 04:01:30 -0500
Received: from dp.samba.org ([66.70.73.150]:40094 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264681AbTAJJB2>;
	Fri, 10 Jan 2003 04:01:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent .gnu.linkonce.this_module section from being merged with other sections 
In-reply-to: Your message of "Thu, 09 Jan 2003 18:49:23 +0900."
             <20030109094923.63723374A@mcspd15.ucom.lsi.nec.co.jp> 
Date: Fri, 10 Jan 2003 19:32:37 +1100
Message-Id: <20030110091012.0E15E2C2AF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030109094923.63723374A@mcspd15.ucom.lsi.nec.co.jp> you write:
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
