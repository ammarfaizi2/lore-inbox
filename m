Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTIWTnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTIWTnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:43:25 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:1434 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262177AbTIWTnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:43:21 -0400
Message-ID: <3F7097FE.2080105@terra.com.br>
Date: Tue, 23 Sep 2003 15:59:10 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: James.Bottomley@HansenPartnership.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: [PATCH] Memory leak in NCR_Q720 found by checker
Content-Type: multipart/mixed;
 boundary="------------070603010409080102060102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070603010409080102060102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi James,

	Patch against 2.6-test5 which frees a struct NCR_Q720_private before 
returning.

	Please consider applying.

	Cheers,

Felipe

--------------070603010409080102060102
Content-Type: text/plain;
 name="NCR_Q720-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NCR_Q720-leak.patch"

--- linux-2.6.0-test5/drivers/scsi/NCR_Q720.c.orig	2003-09-23 15:36:47.000000000 -0300
+++ linux-2.6.0-test5/drivers/scsi/NCR_Q720.c	2003-09-23 15:38:28.000000000 -0300
@@ -179,6 +179,7 @@
 	i = inb(io_base) | (inb(io_base+1)<<8);
 	if(i != NCR_Q720_MCA_ID) {
 		printk(KERN_ERR "NCR_Q720, adapter failed to I/O map registers correctly at 0x%x(0x%x)\n", io_base, i);
+		kfree(p);
 		return -ENODEV;
 	}
 

--------------070603010409080102060102--

