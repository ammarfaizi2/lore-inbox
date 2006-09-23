Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWIWAdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWIWAdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWIWAdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:33:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17587 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964976AbWIWAdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:33:41 -0400
Date: Sat, 23 Sep 2006 01:33:40 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more s2io __iomem annotations
Message-ID: <20060923003340.GG29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/s2io.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index e72e0e0..86d5e67 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -2903,7 +2903,7 @@ static void s2io_mdio_write(u32 mmd_type
 {
 	u64 val64 = 0x0;
 	nic_t *sp = dev->priv;
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *)sp->bar0;
+	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 
 	//address transaction
 	val64 = val64 | MDIO_MMD_INDX_ADDR(addr)
@@ -2952,7 +2952,7 @@ static u64 s2io_mdio_read(u32 mmd_type, 
 	u64 val64 = 0x0;
 	u64 rval64 = 0x0;
 	nic_t *sp = dev->priv;
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *)sp->bar0;
+	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 
 	/* address transaction */
 	val64 = val64 | MDIO_MMD_INDX_ADDR(addr)
@@ -3275,7 +3275,7 @@ static void alarm_intr_handler(struct s2
  *   SUCCESS on success and FAILURE on failure.
  */
 
-static int wait_for_cmd_complete(void *addr, u64 busy_bit)
+static int wait_for_cmd_complete(void __iomem *addr, u64 busy_bit)
 {
 	int ret = FAILURE, cnt = 0;
 	u64 val64;
-- 
1.4.2.GIT
