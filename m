Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTIIWxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTIIWxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:53:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:57759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264968AbTIIWwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:52:41 -0400
Date: Tue, 9 Sep 2003 15:52:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] warning from agpart backend
Message-Id: <20030909155216.7d416728.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of warning about unused	 function if agp is built as a module.

diff -Nru a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
--- a/drivers/char/agp/backend.c	Tue Sep  9 15:50:51 2003
+++ b/drivers/char/agp/backend.c	Tue Sep  9 15:50:51 2003
@@ -318,7 +318,8 @@
 {
 }
 
-static __init int agp_setup(char *s)
+#ifndef MODULE
+static int __init agp_setup(char *s)
 {
 	if (!strcmp(s,"off"))
 		agp_off = 1;
@@ -327,6 +328,7 @@
 	return 1;	
 }
 __setup("agp=", agp_setup);
+#endif
 
 MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
 MODULE_DESCRIPTION("AGP GART driver");
