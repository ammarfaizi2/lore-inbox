Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759793AbWLDXQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759793AbWLDXQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759849AbWLDXQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:16:23 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:47871 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759830AbWLDXQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:16:22 -0500
Message-Id: <200612042312.kB4NCNiN024571@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/4] UML - Use get_random_bytes after random pool is seeded
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Dec 2006 18:12:23 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the UML network driver generates random MACs for its devices, it was
possible for a number of UMLs to get the same MACs because the ethernet 
initialization was done before the random pool was properly seeded.

This patch moves the initialization later so that it gets better randomness.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/daemon_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/daemon_kern.c	2006-11-24 14:29:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/daemon_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -98,4 +98,4 @@ static int register_daemon(void)
 	return 0;
 }
 
-__initcall(register_daemon);
+late_initcall(register_daemon);
Index: linux-2.6.18-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mcast_kern.c	2006-11-24 14:29:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mcast_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -127,4 +127,4 @@ static int register_mcast(void)
 	return 0;
 }
 
-__initcall(register_mcast);
+late_initcall(register_mcast);
Index: linux-2.6.18-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/pcap_kern.c	2006-11-24 14:29:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/pcap_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -109,4 +109,4 @@ static int register_pcap(void)
 	return 0;
 }
 
-__initcall(register_pcap);
+late_initcall(register_pcap);
Index: linux-2.6.18-mm/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slip_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/slip_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -95,4 +95,4 @@ static int register_slip(void)
 	return 0;
 }
 
-__initcall(register_slip);
+late_initcall(register_slip);
Index: linux-2.6.18-mm/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slirp_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/slirp_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -119,4 +119,4 @@ static int register_slirp(void)
 	return 0;
 }
 
-__initcall(register_slirp);
+late_initcall(register_slirp);
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/ethertap_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -105,4 +105,4 @@ static int register_ethertap(void)
 	return 0;
 }
 
-__initcall(register_ethertap);
+late_initcall(register_ethertap);
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/tuntap_kern.c	2006-11-27 18:55:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_kern.c	2006-12-04 12:08:52.000000000 -0500
@@ -90,4 +90,4 @@ static int register_tuntap(void)
 	return 0;
 }
 
-__initcall(register_tuntap);
+late_initcall(register_tuntap);

