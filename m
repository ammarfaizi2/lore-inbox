Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUEJVx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUEJVx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUEJVx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:53:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261610AbUEJVx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:53:57 -0400
Date: Mon, 10 May 2004 17:53:45 -0400
From: Alan Cox <alan@redhat.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: Fix careless warning in io_apic for x86-64
Message-ID: <20040510215345.GA3719@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the warning

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/arch/x86_64/kernel/io_apic.c linux-2.6.6/arch/x86_64/kernel/io_apic.c
--- linux.vanilla-2.6.6/arch/x86_64/kernel/io_apic.c	2004-05-10 03:32:37.000000000 +0100
+++ linux-2.6.6/arch/x86_64/kernel/io_apic.c	2004-05-10 19:06:06.000000000 +0100
@@ -228,6 +228,8 @@
 void __init check_ioapic(void) 
 { 
 	int num,slot,func; 
+	u8 type;
+
 	if (ioapic_force) 
 		return; 
 
@@ -270,7 +272,7 @@
 				} 
 
 				/* No multi-function device? */
-				u8 type = read_pci_config_byte(num,slot,func,
+				type = read_pci_config_byte(num,slot,func,
 							       PCI_HEADER_TYPE);
 				if (!(type & 0x80))
 					break;
