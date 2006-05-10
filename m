Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWEJC4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWEJC4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWEJC4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:31 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:55101 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932428AbWEJC4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:24 -0400
Date: Tue, 9 May 2006 19:56:08 -0700
Message-Id: <200605100256.k4A2u8mC031803@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: werner@almesberger.net, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] zatm_open gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this warning could be a bug. Where alloc_shaper() could 
return without an error, and not touch "pcr" . Needs review ..

Fixes the following warning,

drivers/atm/zatm.c: In function 'zatm_open':
drivers/atm/zatm.c:920: warning: 'pcr' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/atm/zatm.c
===================================================================
--- linux-2.6.16.orig/drivers/atm/zatm.c
+++ linux-2.6.16/drivers/atm/zatm.c
@@ -917,7 +917,8 @@ static int open_tx_first(struct atm_vcc 
 	unsigned long flags;
 	u32 *loop;
 	unsigned short chan;
-	int pcr,unlimited;
+	int pcr = ATM_OC3_PCR;
+	int unlimited;
 
 	DPRINTK("open_tx_first\n");
 	zatm_dev = ZATM_DEV(vcc->dev);
