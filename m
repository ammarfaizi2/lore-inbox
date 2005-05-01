Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVEASCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVEASCt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVEASCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 14:02:49 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:49157 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262630AbVEASCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 14:02:46 -0400
Date: Sun, 1 May 2005 20:03:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] I2C updates for 2.4.31-pre1 (3/3)
Message-Id: <20050501200340.51c339f2.khali@linux-fr.org>
In-Reply-To: <20050501185236.2f76a5ba.khali@linux-fr.org>
References: <20050501185236.2f76a5ba.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an iteration bug in the handling of i2c client module parameters.
The "force" module parameter is a list of adapter, address pairs, not
triplets. The current code would only handle the first, fourth, seventh
etc. pairs properly. I guess that nobody ever needed more than one pair,
or the bug would have been noticed way earlier. This bug was originally
fixed by myself in Linux 2.6.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111231616107325
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/i2c-core.c@1.66

--- linux-2.4.30-rc1/drivers/i2c/i2c-core.c.orig	2005-03-10 19:57:34.000000000 +0100
+++ linux-2.4.30-rc1/drivers/i2c/i2c-core.c	2005-03-27 19:09:46.000000000 +0200
@@ -851,7 +851,7 @@
 		   at all */
 		found = 0;
 
-		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 3) {
+		for (i = 0; !found && (address_data->force[i] != I2C_CLIENT_END); i += 2) {
 			if (((adap_id == address_data->force[i]) || 
 			     (address_data->force[i] == ANY_I2C_BUS)) &&
 			     (addr == address_data->force[i+1])) {


-- 
Jean Delvare
