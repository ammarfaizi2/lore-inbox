Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTHQLeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 07:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHQLeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 07:34:08 -0400
Received: from aneto.able.es ([212.97.163.22]:14015 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265531AbTHQLeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 07:34:06 -0400
Date: Sun, 17 Aug 2003 13:34:04 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: no_idt update for 2.4
Message-ID: <20030817113404.GA22932@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

As I tend to collect things that make gcc-3.3 happy witgh 2.4, here is
the backport of the no_idt change to 2.4.22-rc2. On time for final ?

TIA

--- linux-2.4.22-rc2/arch/i386/kernel/process.c.orig	2003-08-17
12:58:47.000000000 +0200
+++ linux-2.4.22-rc2/arch/i386/kernel/process.c	2003-08-17
13:01:41.000000000 +0200
@@ -151,7 +151,6 @@
 
 __setup("idle=", idle_setup);
 
-static long no_idt[2];
 static int reboot_mode;
 int reboot_thru_bios;
 
@@ -222,7 +221,8 @@
 	unsigned long long * base __attribute__ ((packed));
 }
 real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, real_mode_gdt_entries },
-real_mode_idt = { 0x3ff, 0 };
+real_mode_idt = { 0x3ff, 0 },
+no_idt = { 0, 0 };
 
 /* This is 16-bit protected mode code to disable paging and the cache,
    switch to real mode and jump to the BIOS reset code.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
