Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162773AbWLBEfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162773AbWLBEfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162774AbWLBEfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:35:23 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:46042 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S1162773AbWLBEfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:35:21 -0500
Date: Fri, 1 Dec 2006 22:35:20 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 7/12] IPMI: add poll delay
Message-ID: <20061202043520.GC30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure to delay a little in the IPMI poll routine so we can pass in
a timeout time and thus time things out.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -807,7 +807,12 @@ static void poll(void *send_info)
 {
 	struct smi_info *smi_info = send_info;
 
-	smi_event_handler(smi_info, 0);
+	/*
+	 * Make sure there is some delay in the poll loop so we can
+	 * drive time forward and timeout things.
+	 */
+	udelay(10);
+	smi_event_handler(smi_info, 10);
 }
 
 static void request_events(void *send_info)
