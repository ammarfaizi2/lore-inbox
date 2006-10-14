Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWJNMIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWJNMIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWJNMId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24231 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932205AbWJNMI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:28 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       =?UTF-8?q?P=E1draig=20Brady?= <P@draigBrady.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/18] V4L/DVB (4739): SECAM support for saa7113 into
	saa7115
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120050.PS99547500010@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pádraig Brady <P@draigBrady.com>

Without the attached trivial patch, the saa7113 is set up for PAL when SECAM 
is selected and hence will see only show black and white for SECAM signals.
Tested the patch against the saa7115 module in linux-2.6.17 with a 
Pinnacle 50e USB tuner (em28xx).

Signed-off-by: Pádraig Brady <P@draigBrady.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7115.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index 974179d..c5719f7 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -960,6 +960,8 @@ static void saa711x_set_v4lstd(struct i2
 			reg |= 0x10;
 		} else if (std == V4L2_STD_NTSC_M_JP) {
 			reg |= 0x40;
+		} else if (std == V4L2_STD_SECAM) {
+			reg |= 0x50;
 		}
 		saa711x_write(client, R_0E_CHROMA_CNTL_1, reg);
 	} else {

