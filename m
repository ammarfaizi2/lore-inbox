Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWIHWzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWIHWzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWIHWzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:17 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:18571 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751241AbWIHWzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:55:09 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225508.9340.93436.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 6/10] tipar: repair nonexistant pr_debug argument use
Date: Fri,  8 Sep 2006 15:55:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tipar: repair nonexistant pr_debug argument use 

I guessed what the pr_debug meant by 'data'.
Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 drivers/char/tipar.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/drivers/char/tipar.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/drivers/char/tipar.c
+++ 2.6.18-rc6-debug-args/drivers/char/tipar.c
@@ -224,14 +224,16 @@ probe_ti_parallel(int minor)
 {
 	int i;
 	int seq[] = { 0x00, 0x20, 0x10, 0x30 };
+	int data;
 
 	for (i = 3; i >= 0; i--) {
 		outbyte(3, minor);
 		outbyte(i, minor);
 		udelay(delay);
+		data = inbyte(minor) & 0x30;
 		pr_debug("tipar: Probing -> %i: 0x%02x 0x%02x\n", i,
-			data & 0x30, seq[i]);
-		if ((inbyte(minor) & 0x30) != seq[i]) {
+			data, seq[i]);
+		if (data != seq[i]) {
 			outbyte(3, minor);
 			return -1;
 		}
