Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbTFSD47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTFSDzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:55:33 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:53892 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265386AbTFSDzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:55:03 -0400
Date: Wed, 18 Jun 2003 23:45:56 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234556.GG333@neo.rr.com>
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
#	           ChangeSet	1.1418  -> 1.1419 
#	drivers/pnp/interface.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1419
# [PNP] re-add the previously removed "get" command in interface.c.
# 
# This patch adds the "get" command because at this point it is needed
# for debugging.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Wed Jun 18 23:01:42 2003
+++ b/drivers/pnp/interface.c	Wed Jun 18 23:01:42 2003
@@ -333,6 +333,13 @@
 		pnp_init_resources(&dev->res);
 		goto done;
 	}
+	if (!strnicmp(buf,"get",3)) {
+		down(&pnp_res_mutex);
+		if (pnp_can_read(dev))
+			dev->protocol->get(dev, &dev->res);
+		up(&pnp_res_mutex);
+		goto done;
+	}
 	if (!strnicmp(buf,"set",3)) {
 		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
 		if (dev->active)
