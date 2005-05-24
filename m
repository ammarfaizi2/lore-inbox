Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVEXTBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVEXTBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 15:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVEXTBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 15:01:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34791 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261397AbVEXTBI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 15:01:08 -0400
Date: Tue, 24 May 2005 15:01:07 -0400
From: Neil Horman <nhorman@redhat.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] ipmi: Compiler error in last git kernel [drivers/char/ipmi/ipmi_devintf.c]
Message-ID: <20050524190107.GH17607@hmsendeavour.rdu.redhat.com>
References: <42935D89.90603@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <42935D89.90603@debian.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heres the fix.  Looks pretty straight forward

Signed-off-by: Neil Horman <nhorman@redhat.com>

 ipmi_devintf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


--- linux-2.6.git/drivers/char/ipmi/ipmi_devintf.c.buildbreak	2005-05-24 14:40:58.000000000 -0400
+++ linux-2.6.git/drivers/char/ipmi/ipmi_devintf.c	2005-05-24 14:48:45.000000000 -0400
@@ -520,7 +520,7 @@ MODULE_PARM_DESC(ipmi_major, "Sets the m
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
-static struct class *ipmi_class;
+static struct class_simple *ipmi_class;
 
 static void ipmi_new_smi(int if_num)
 {
@@ -534,7 +534,7 @@ static void ipmi_new_smi(int if_num)
 
 static void ipmi_smi_gone(int if_num)
 {
-	class_simple_device_remove(ipmi_class, MKDEV(ipmi_major, if_num));
+	class_simple_device_remove(MKDEV(ipmi_major, if_num));
 	devfs_remove("ipmidev/%d", if_num);
 }
 
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
