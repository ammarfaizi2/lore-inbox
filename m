Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbUJZBND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUJZBND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUJZBME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:12:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:2762 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261928AbUJZBJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:09:57 -0400
Subject: [PATCH TRIVIAL 2.6] X.25 : Dont log "unknown frame type" when
	receiving clear confirm
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1098749619.3099.194.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Oct 2004 10:13:39 +1000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2004 00:16:27.0169 (UTC) FILETIME=[08DB4910:01C4BAF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to log this for clear confirm.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>

diff -up linux-2.6.8.1/net/x25/x25_dev.c.orig linux-2.6.8.1/net/x25/x25_dev.c
--- linux-2.6.8.1/net/x25/x25_dev.c.orig        2004-10-26 09:58:36.158922080 +1000
+++ linux-2.6.8.1/net/x25/x25_dev.c     2004-10-26 10:03:01.134639648 +1000
@@ -92,7 +92,12 @@ static int x25_receive_data(struct sk_bu
 /*
        x25_transmit_clear_request(nb, lci, 0x0D);
 */
-       printk(KERN_DEBUG "x25_receive_data(): unknown frame type %2x\n",frametype);
+
+       /*
+        *      Dont spam the logs for clear confirms.
+        */
+       if (frametype != X25_CLEAR_CONFIRMATION)
+               printk(KERN_DEBUG "x25_receive_data(): unknown frame type %2x\n",frametype);
  
        return 0;
 }


