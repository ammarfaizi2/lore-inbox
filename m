Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbTEFI4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTEFI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:56:46 -0400
Received: from [66.212.224.118] ([66.212.224.118]:46860 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S262463AbTEFI4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:56:45 -0400
Date: Tue, 6 May 2003 05:00:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] fix OSS opl3sa2 compile
Message-ID: <Pine.LNX.4.50.0305060458090.13957-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.68-mm4/sound/oss/opl3sa2.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.68/sound/oss/opl3sa2.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 opl3sa2.c
--- linux-2.5.68-mm4/sound/oss/opl3sa2.c	20 Apr 2003 05:02:02 -0000	1.1.1.1
+++ linux-2.5.68-mm4/sound/oss/opl3sa2.c	4 May 2003 12:19:20 -0000
@@ -353,7 +353,8 @@ static void opl3sa2_mixer_reset(opl3sa2_
 	}
 }
 
-
+/* Currently only used for power management */
+#ifdef CONFIG_PM
 static void opl3sa2_mixer_restore(opl3sa2_state_t* devc)
 {
 	if (devc) {
@@ -366,7 +367,7 @@ static void opl3sa2_mixer_restore(opl3sa
 		}
 	}
 }
-
+#endif
 
 static inline void arg_to_vol_mono(unsigned int vol, int* value)
 {
@@ -961,7 +962,6 @@ static int opl3sa2_resume(struct pm_dev 
 	spin_unlock_irqrestore(&opl3sa2_lock,flags);
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static int opl3sa2_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
 {
@@ -976,6 +976,7 @@ static int opl3sa2_pm_callback(struct pm
 	}
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 /*
  * Install OPL3-SA2 based card(s).
@@ -1127,10 +1128,11 @@ static void __exit cleanup_opl3sa2(void)
 	int card;
 
 	for(card = 0; card < opl3sa2_cards_num; card++) {
+#ifdef CONFIG_PM
 		if (opl3sa2_state[card].pmdev)
 			pm_unregister(opl3sa2_state[card].pmdev);
-
-	        if(opl3sa2_state[card].cfg_mpu.slots[1] != -1) {
+#endif
+	        if (opl3sa2_state[card].cfg_mpu.slots[1] != -1) {
 			unload_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
  		}
 		unload_opl3sa2_mss(&opl3sa2_state[card].cfg_mss);

-- 
function.linuxpower.ca
