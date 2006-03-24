Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWCXSqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWCXSqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWCXSqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:46:36 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:17851
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932566AbWCXSqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:46:35 -0500
Subject: [PATCH] synclink_gt remove uneeded async code
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:46:28 -0600
Message-Id: <1143225988.3656.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code in async receive handling that serves
no purpose with new tty receive buffering.
Previously this code tried to free up receive buffer space,
but now does nothing useful while making expensive calls.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.16/drivers/char/synclink_gt.c	2006-03-24 10:19:43.000000000 -0600
+++ b/drivers/char/synclink_gt.c	2006-03-24 10:21:42.000000000 -0600
@@ -1762,10 +1762,6 @@ static void rx_async(struct slgt_info *i
 		DBGDATA(info, p, count, "rx");
 
 		for(i=0 ; i < count; i+=2, p+=2) {
-			if (tty && chars) {
-				tty_flip_buffer_push(tty);
-				chars = 0;
-			}
 			ch = *p;
 			icount->rx++;
 


