Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVCYSaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVCYSaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVCYSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:30:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261730AbVCYS36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:29:58 -0500
Date: Fri, 25 Mar 2005 19:29:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ipmi/ipmi_msghandler.c: fix an off by one error
Message-ID: <20050325182957.GD3153@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an off by one error found by the Coverity checker
(ipmi_interfaces contains MAX_IPMI_INTERFACES elements).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/char/ipmi/ipmi_msghandler.c.old	2005-03-23 01:28:29.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/char/ipmi/ipmi_msghandler.c	2005-03-23 01:28:50.000000000 +0100
@@ -641,7 +641,7 @@ int ipmi_create_user(unsigned int       
 		return -ENOMEM;
 
 	down_read(&interfaces_sem);
-	if ((if_num > MAX_IPMI_INTERFACES) || ipmi_interfaces[if_num] == NULL)
+	if ((if_num >= MAX_IPMI_INTERFACES) || ipmi_interfaces[if_num] == NULL)
 	{
 		rv = -EINVAL;
 		goto out_unlock;

