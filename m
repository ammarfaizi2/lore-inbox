Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbSIVJyi>; Sun, 22 Sep 2002 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSIVJyh>; Sun, 22 Sep 2002 05:54:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:35986 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262205AbSIVJyh>;
	Sun, 22 Sep 2002 05:54:37 -0400
Date: Sun, 22 Sep 2002 11:59:45 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209220959.LAA09702@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix UP_APIC linkage problem in 2.5.3[78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that the local APIC code references stuff in
mpparse, but 2.5.37 changed arch/i386/kernel/Makefile to only
compile mpparse for SMP.

This patch works around this by enforcing CONFIG_X86_MPPARSE
for all LOCAL_APIC-enabled configs.

/Mikael

--- linux-2.5.38/arch/i386/config.in.~1~	Sat Sep 21 18:15:16 2002
+++ linux-2.5.38/arch/i386/config.in	Sun Sep 22 11:13:49 2002
@@ -260,7 +260,6 @@
    if [ "$CONFIG_SMP" = "y" ]; then
       define_bool CONFIG_X86_IO_APIC y
       define_bool CONFIG_X86_LOCAL_APIC y
-      define_bool CONFIG_X86_MPPARSE y
    fi
    bool 'PCI support' CONFIG_PCI
    if [ "$CONFIG_PCI" = "y" ]; then
@@ -441,6 +440,7 @@
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
    define_bool CONFIG_X86_EXTRA_IRQS y
    define_bool CONFIG_X86_FIND_SMP_CONFIG y
+   define_bool CONFIG_X86_MPPARSE y
 fi
 
 endmenu
