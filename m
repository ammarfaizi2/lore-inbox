Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270159AbTGPF5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 01:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270160AbTGPF5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 01:57:45 -0400
Received: from [66.212.224.118] ([66.212.224.118]:46866 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270159AbTGPF5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 01:57:44 -0400
Date: Wed, 16 Jul 2003 02:01:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org
Subject: [PATCH][2.6] fix warning in iee1394 nodemgr
Message-ID: <Pine.LNX.4.53.0307160159330.32541@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a sensible default

drivers/ieee1394/nodemgr.c: In function `nodemgr_host_thread':
drivers/ieee1394/nodemgr.c:1621: warning: `generation' might be used uninitialized in this function

Index: linux-2.5/drivers/ieee1394/nodemgr.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/ieee1394/nodemgr.c,v
retrieving revision 1.28
diff -u -p -B -r1.28 nodemgr.c
--- linux-2.5/drivers/ieee1394/nodemgr.c	29 Jun 2003 18:51:20 -0000	1.28
+++ linux-2.5/drivers/ieee1394/nodemgr.c	16 Jul 2003 03:54:56 -0000
@@ -1618,7 +1618,7 @@ static int nodemgr_host_thread(void *__h
 	 * happens when we get a bus reset. */
 	while (!down_interruptible(&hi->reset_sem) &&
 	       !down_interruptible(&nodemgr_serialize)) {
-		unsigned int generation;
+		unsigned int generation = get_hpsb_generation(host);
 		int i;
 
 		/* Pause for 1/4 second, to make sure things settle down. */

-- 
function.linuxpower.ca
