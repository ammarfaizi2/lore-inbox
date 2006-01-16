Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWAPJYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWAPJYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAPJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60907 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932292AbWAPJYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:24:25 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/25] Add support for Samsung tuner TCPN 2121P30A
Date: Mon, 16 Jan 2006 07:11:21 -0200
Message-id: <20060116091121.PS00500000008@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

- Add support for Samsung tuner TCPN 2121P30A, used in
  Hauppauge PVR-500 cards.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 Documentation/video4linux/CARDLIST.tuner |    1 +
 drivers/media/video/tuner-types.c        |   24 ++++++++++++++++++++++++
 drivers/media/video/tveeprom.c           |    2 +-
 include/media/tuner.h                    |    1 +
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
index 0bf3d5b..f6d0cf7 100644
--- a/Documentation/video4linux/CARDLIST.tuner
+++ b/Documentation/video4linux/CARDLIST.tuner
@@ -68,3 +68,4 @@ tuner=66 - LG NTSC (TALN mini series)
 tuner=67 - Philips TD1316 Hybrid Tuner
 tuner=68 - Philips TUV1236D ATSC/NTSC dual in
 tuner=69 - Tena TNF 5335 MF
+tuner=70 - Samsung TCPN 2121P30A
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index de9d492..32c9be4 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -1077,6 +1077,24 @@ static struct tuner_params tuner_tnf_533
 	},
 };
 
+/* 70-79 */
+/* ------------ TUNER_SAMSUNG_TCPN_2121P30A - Samsung NTSC ------------ */
+
+static struct tuner_range tuner_samsung_tcpn_2121p30a_ntsc_ranges[] = {
+	{ 16 * 175.75 /*MHz*/, 0x01, },
+	{ 16 * 410.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_samsung_tcpn_2121p30a_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_samsung_tcpn_2121p30a_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_samsung_tcpn_2121p30a_ntsc_ranges),
+		.config = 0xce,
+	},
+};
+
 /* --------------------------------------------------------------------- */
 
 struct tunertype tuners[] = {
@@ -1371,6 +1389,12 @@ struct tunertype tuners[] = {
 		.name   = "Tena TNF 5335 MF",
 		.params = tuner_tnf_5335mf_params,
 	},
+
+	/* 70-79 */
+	[TUNER_SAMSUNG_TCPN_2121P30A] = { /* Samsung NTSC */
+		.name   = "Samsung TCPN 2121P30A",
+		.params = tuner_samsung_tcpn_2121p30a_params,
+	},
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index 5e71a35..582551b 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -190,7 +190,7 @@ hauppauge_tuner[] =
 	{ TUNER_LG_PAL_NEW_TAPC, "TCL 2002MI 3"},
 	{ TUNER_TCL_2002N,     "TCL 2002N 6A"},
 	{ TUNER_PHILIPS_FM1236_MK3, "Philips FQ1236 MK3"},
-	{ TUNER_ABSENT,        "Samsung TCPN 2121P30A"},
+	{ TUNER_SAMSUNG_TCPN_2121P30A, "Samsung TCPN 2121P30A"},
 	{ TUNER_ABSENT,        "Samsung TCPE 4121P30A"},
 	{ TUNER_PHILIPS_FM1216ME_MK3, "TCL MFPE05 2"},
 	/* 90-99 */
diff --git a/include/media/tuner.h b/include/media/tuner.h
index c88b506..a1d6378 100644
--- a/include/media/tuner.h
+++ b/include/media/tuner.h
@@ -115,6 +115,7 @@
 
 #define TUNER_PHILIPS_TUV1236D		68	/* ATI HDTV Wonder */
 #define TUNER_TNF_5335MF                69	/* Sabrent Bt848   */
+#define TUNER_SAMSUNG_TCPN_2121P30A     70 	/* Hauppauge PVR-500MCE NTSC */
 
 /* tv card specific */
 #define TDA9887_PRESENT 		(1<<0)

