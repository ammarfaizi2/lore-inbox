Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbTCLS7E>; Wed, 12 Mar 2003 13:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbTCLS7E>; Wed, 12 Mar 2003 13:59:04 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:9377 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S261844AbTCLS7C>;
	Wed, 12 Mar 2003 13:59:02 -0500
Date: Wed, 12 Mar 2003 22:08:46 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, Jes.Sorensen@cern.ch
Subject: [2.4] Memleak in Essential RoadRunner HIPPI board driver
Message-ID: <20030312190846.GA27648@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is memleak on error exit path. Seems there was some confusion
   in the mind of whoever added that zeroing statement.
   The patch is trivial, 2.5 is not affected.
   Found with help of smatch + enhanced unfree script

Bye,
    Oleg

===== drivers/net/rrunner.c 1.6 vs edited =====
--- 1.6/drivers/net/rrunner.c	Thu Feb 28 16:57:24 2002
+++ edited/drivers/net/rrunner.c	Wed Mar 12 22:05:15 2003
@@ -1216,7 +1216,6 @@
 
 	rrpriv->info = kmalloc(sizeof(struct rr_info), GFP_KERNEL);
 	if (!rrpriv->info){
-		rrpriv->rx_ctrl = NULL;
 		ecode = -ENOMEM;
 		goto error;
 	}
