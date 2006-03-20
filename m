Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbWCTQCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWCTQCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965685AbWCTQCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:02:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44184 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966470AbWCTPQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:40 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 045/141] V4L/DVB (3271): Update tuner comments
Date: Mon, 20 Mar 2006 12:08:44 -0300
Message-id: <20060320150844.PS497938000045@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139300736 -0200

Right now, all tuners are using the first tuner_params[]
array element for analog mode. We are now ready to begin merging
similar tuner definitions together, such that each tuner definition
will have a tuner_params struct for each available video standard.
The tuner_params[] array element will be chosen based on the video
standard in use.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 17e29cc..2e680cf 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -79,16 +79,6 @@ MODULE_PARM_DESC(offset,"Allows to speci
 #define TUNER_PLL_LOCKED   0x40
 #define TUNER_STEREO_MK3   0x04
 
-/* FIXME:
- * Right now, all tuners are using the first tuner_params[] array element
- * for analog mode. In the future, we will be merging similar tuner
- * definitions together, such that each tuner definition will have a
- * tuner_params struct for each available video standard. At that point,
- * the tuner_params[] array element will be chosen based on the video
- * standard in use.
- *
- */
-
 /* ---------------------------------------------------------------------- */
 
 static int tuner_getstatus(struct i2c_client *c)
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 27fc4d0..9786e59 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -23,13 +23,16 @@
  *	Each tuner_params array may contain one or more elements, one
  *	for each video standard.
  *
- *	FIXME: Some tuner_range definitions are duplicated, and
- *	should be eliminated.
+ *	FIXME: tuner_params struct contains an element, tda988x. We must
+ *	set this for all tuners that contain a tda988x chip, and then we
+ *	can remove this setting from the various card structs.
  *
- *	FIXME: tunertype struct contains an element, has_tda988x.
- *	We must set this for all tunertypes that contain a tda988x
- *	chip, and then we can remove this setting from the various
- *	card structs.
+ *	FIXME: Right now, all tuners are using the first tuner_params[]
+ *	array element for analog mode. In the future, we will be merging
+ *	similar tuner definitions together, such that each tuner definition
+ *	will have a tuner_params struct for each available video standard.
+ *	At that point, the tuner_params[] array element will be chosen
+ *	based on the video standard in use.
  */
 
 /* 0-9 */

