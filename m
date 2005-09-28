Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVI1Vx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVI1Vx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVI1Vx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:53:57 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35845 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750930AbVI1Vxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:53:41 -0400
Date: Wed, 28 Sep 2005 17:50:51 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, leonid.grossman@neterion.com
Subject: [patch 2.6.14-rc2 1/2] s2io: change strncpy length arg to use size of target
Message-ID: <09282005175051.10754@bilbo.tuxdriver.com>
In-Reply-To: <09282005175051.10698@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the size of the target array for the length argument to strncpy
instead of the size of the source or a magic number.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/s2io.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -3778,11 +3778,10 @@ static void s2io_ethtool_gdrvinfo(struct
 {
 	nic_t *sp = dev->priv;
 
-	strncpy(info->driver, s2io_driver_name, sizeof(s2io_driver_name));
-	strncpy(info->version, s2io_driver_version,
-		sizeof(s2io_driver_version));
-	strncpy(info->fw_version, "", 32);
-	strncpy(info->bus_info, pci_name(sp->pdev), 32);
+	strncpy(info->driver, s2io_driver_name, sizeof(info->driver));
+	strncpy(info->version, s2io_driver_version, sizeof(info->version));
+	strncpy(info->fw_version, "", sizeof(info->fw_version));
+	strncpy(info->bus_info, pci_name(sp->pdev), sizeof(info->bus_info));
 	info->regdump_len = XENA_REG_SPACE;
 	info->eedump_len = XENA_EEPROM_SPACE;
 	info->testinfo_len = S2IO_TEST_LEN;
