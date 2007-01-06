Return-Path: <linux-kernel-owner+w=401wt.eu-S1751089AbXAFC0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbXAFC0S (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbXAFC0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:26:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47751 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbXAFCZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:25:57 -0500
Message-Id: <20070106023018.133711000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:01 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Hans Verkuil <hverkuil@xs4all.nl>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [patch 08/50] V4L: Fix broken TUNER_LG_NTSC_TAPE radio support
Content-Disposition: inline; filename=v4l-fix-broken-tuner_lg_ntsc_tape-radio-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

The TUNER_LG_NTSC_TAPE is identical in all respects to the
TUNER_PHILIPS_FM1236_MK3. So use the params struct for the Philips tuner.
Also add this LG_NTSC_TAPE tuner to the switches where radio specific
parameters are set so it behaves like a TUNER_PHILIPS_FM1236_MK3. This
change fixes the radio support for this tuner (the wrong bandswitch byte
was used).

Thanks to Andy Walls <cwalls@radix.net> for finding this bug.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---

 drivers/media/video/tuner-simple.c |    2 ++
 drivers/media/video/tuner-types.c  |   14 ++------------
 2 files changed, 4 insertions(+), 12 deletions(-)

--- linux-2.6.19.1.orig/drivers/media/video/tuner-simple.c
+++ linux-2.6.19.1/drivers/media/video/tuner-simple.c
@@ -108,6 +108,7 @@ static int tuner_stereo(struct i2c_clien
 		case TUNER_PHILIPS_FM1216ME_MK3:
 		case TUNER_PHILIPS_FM1236_MK3:
 		case TUNER_PHILIPS_FM1256_IH3:
+		case TUNER_LG_NTSC_TAPE:
 			stereo = ((status & TUNER_SIGNAL) == TUNER_STEREO_MK3);
 			break;
 		default:
@@ -421,6 +422,7 @@ static void default_set_radio_freq(struc
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 	case TUNER_PHILIPS_FMD1216ME_MK3:
+	case TUNER_LG_NTSC_TAPE:
 		buffer[3] = 0x19;
 		break;
 	case TUNER_TNF_5335MF:
--- linux-2.6.19.1.orig/drivers/media/video/tuner-types.c
+++ linux-2.6.19.1/drivers/media/video/tuner-types.c
@@ -672,16 +672,6 @@ static struct tuner_params tuner_panason
 	},
 };
 
-/* ------------ TUNER_LG_NTSC_TAPE - LGINNOTEK NTSC ------------ */
-
-static struct tuner_params tuner_lg_ntsc_tape_params[] = {
-	{
-		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_fm1236_mk3_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
-	},
-};
-
 /* ------------ TUNER_TNF_8831BGFF - Philips PAL ------------ */
 
 static struct tuner_range tuner_tnf_8831bgff_pal_ranges[] = {
@@ -1331,8 +1321,8 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_LG_NTSC_TAPE] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC (TAPE series)",
-		.params = tuner_lg_ntsc_tape_params,
-		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_params),
+		.params = tuner_fm1236_mk3_params,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_params),
 	},
 	[TUNER_TNF_8831BGFF] = { /* Philips PAL */
 		.name   = "Tenna TNF 8831 BGFF)",

--
