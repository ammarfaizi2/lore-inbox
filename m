Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUIWVMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUIWVMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUIWVLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:11:40 -0400
Received: from baikonur.stro.at ([213.239.196.228]:35250 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267396AbUIWVJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:09:03 -0400
Subject: [patch 16/20]  dvb/av7110_hw: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:09:03 +0200
Message-ID: <E1CAapr-00040d-HD@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replace dvb_delay() with msleep() to guarantee the
task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/av7110_hw.c |   22 ++++++------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff -puN drivers/media/dvb/ttpci/av7110_hw.c~msleep-drivers_media_dvb_ttpci_av7110_hw drivers/media/dvb/ttpci/av7110_hw.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/ttpci/av7110_hw.c~msleep-drivers_media_dvb_ttpci_av7110_hw	2004-09-21 20:50:24.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/av7110_hw.c	2004-09-21 20:50:24.000000000 +0200
@@ -106,7 +106,7 @@ void av7110_reset_arm(struct av7110 *av7
 	saa7146_write(av7110->dev, ISR, (MASK_19 | MASK_03));
 
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	dvb_delay(30);	/* the firmware needs some time to initialize */
+	msleep(30);	/* the firmware needs some time to initialize */
 
 	ARM_ResetMailBox(av7110);
 
@@ -268,7 +268,7 @@ int av7110_bootarm(struct av7110 *av7110
 		return -1;
 	}
 	saa7146_setgpio(dev, RESET_LINE, SAA7146_GPIO_OUTHI);
-	dvb_delay(30);	/* the firmware needs some time to initialize */
+	msleep(30);	/* the firmware needs some time to initialize */
 
 	//ARM_ClearIrq(av7110);
 	ARM_ResetMailBox(av7110);
@@ -302,7 +302,7 @@ int __av7110_send_fw_cmd(struct av7110 *
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND idle\n", __FUNCTION__);
 			return -1;
@@ -312,7 +312,7 @@ int __av7110_send_fw_cmd(struct av7110 *
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			return -1;
@@ -322,7 +322,7 @@ int __av7110_send_fw_cmd(struct av7110 *
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, MSGSTATE, 0, 2) & OSDQFull) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "%s: timeout waiting for !OSDQFull\n", __FUNCTION__);
 			return -1;
@@ -341,7 +341,7 @@ int __av7110_send_fw_cmd(struct av7110 *
 #ifdef COM_DEBUG
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk(KERN_ERR "%s: timeout waiting for COMMAND to complete\n",
 			       __FUNCTION__);
@@ -458,7 +458,7 @@ int av7110_fw_request(struct av7110 *av7
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, COMMAND, 0, 2)) {
 #ifdef _NOHANDSHAKE
-		dvb_delay(1);
+		msleep(1);
 #endif
 		if (time_after(jiffies, start + ARM_WAIT_FREE)) {
 			printk("%s: timeout waiting for COMMAND to complete\n", __FUNCTION__);
@@ -470,7 +470,7 @@ int av7110_fw_request(struct av7110 *av7
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2 )) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n", __FUNCTION__);
 			up(&av7110->dcomlock);
@@ -630,7 +630,7 @@ static int FlushText(struct av7110 *av71
 		return -ERESTARTSYS;
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
@@ -654,7 +654,7 @@ static int WriteText(struct av7110 *av71
 
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, BUFF1_BASE, 0, 2)) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_OSD)) {
 			printk(KERN_ERR "%s: timeout waiting for BUFF1_BASE == 0\n",
 			       __FUNCTION__);
@@ -665,7 +665,7 @@ static int WriteText(struct av7110 *av71
 #ifndef _NOHANDSHAKE
 	start = jiffies;
 	while (rdebi(av7110, DEBINOSWAP, HANDSHAKE_REG, 0, 2)) {
-		dvb_delay(1);
+		msleep(1);
 		if (time_after(jiffies, start + ARM_WAIT_SHAKE)) {
 			printk(KERN_ERR "%s: timeout waiting for HANDSHAKE_REG\n",
 			       __FUNCTION__);
_
