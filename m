Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbVJMTZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbVJMTZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbVJMTZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:25:22 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:52095 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751648AbVJMTZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:25:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=MNJRToBgJBcWx2dcW92T/Ncoka0mDf9dt/zeNTCAc1kj1/aRat5s8lvMFJ0vvLZQFZh3Wxcxwt3X6BJy+srjuzEwVwGPTuAJ0T6Fsp6IKLRYLpwjJk5ZMTNSeDDDaJvE5cq3UtOiQvPiBcLCv1T+2vf93Ff5Yo/lFmlUNjP/u1E=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/14] Big kfree NULL check cleanup - drivers/media
Date: Thu, 13 Oct 2005 21:28:11 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-dvb-maintainer@linuxtv.org,
       Manu Abraham <manu@kromtek.com>, Emard <emard@softhome.net>,
       Marko Kohtala <marko.kohtala@luukku.com>,
       Wilson Michaels <wilsonmichaels@earthlink.net>,
       Andreas Oberritter <obi@linuxtv.org>,
       Kirk Lapray <kirk_lapray@bigfoot.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       video4linux-list@redhat.com,
       Takeo Takahashi <takahashi.takeo@renesas.com>,
       Ralph Metzler <rjkm@thp.uni-koeln.de>, Gerd Knorr <kraxel@bytesex.org>,
       Bill Dirks <bdirks@pacbell.net>, Wolfgang Scherr <scherr@net4you.at>,
       Alan Cox <alan@redhat.com>, Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Serguei Miridonov <mirsev@cicese.mx>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132128.12616.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the drivers/media/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in drivers/media/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/media/dvb/bt8xx/dst.c              |    8 ++------
 drivers/media/dvb/frontends/dvb_dummy_fe.c |    4 ++--
 drivers/media/dvb/frontends/l64781.c       |    3 ++-
 drivers/media/dvb/frontends/lgdt330x.c     |    3 +--
 drivers/media/dvb/frontends/mt312.c        |    3 +--
 drivers/media/dvb/frontends/or51132.c      |    3 +--
 drivers/media/video/arv.c                  |   12 ++++--------
 drivers/media/video/bttv-driver.c          |    6 ++----
 drivers/media/video/v4l1-compat.c          |    6 ++----
 drivers/media/video/videocodec.c           |    6 ++----
 drivers/media/video/videodev.c             |    3 +--
 drivers/media/video/zoran_card.c           |   14 ++++++--------
 12 files changed, 26 insertions(+), 45 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/lgdt330x.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/dvb/frontends/lgdt330x.c	2005-10-13 10:28:41.000000000 +0200
@@ -729,8 +729,7 @@ struct dvb_frontend* lgdt330x_attach(con
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	dprintk("%s: ERROR\n",__FUNCTION__);
 	return NULL;
 }
--- linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/mt312.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/dvb/frontends/mt312.c	2005-10-13 10:28:50.000000000 +0200
@@ -675,8 +675,7 @@ struct dvb_frontend* mt312_attach(const 
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	return NULL;
 }
 
--- linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/dvb/frontends/dvb_dummy_fe.c	2005-10-13 10:29:06.000000000 +0200
@@ -146,7 +146,7 @@ struct dvb_frontend* dvb_dummy_fe_qpsk_a
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
@@ -169,7 +169,7 @@ struct dvb_frontend* dvb_dummy_fe_qam_at
 	return &state->frontend;
 
 error:
-	if (state) kfree(state);
+	kfree(state);
 	return NULL;
 }
 
--- linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/l64781.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/dvb/frontends/l64781.c	2005-10-13 10:29:22.000000000 +0200
@@ -559,7 +559,8 @@ struct dvb_frontend* l64781_attach(const
 	return &state->frontend;
 
 error:
-	if (reg0x3e >= 0) l64781_writereg (state, 0x3e, reg0x3e);  /* restore reg 0x3e */
+	if (reg0x3e >= 0)
+		l64781_writereg (state, 0x3e, reg0x3e);  /* restore reg 0x3e */
 	kfree(state);
 	return NULL;
 }
--- linux-2.6.14-rc4-orig/drivers/media/dvb/frontends/or51132.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/dvb/frontends/or51132.c	2005-10-13 10:29:37.000000000 +0200
@@ -575,8 +575,7 @@ struct dvb_frontend* or51132_attach(cons
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	return NULL;
 }
 
