Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbSJKOJW>; Fri, 11 Oct 2002 10:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSJKOJV>; Fri, 11 Oct 2002 10:09:21 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:45573 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S262476AbSJKOIm>; Fri, 11 Oct 2002 10:08:42 -0400
Date: Fri, 11 Oct 2002 08:10:31 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss (3 of 3)
Message-ID: <20021011081031.C1911@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wait up to 20 seconds for polled commands to complete.  A certain multiport
storage box needs this.

diff -urN linux-2.5.41-p/drivers/block/cciss.c linux-2.5.41-q/drivers/block/cciss.c
--- linux-2.5.41-p/drivers/block/cciss.c	Wed Oct  9 15:22:14 2002
+++ linux-2.5.41-q/drivers/block/cciss.c	Wed Oct  9 15:54:35 2002
@@ -1318,9 +1318,9 @@
         unsigned long done;
         int i;
 
-        /* Wait (up to 2 seconds) for a command to complete */
+        /* Wait (up to 20 seconds) for a command to complete */
 
-        for (i = 200000; i > 0; i--) {
+        for (i = 2000000; i > 0; i--) {
                 done = hba[ctlr]->access.command_completed(hba[ctlr]);
                 if (done == FIFO_EMPTY) {
                         udelay(10);     /* a short fixed delay */
