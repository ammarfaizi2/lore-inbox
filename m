Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVLNDQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVLNDQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVLNDQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:16:10 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:23358 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030318AbVLNDQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:16:08 -0500
Message-Id: <20051214031459.852060000@localhost>
References: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:47 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org
Subject: [patch-mm 3/6] V4L/DVB (3159): Replaces MAX()/MIN() by kernel.h
	max()/min() macros
Content-Disposition: inline; filename=v4l_dvb_3159_replaces_max_min_by_kernel_h_max_min_macros.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

- Replaces MAX()/MIN() by kernel.h max()/min() macros

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/msp3400.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- git.orig/drivers/media/video/msp3400.c
+++ git/drivers/media/video/msp3400.c
@@ -163,8 +163,6 @@ struct msp3400c {
 	int                  watch_stereo:1;
 };
 
-#define MIN(a,b) (((a)>(b))?(b):(a))
-#define MAX(a,b) (((a)>(b))?(a):(b))
 #define HAVE_NICAM(msp)   (((msp->rev2>>8) & 0xff) != 00)
 #define HAVE_SIMPLE(msp)  ((msp->rev1      & 0xff) >= 'D'-'@')
 #define HAVE_SIMPLER(msp) ((msp->rev1      & 0xff) >= 'G'-'@')
@@ -1667,9 +1665,9 @@ static int msp_get_ctrl(struct i2c_clien
 		return 0;
 	case V4L2_CID_AUDIO_BALANCE:
 	{
-		int volume = MAX(msp->left, msp->right);
+		int volume = max(msp->left, msp->right);
 
-		ctrl->value = (32768 * MIN(msp->left, msp->right)) /
+		ctrl->value = (32768 * min(msp->left, msp->right)) /
 		    (volume ? volume : 1);
 		ctrl->value = (msp->left < msp->right) ?
 		    (65535 - ctrl->value) : ctrl->value;
@@ -1684,7 +1682,7 @@ static int msp_get_ctrl(struct i2c_clien
 		ctrl->value = msp->treble;
 		return 0;
 	case V4L2_CID_AUDIO_VOLUME:
-		ctrl->value = MAX(msp->left, msp->right);
+		ctrl->value = max(msp->left, msp->right);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1707,7 +1705,7 @@ static int msp_set_ctrl(struct i2c_clien
 		return 0;
 	case V4L2_CID_AUDIO_BALANCE:
 		balance=ctrl->value;
-		volume = MAX(msp->left, msp->right);
+		volume = max(msp->left, msp->right);
 		set_volume=1;
 		break;
 	case V4L2_CID_AUDIO_BASS:
@@ -1719,9 +1717,9 @@ static int msp_set_ctrl(struct i2c_clien
 		msp3400c_settreble(client, msp->treble);
 		return 0;
 	case V4L2_CID_AUDIO_VOLUME:
-		volume = MAX(msp->left, msp->right);
+		volume = max(msp->left, msp->right);
 
-		balance = (32768 * MIN(msp->left, msp->right)) /
+		balance = (32768 * min(msp->left, msp->right)) /
 					(volume ? volume : 1);
 		balance = (msp->left < msp->right) ?
 					(65535 - balance) : balance;
@@ -1736,8 +1734,8 @@ static int msp_set_ctrl(struct i2c_clien
 	}
 
 	if (set_volume) {
-		msp->left = (MIN(65536 - balance, 32768) * volume) / 32768;
-		msp->right = (MIN(balance, 32768) * volume) / 32768;
+		msp->left = (min(65536 - balance, 32768) * volume) / 32768;
+		msp->right = (min(balance, 32768) * volume) / 32768;
 
 		msp3400_dbg("volume=%d, balance=%d, left=%d, right=%d",
 			volume,balance,msp->left,msp->right);
@@ -1858,8 +1856,8 @@ static int msp_command(struct i2c_client
 
 		if (msp->muted)
 			va->flags |= VIDEO_AUDIO_MUTE;
-		va->volume = MAX(msp->left, msp->right);
-		va->balance = (32768 * MIN(msp->left, msp->right)) /
+		va->volume = max(msp->left, msp->right);
+		va->balance = (32768 * min(msp->left, msp->right)) /
 		    (va->volume ? va->volume : 1);
 		va->balance = (msp->left < msp->right) ?
 		    (65535 - va->balance) : va->balance;
@@ -1878,9 +1876,9 @@ static int msp_command(struct i2c_client
 
 		msp3400_dbg("VIDIOCSAUDIO\n");
 		msp->muted = (va->flags & VIDEO_AUDIO_MUTE);
-		msp->left = (MIN(65536 - va->balance, 32768) *
+		msp->left = (min(65536 - va->balance, 32768) *
 			     va->volume) / 32768;
-		msp->right = (MIN(va->balance, 32768) * va->volume) / 32768;
+		msp->right = (min((int)va->balance, 32768) * va->volume) / 32768;
 		msp->bass = va->bass;
 		msp->treble = va->treble;
 		msp3400_dbg("VIDIOCSAUDIO setting va->volume to %d\n",

--

