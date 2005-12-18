Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVLRPpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVLRPpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVLRPpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:45:23 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:41143 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965153AbVLRPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:45:23 -0500
Subject: [PATCH 3/5] - Enable SPDIF output for DVB-S rev 2.3. Firmware 2623
	or higher required.
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: linux-kernel@vger.kernel.org
Cc: js@linuxtv.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com
Date: Sun, 18 Dec 2005 13:23:45 -0200
Message-Id: <1134920704.6702.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Enable SPDIF output for DVB-S rev 2.3. Firmware 2623 or higher required.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/dvb/ttpci/av7110.c    |    3 +++
 drivers/media/dvb/ttpci/av7110_hw.h |    3 ++-
 2 files changed, 5 insertions(+), 1 deletions(-)

a2395ae2b8aefa35ef1a859f095f9c1a81a3ffe5
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 992be0b..7dae91e 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -176,6 +176,9 @@ static void init_av7110_av(struct av7110
 		}
 	}
 
+	if (dev->pci->subsystem_vendor == 0x13c2 && dev->pci->subsystem_device == 0x000e)
+		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, SpdifSwitch, 1, 0); // SPDIF on
+
 	ret = av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
 	if (ret < 0)
 		printk("dvb-ttpci:cannot set volume :%d\n",ret);
diff --git a/drivers/media/dvb/ttpci/av7110_hw.h b/drivers/media/dvb/ttpci/av7110_hw.h
index fedd20f..2a5e87b 100644
--- a/drivers/media/dvb/ttpci/av7110_hw.h
+++ b/drivers/media/dvb/ttpci/av7110_hw.h
@@ -143,7 +143,8 @@ enum av7110_audio_command {
 	MainSwitch,
 	ADSwitch,
 	SendDiSEqC,
-	SetRegister
+	SetRegister,
+	SpdifSwitch
 };
 
 enum av7110_request_command {
-- 
0.99.9.GIT

