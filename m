Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTBFEHL>; Wed, 5 Feb 2003 23:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTBFEGD>; Wed, 5 Feb 2003 23:06:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56592 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265400AbTBFEC7>;
	Wed, 5 Feb 2003 23:02:59 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044903733@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044911216@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.12, 2003/02/06 10:14:04+11:00, randy.dunlap@verizon.net

[PATCH] PCI Hotplug: memory leaks in acpiphp_glue

Here's the memory leaks patch for acpiphp_glue.c.


diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Thu Feb  6 14:51:22 2003
+++ b/drivers/hotplug/acpiphp_glue.c	Thu Feb  6 14:51:22 2003
@@ -578,6 +578,7 @@
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->io_head) {
 			err("out of memory\n");
+			kfree(bridge);
 			return;
 		}
 		dbg("16bit I/O range: %04x-%04x\n",
@@ -592,6 +593,7 @@
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->io_head) {
 			err("out of memory\n");
+			kfree(bridge);
 			return;
 		}
 		dbg("32bit I/O range: %08x-%08x\n",
@@ -613,6 +615,7 @@
 	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
 	if (!bridge->mem_head) {
 		err("out of memory\n");
+		kfree(bridge);
 		return;
 	}
 	dbg("32bit Memory range: %08x-%08x\n",
@@ -632,6 +635,7 @@
 		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->p_mem_head) {
 			err("out of memory\n");
+			kfree(bridge);
 			return;
 		}
 		dbg("32bit Prefetchable memory range: %08x-%08x\n",
@@ -647,6 +651,7 @@
 		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
 		if (!bridge->p_mem_head) {
 			err("out of memory\n");
+			kfree(bridge);
 			return;
 		}
 		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x\n",

