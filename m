Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTFSDzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTFSDzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:55:13 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:51076 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265367AbTFSDxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:53:53 -0400
Date: Wed, 18 Jun 2003 23:44:46 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234446.GD333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618234418.GC333@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1415  -> 1.1416 
#	drivers/pnp/resource.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1416
# [PNP] /drivers/pnp/resource.c check_region warning fix
# 
# This patch resolves the compiler warning caused by the depreciated check_region
# function.  It may not be the best solution but check_region really is what is
# needed here because we never actually have to call "request_region".  If prefered,
# I could alternatively request and release but doing so would be less efficient.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Wed Jun 18 23:02:14 2003
+++ b/drivers/pnp/resource.c	Wed Jun 18 23:02:14 2003
@@ -255,7 +255,7 @@
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
 	if(!dev->active) {
-		if (check_region(*port, length(port,end)))
+		if (__check_region(&ioport_resource, *port, length(port,end)))
 			return 0;
 	}
 
@@ -309,7 +309,7 @@
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
 	if(!dev->active) {
-		if (__check_region(&iomem_resource, *addr, length(addr,end)))
+		if (check_mem_region(*addr, length(addr,end)))
 			return 0;
 	}
 
