Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbUKLAp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUKLAp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbUKLAmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:42:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:63973 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262451AbUKLAjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:39:44 -0500
Date: Thu, 11 Nov 2004 16:39:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org, gniibe@fsij.org
Subject: Re: [PATCH 2.6.10-rc1 1/2] [m32r] Update for m32r-g00ff
Message-Id: <20041111163927.1edcd1c9.akpm@osdl.org>
In-Reply-To: <20041111.221223.596521517.takata.hirokazu@renesas.com>
References: <20041111.221136.576022723.takata.hirokazu@renesas.com>
	<20041111.221223.596521517.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> wrote:
>
>  - Position-independent zImage support;
>    this aims at removing constraints of zImage(vmlinuz)'s location.

This generates a reject against Linus's current tree, in
arch/m32r/boot/compressed/Makefile

Please always generate diffs against current bitkeeper, or against the
latest diff from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots. 
2.6.10-rc1 is too old: we're currently showing a ten megabyte diff against
2.6.10-rc1.


I resolved the reject as below.  It might be wrong.

--- 25/arch/m32r/boot/compressed/Makefile~m32r-update-for-m32r-g00ff	2004-11-11 16:35:23.789252008 -0800
+++ 25-akpm/arch/m32r/boot/compressed/Makefile	2004-11-11 16:35:23.800250336 -0800
@@ -5,10 +5,10 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o \
-		   m32r-sio.o piggy.o vmlinux.lds
+		   piggy.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 
-OBJECTS = $(obj)/head.o $(obj)/misc.o $(obj)/m32r_sio.o
+OBJECTS = $(obj)/head.o $(obj)/misc.o
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
@@ -28,6 +28,8 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
+CFLAGS_misc.o += -fpic
+
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-m32r-linux -T
 OBJCOPYFLAGS += -R .empty_zero_page
 

