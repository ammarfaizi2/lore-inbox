Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbTIVU5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTIVU5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:57:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:62616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263291AbTIVU51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:57:27 -0400
Date: Mon, 22 Sep 2003 13:56:50 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] agp/backend.c
Message-Id: <20030922135650.059b7955.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the ifdef is backwards here. It gave a warning with allmodconfig
about agp_setup not being used.

This is in the latest from 2.6.0-test5 bk tree.

diff -Nru a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
--- a/drivers/char/agp/backend.c	Mon Sep 22 13:53:26 2003
+++ b/drivers/char/agp/backend.c	Mon Sep 22 13:53:26 2003
@@ -318,7 +318,7 @@
 {
 }
 
-#ifdef MODULE
+#ifndef MODULE
 static __init int agp_setup(char *s)
 {
 	if (!strcmp(s,"off"))