--- linux-2.6.14-rc4-orig/drivers/media/dvb/bt8xx/dst.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/dvb/bt8xx/dst.c	2005-10-13 10:30:01.000000000 +0200
@@ -1331,9 +1331,7 @@ struct dst_state *dst_attach(struct dst_
 {
 	/* check if the ASIC is there */
 	if (dst_probe(state) < 0) {
-		if (state)
-			kfree(state);
-
+		kfree(state);
 		return NULL;
 	}
 	/* determine settings based on type */
@@ -1349,9 +1347,7 @@ struct dst_state *dst_attach(struct dst_
 		break;
 	default:
 		dprintk(verbose, DST_ERROR, 1, "unknown DST type. please report to the LinuxTV.org DVB mailinglist.");
-		if (state)
-			kfree(state);
-
+		kfree(state);
 		return NULL;
 	}
 
--- linux-2.6.14-rc4-orig/drivers/media/video/arv.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/arv.c	2005-10-13 10:30:44.000000000 +0200
@@ -865,10 +865,8 @@ out_dev:
 
 out_irq:
 #endif
-	for (i = 0; i < MAX_AR_HEIGHT; i++) {
-		if (ar->frame[i])
-			kfree(ar->frame[i]);
-	}
+	for (i = 0; i < MAX_AR_HEIGHT; i++)
+		kfree(ar->frame[i]);
 
 out_line_buff:
 #if USE_INT
@@ -899,10 +897,8 @@ static void __exit ar_cleanup_module(voi
 #if USE_INT
 	free_irq(M32R_IRQ_INT3, ar);
 #endif
-	for (i = 0; i < MAX_AR_HEIGHT; i++) {
-		if (ar->frame[i])
-			kfree(ar->frame[i]);
-	}
+	for (i = 0; i < MAX_AR_HEIGHT; i++)
+		kfree(ar->frame[i]);
 #if USE_INT
 	kfree(ar->line_buff);
 #endif
--- linux-2.6.14-rc4-orig/drivers/media/video/zoran_card.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/zoran_card.c	2005-10-13 10:31:59.000000000 +0200
@@ -1057,10 +1057,8 @@ zr36057_init (struct zoran *zr)
 			KERN_ERR
 			"%s: zr36057_init() - kmalloc (STAT_COM) failed\n",
 			ZR_DEVNAME(zr));
-		if (vdev)
-			kfree(vdev);
-		if (mem)
-			kfree((void *)mem);
+		kfree(vdev);
+		kfree((void *)mem);
 		return -ENOMEM;
 	}
 	memset((void *) mem, 0, mem_needed);
@@ -1105,15 +1103,15 @@ zoran_release (struct zoran *zr)
 	/* unregister videocodec bus */
 	if (zr->codec) {
 		struct videocodec_master *master = zr->codec->master_data;
+
 		videocodec_detach(zr->codec);
-		if (master)
-			kfree(master);
+		kfree(master);
 	}
 	if (zr->vfe) {
 		struct videocodec_master *master = zr->vfe->master_data;
+
 		videocodec_detach(zr->vfe);
-		if (master)
-			kfree(master);
+		kfree(master);
 	}
 
 	/* unregister i2c bus */
--- linux-2.6.14-rc4-orig/drivers/media/video/videocodec.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/videocodec.c	2005-10-13 10:32:30.000000000 +0200
@@ -353,8 +353,7 @@ videocodec_build_table (void)
 	dprintk(3, "videocodec_build table: %d entries, %d bytes\n", i,
 		size);
 
-	if (videocodec_buf)
-		kfree(videocodec_buf);
+	kfree(videocodec_buf);
 	videocodec_buf = (char *) kmalloc(size, GFP_KERNEL);
 
 	i = 0;
@@ -471,8 +470,7 @@ videocodec_exit (void)
 {
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("videocodecs", NULL);
-	if (videocodec_buf)
-		kfree(videocodec_buf);
+	kfree(videocodec_buf);
 #endif
 }
 
--- linux-2.6.14-rc4-orig/drivers/media/video/v4l1-compat.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/v4l1-compat.c	2005-10-13 10:32:42.000000000 +0200
@@ -1006,10 +1006,8 @@ v4l_compat_translate_ioctl(struct inode 
 		break;
 	}
 
-	if (cap2)
-		kfree(cap2);
-	if (fmt2)
-		kfree(fmt2);
+	kfree(cap2);
+	kfree(fmt2);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/drivers/media/video/bttv-driver.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/bttv-driver.c	2005-10-13 10:33:07.000000000 +0200
@@ -1951,8 +1951,7 @@ static int setup_window(struct bttv_fh *
 	}
 
 	down(&fh->cap.lock);
-	if (fh->ov.clips)
-		kfree(fh->ov.clips);
+	kfree(fh->ov.clips);
 	fh->ov.clips    = clips;
 	fh->ov.nclips   = n;
 
@@ -2723,8 +2722,7 @@ static int bttv_do_ioctl(struct inode *i
 			fh->ov.w.height = fb->fmt.height;
 			btv->init.ov.w.width  = fb->fmt.width;
 			btv->init.ov.w.height = fb->fmt.height;
-			if (fh->ov.clips)
-				kfree(fh->ov.clips);
+			kfree(fh->ov.clips);
 			fh->ov.clips = NULL;
 			fh->ov.nclips = 0;
 
--- linux-2.6.14-rc4-orig/drivers/media/video/videodev.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/media/video/videodev.c	2005-10-13 10:33:14.000000000 +0200
@@ -215,8 +215,7 @@ video_usercopy(struct inode *inode, stru
 	}
 
 out:
-	if (mbuf)
-		kfree(mbuf);
+	kfree(mbuf);
 	return err;
 }
 



