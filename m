Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263023AbTCXOQZ>; Mon, 24 Mar 2003 09:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264209AbTCXOQZ>; Mon, 24 Mar 2003 09:16:25 -0500
Received: from mail.bytecamp.net ([195.127.199.19]:32266 "EHLO
	mail.bytecamp.net") by vger.kernel.org with ESMTP
	id <S263023AbTCXOQX>; Mon, 24 Mar 2003 09:16:23 -0500
Subject: [PATCH-2.5] Missing include, again
From: Christian Neumair <chris@gnome-de.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048517435.9008.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 24 Mar 2003 15:50:35 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!
The included patch fixes the following error when compiling current 2.5
kernel:

-- snip --
arch/i386/pci/numa.c: In function `__pci_conf1_mq_read':
arch/i386/pci/numa.c:20: `MAX_MP_BUSSES' undeclared (first use in this
function)
arch/i386/pci/numa.c:20: (Each undeclared identifier is reported only
once
arch/i386/pci/numa.c:20: for each function it appears in.)
arch/i386/pci/numa.c:25: `mp_bus_id_to_local' undeclared (first use in
this func
tion)
arch/i386/pci/numa.c:25: `mp_bus_id_to_node' undeclared (first use in
this funct
ion)
arch/i386/pci/numa.c: In function `__pci_conf1_mq_write':
arch/i386/pci/numa.c:48: `MAX_MP_BUSSES' undeclared (first use in this
function)
arch/i386/pci/numa.c:53: `mp_bus_id_to_local' undeclared (first use in
this func
tion)
arch/i386/pci/numa.c:53: `mp_bus_id_to_node' undeclared (first use in
this funct
ion)
arch/i386/pci/numa.c: In function `pci_fixup_i450nx':
arch/i386/pci/numa.c:99: `mp_bus_id_to_node' undeclared (first use in
this funct
ion)
arch/i386/pci/numa.c:109: `quad_local_to_mp_bus_id' undeclared (first
use in thi
s function)
arch/i386/pci/numa.c: In function `pci_numa_init':
arch/i386/pci/numa.c:133: `quad_local_to_mp_bus_id' undeclared (first
use in thi
s function)
make[1]: *** [arch/i386/pci/numa.o] Fehler 1
make: *** [arch/i386/pci] Fehler 2
[PATCH] Tiny compile include fix
-- snap --

regs,
 Chris


Index: arch/i386/pci/numa.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/pci/numa.c,v
retrieving revision 1.8
diff -u -r1.8 numa.c
--- arch/i386/pci/numa.c	28 Feb 2003 23:09:01 -0000	1.8
+++ arch/i386/pci/numa.c	24 Mar 2003 13:38:54 -0000
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <asm/mpspec.h>
 #include "pci.h"
 
 #define BUS2QUAD(global) (mp_bus_id_to_node[global])



