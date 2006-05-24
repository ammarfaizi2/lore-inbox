Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWEXSOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWEXSOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 14:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWEXSOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 14:14:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32162 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932411AbWEXSOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 14:14:54 -0400
Subject: [PATCH] V4L/DVB (4045): Fixes recursive dependency for I2C
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 15:13:14 -0300
Message-Id: <1148494394.27196.20.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Mixing "depends on I2C" and "select I2C" within the media subsystem
leads to the following problem:
Warning! Found recursive dependency: I2C DVB_BUDGET DVB_BUDGET_PATCH
DVB_AV7110 VIDEO_SAA7146_VV VIDEO_SAA7146 I2C

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/common/Kconfig     |    2 +-
 drivers/media/dvb/pluto2/Kconfig |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
index 9c45b98..1a04db4 100644
--- a/drivers/media/common/Kconfig
+++ b/drivers/media/common/Kconfig
@@ -1,6 +1,6 @@
 config VIDEO_SAA7146
 	tristate
-	select I2C
+	depends on I2C
 
 config VIDEO_SAA7146_VV
 	tristate
diff --git a/drivers/media/dvb/pluto2/Kconfig
b/drivers/media/dvb/pluto2/Kconfig
index 48252e9..7d8e6e8 100644
--- a/drivers/media/dvb/pluto2/Kconfig
+++ b/drivers/media/dvb/pluto2/Kconfig
@@ -1,7 +1,6 @@
 config DVB_PLUTO2
 	tristate "Pluto2 cards"
 	depends on DVB_CORE && PCI && I2C
-	select I2C
 	select I2C_ALGOBIT
 	select DVB_TDA1004X
 	help


