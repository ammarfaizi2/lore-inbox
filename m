Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWFWCD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWFWCD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWFWCD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:03:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750712AbWFWCDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:03:55 -0400
Date: Thu, 22 Jun 2006 22:03:50 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: broken null test in s390 claw driver
Message-ID: <20060623020350.GA22465@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, better hope this never gets passed a null dev in its current state.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/s390/net/claw.c~	2006-06-22 22:01:33.000000000 -0400
+++ linux-2.6/drivers/s390/net/claw.c	2006-06-22 22:02:19.000000000 -0400
@@ -529,7 +529,7 @@ claw_open(struct net_device *dev)
         printk(KERN_INFO "%s:%s Enter  \n",dev->name,__FUNCTION__);
 #endif
 	CLAW_DBF_TEXT(4,trace,"open");
-	if (!dev | (dev->name[0] == 0x00)) {
+	if (!dev || (dev->name[0] == 0x00)) {
 		CLAW_DBF_TEXT(2,trace,"BadDev");
 	 	printk(KERN_WARNING "claw: Bad device at open failing \n");
 		return -ENODEV;

-- 
http://www.codemonkey.org.uk
