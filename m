Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUGKXHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUGKXHm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 19:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUGKXHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 19:07:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:56021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266666AbUGKXH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 19:07:26 -0400
Date: Sun, 11 Jul 2004 16:00:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, matt_domsch@dell.com, akpm <akpm@osdl.org>
Subject: [PATCH] edd (Re: Linux 2.6.8-rc1)
Message-Id: <20040711160019.00c2d658.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Matt Domsch:
|   o EDD: store mbr_signature on first 16 int13 devices
|   o EDD: x86-64 build fix
| 

drivers/built-in.o: In function `edd_has_mbr_signature':
drivers/built-in.o(.text+0x13b84f): undefined reference to `edd'
drivers/built-in.o: In function `edd_has_edd_info':
drivers/built-in.o(.text+0x13b871): undefined reference to `edd'
drivers/built-in.o: In function `edd_device_register':
drivers/built-in.o(.text+0x13c7ab): undefined reference to `edd'
drivers/built-in.o(.text+0x13c7c3): undefined reference to `edd'
drivers/built-in.o: In function `edd_init':
drivers/built-in.o(.init.text+0xd395): undefined reference to `edd'
drivers/built-in.o(.init.text+0xd39c): more undefined references to `edd' follow
make: *** [.tmp_vmlinux1] Error 1


CONFIG_EDD=y on X86o


'edd' needs to be exported for drivers/firmware/edd.c

diffstat:=
 arch/i386/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./arch/i386/kernel/setup.c~edd_reference ./arch/i386/kernel/setup.c
--- ./arch/i386/kernel/setup.c~edd_reference	2004-07-11 15:47:27.000000000 -0700
+++ ./arch/i386/kernel/setup.c	2004-07-11 15:42:05.000000000 -0700
@@ -628,10 +628,10 @@ static int __init copy_e820_map(struct e
 }
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+
 struct edd edd;
-#ifdef CONFIG_EDD_MODULE
 EXPORT_SYMBOL(edd);
-#endif
+
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from boot_params into a safe place.
