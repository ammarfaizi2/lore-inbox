Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWCTP16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWCTP16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWCTP1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:27:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964875AbWCTP07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:59 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Andreas Oberritter <obi@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 107/141] V4L/DVB (3375): Add AUDIO_GET_PTS and
	VIDEO_GET_PTS ioctls
Date: Mon, 20 Mar 2006 12:08:54 -0300
Message-id: <20060320150854.PS813737000107@infradead.org>
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

From: Andreas Oberritter <obi@linuxtv.org>
Date: 1141009740 -0300

Add two new ioctls to read the 33 bit presentation time stamp from audio
and video devices as defined in ITU T-REC-H.222.0 and ISO/IEC 13818-1.
Acked-by: Johannes Stezenbach <js@linuxtv.org>

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/include/linux/dvb/audio.h b/include/linux/dvb/audio.h
diff --git a/include/linux/dvb/audio.h b/include/linux/dvb/audio.h
index 2b87970..0874a67 100644
--- a/include/linux/dvb/audio.h
+++ b/include/linux/dvb/audio.h
@@ -121,4 +121,17 @@ typedef uint16_t audio_attributes_t;
 #define AUDIO_SET_ATTRIBUTES       _IOW('o', 17, audio_attributes_t)
 #define AUDIO_SET_KARAOKE          _IOW('o', 18, audio_karaoke_t)
 
+/**
+ * AUDIO_GET_PTS
+ *
+ * Read the 33 bit presentation time stamp as defined
+ * in ITU T-REC-H.222.0 / ISO/IEC 13818-1.
+ *
+ * The PTS should belong to the currently played
+ * frame if possible, but may also be a value close to it
+ * like the PTS of the last decoded frame or the last PTS
+ * extracted by the PES parser.
+ */
+#define AUDIO_GET_PTS              _IOR('o', 19, __u64)
+
 #endif /* _DVBAUDIO_H_ */
diff --git a/include/linux/dvb/video.h b/include/linux/dvb/video.h
diff --git a/include/linux/dvb/video.h b/include/linux/dvb/video.h
index b1999bf..1f7fa03 100644
--- a/include/linux/dvb/video.h
+++ b/include/linux/dvb/video.h
@@ -200,4 +200,17 @@ typedef uint16_t video_attributes_t;
 #define VIDEO_GET_SIZE             _IOR('o', 55, video_size_t)
 #define VIDEO_GET_FRAME_RATE       _IOR('o', 56, unsigned int)
 
+/**
+ * VIDEO_GET_PTS
+ *
+ * Read the 33 bit presentation time stamp as defined
+ * in ITU T-REC-H.222.0 / ISO/IEC 13818-1.
+ *
+ * The PTS should belong to the currently played
+ * frame if possible, but may also be a value close to it
+ * like the PTS of the last decoded frame or the last PTS
+ * extracted by the PES parser.
+ */
+#define VIDEO_GET_PTS              _IOR('o', 57, __u64)
+
 #endif /*_DVBVIDEO_H_*/

