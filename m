Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbTCJEvk>; Sun, 9 Mar 2003 23:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbTCJEvk>; Sun, 9 Mar 2003 23:51:40 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:7298 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262719AbTCJEvK>;
	Sun, 9 Mar 2003 23:51:10 -0500
Date: Mon, 10 Mar 2003 00:05:56 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.64
Message-ID: <20030310000556.GB2118@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030310000521.GA2118@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310000521.GA2118@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1078  -> 1.1079 
#	drivers/pnp/interface.c	1.13    -> 1.14
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/09	ambx1@neo.rr.com	1.1079
# Interface Changes
# 
# A few minor revisions.  Simpifies a few commands and adds config mode 
# information.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Sun Mar  9 23:48:09 2003
+++ b/drivers/pnp/interface.c	Sun Mar  9 23:48:09 2003
@@ -332,11 +332,18 @@
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
 
+	pnp_printf(buffer,"mode = ");
+	if (dev->config_mode & PNP_CONFIG_MANUAL)
+		pnp_printf(buffer,"manual\n");
+	else
+		pnp_printf(buffer,"auto\n");
+
 	pnp_printf(buffer,"state = ");
 	if (dev->active)
 		pnp_printf(buffer,"active\n");
 	else
 		pnp_printf(buffer,"disabled\n");
+
 	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (pnp_port_valid(dev, i)) {
 			pnp_printf(buffer,"io");
@@ -402,13 +409,13 @@
 		retval = pnp_activate_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"auto-config",11)) {
+	if (!strnicmp(buf,"auto",4)) {
 		if (dev->active)
 			goto done;
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"clear-config",12)) {
+	if (!strnicmp(buf,"clear",5)) {
 		if (dev->active)
 			goto done;
 		spin_lock(&pnp_lock);
