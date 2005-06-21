Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVFUKGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVFUKGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 06:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVFUKGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 06:06:50 -0400
Received: from mail2.turbolinux.co.jp ([203.174.69.140]:6848 "EHLO
	mail2.turbolinux.com") by vger.kernel.org with ESMTP
	id S262039AbVFUKEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 06:04:40 -0400
Message-ID: <42B7E5F2.2060409@turbolinux.com>
Date: Tue, 21 Jun 2005 18:03:30 +0800
From: bobl <bobl@turbolinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050308
X-Accept-Language: en-us, en, zh-cn
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: a trival bug of megaraid in patch 2.6.12-mm1
Content-Type: multipart/mixed;
 boundary="------------020105010404070703060401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020105010404070703060401
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Andrew Morton:

    In 2.6.12-mm1 patch, there are some lines as follow:

 300379 +static int
 300380 +megaraid_reset(Scsi_Cmnd *cmd)
 300381 +{
 300382 +       adapter = (adapter_t *)cmd->device->host->hostdata;
 300383 +       int rc;
 300384 +
 300385 +       spin_lock_irq(&adapter->lock);
 300386 +       rc = __megaraid_reset(cmd);
 300387 +       spin_unlock_irq(&adapter->lock);
 300388 +
 300389 +       return rc;
 300390 +}

    I think between line 300381 and 300382 should add follow line:

       adapter_t       *adapter;

    The attachment is the patch, please confirm it.

    Best Regards
  
    Bob



--------------020105010404070703060401
Content-Type: text/x-patch;
 name="linux-2.6.12-mm1-megaraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12-mm1-megaraid.patch"

diff -purN linux-2.6.12/drivers/scsi/megaraid.c linux-2.6.12.new/drivers/scsi/megaraid.c
--- linux-2.6.12/drivers/scsi/megaraid.c	2005-06-21 18:49:50.118732304 +0900
+++ linux-2.6.12.new/drivers/scsi/megaraid.c	2005-06-21 18:57:55.266978560 +0900
@@ -1975,6 +1975,7 @@ __megaraid_reset(Scsi_Cmnd *cmd)
 static int
 megaraid_reset(Scsi_Cmnd *cmd)
 {
+	adapter_t	*adapter;
 	adapter = (adapter_t *)cmd->device->host->hostdata;
 	int rc;
 

--------------020105010404070703060401--
