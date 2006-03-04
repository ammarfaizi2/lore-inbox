Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWCDMOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWCDMOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCDMOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751708AbWCDMO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:26 -0500
Date: Sat, 4 Mar 2006 13:14:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [RFC: -mm patch] drivers/media/video/msp3400-kthreads.c: make 3 functions static
Message-ID: <20060304121426.GL9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
>  git-dvb.patch
>...
>  git trees
>...


This patch makes three needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/msp3400-kthreads.c |    6 +++---
 drivers/media/video/msp3400.h          |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc5-mm2-full/drivers/media/video/msp3400.h.old	2006-03-03 17:40:22.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/media/video/msp3400.h	2006-03-03 17:40:41.000000000 +0100
@@ -104,7 +104,6 @@
 
 /* msp3400-kthreads.c */
 const char *msp_standard_std_name(int std);
-void msp_set_source(struct i2c_client *client, u16 src);
 void msp_set_audmode(struct i2c_client *client);
 void msp_detect_stereo(struct i2c_client *client);
 int msp3400c_thread(void *data);
--- linux-2.6.16-rc5-mm2-full/drivers/media/video/msp3400-kthreads.c.old	2006-03-03 17:39:29.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/media/video/msp3400-kthreads.c	2006-03-03 17:40:10.000000000 +0100
@@ -154,7 +154,7 @@
 	return "unknown";
 }
 
-void msp_set_source(struct i2c_client *client, u16 src)
+static void msp_set_source(struct i2c_client *client, u16 src)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 
@@ -217,7 +217,7 @@
 
 /* Set audio mode. Note that the pre-'G' models do not support BTSC+SAP,
    nor do they support stereo BTSC. */
-void msp3400c_set_audmode(struct i2c_client *client)
+static void msp3400c_set_audmode(struct i2c_client *client)
 {
 	static char *strmode[] = { "mono", "stereo", "lang2", "lang1" };
 	struct msp_state *state = i2c_get_clientdata(client);
@@ -944,7 +944,7 @@
 		status, is_stereo, is_bilingual, state->rxsubchans);
 }
 
-void msp34xxg_set_audmode(struct i2c_client *client)
+static void msp34xxg_set_audmode(struct i2c_client *client)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 	int source;

