Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDRWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDRWUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDRWUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:20:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19978 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750776AbWDRWUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:20:19 -0400
Date: Wed, 19 Apr 2006 00:20:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/vivi.c: possible cleanups
Message-ID: <20060418222018.GZ11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanup:
- make needlessly global functions static
- remove unused #ifndef kzalloc kzalloc() #define

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/vivi.c |   44 ++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

--- linux-2.6.17-rc1-mm3-full/drivers/media/video/vivi.c.old	2006-04-18 21:39:05.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/media/video/vivi.c	2006-04-18 21:43:48.000000000 +0200
@@ -47,16 +47,6 @@
 
 #include "font.h"
 
-#ifndef kzalloc
-#define kzalloc(size, flags)                            \
-({                                                      \
-	void *__ret = kmalloc(size, flags);             \
-	if (__ret)                                      \
-		memset(__ret, 0, size);                 \
-	__ret;                                          \
-})
-#endif
-
 MODULE_DESCRIPTION("Video Technology Magazine Virtual Video Capture Board");
 MODULE_AUTHOR("Mauro Carvalho Chehab, Ted Walther and John Sokol");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -247,7 +237,8 @@
 #define TSTAMP_MAX_Y TSTAMP_MIN_Y+15
 #define TSTAMP_MIN_X 64
 
-void prep_to_addr(struct sg_to_addr to_addr[],struct videobuf_buffer *vb)
+static void prep_to_addr(struct sg_to_addr to_addr[],
+			 struct videobuf_buffer *vb)
 {
 	int i, pos=0;
 
@@ -258,7 +249,7 @@
 	}
 }
 
-inline int get_addr_pos(int pos, int pages, struct sg_to_addr to_addr[])
+static int get_addr_pos(int pos, int pages, struct sg_to_addr to_addr[])
 {
 	int p1=0,p2=pages-1,p3=pages/2;
 
@@ -279,8 +270,8 @@
 	return (p1);
 }
 
-void gen_line(struct sg_to_addr to_addr[],int inipos,int pages,int wmax,
-					int hmax, int line, char *timestr)
+static void gen_line(struct sg_to_addr to_addr[],int inipos,int pages,int wmax,
+		     int hmax, int line, char *timestr)
 {
 	int  w,i,j,pos=inipos,pgpos,oldpg,y;
 	char *p,*s,*basep;
@@ -490,7 +481,7 @@
 		dprintk(1,"%s: %d buffers handled (should be 1)\n",__FUNCTION__,bc);
 }
 
-void vivi_sleep(struct vivi_dmaqueue  *dma_q)
+static void vivi_sleep(struct vivi_dmaqueue  *dma_q)
 {
 	int timeout;
 	DECLARE_WAITQUEUE(wait, current);
@@ -525,7 +516,7 @@
 	try_to_freeze();
 }
 
-int vivi_thread(void *data)
+static int vivi_thread(void *data)
 {
 	struct vivi_dmaqueue  *dma_q=data;
 
@@ -541,7 +532,7 @@
 	return 0;
 }
 
-int vivi_start_thread(struct vivi_dmaqueue  *dma_q)
+static int vivi_start_thread(struct vivi_dmaqueue  *dma_q)
 {
 	dma_q->frame=0;
 	dma_q->ini_jiffies=jiffies;
@@ -559,7 +550,7 @@
 	return 0;
 }
 
-void vivi_stop_thread(struct vivi_dmaqueue  *dma_q)
+static void vivi_stop_thread(struct vivi_dmaqueue  *dma_q)
 {
 	dprintk(1,"%s\n",__FUNCTION__);
 	/* shutdown control thread */
@@ -665,8 +656,7 @@
 	return 0;
 }
 
-void
-free_buffer(struct videobuf_queue *vq, struct vivi_buffer *buf)
+static void free_buffer(struct videobuf_queue *vq, struct vivi_buffer *buf)
 {
 	dprintk(1,"%s\n",__FUNCTION__);
 
@@ -790,8 +780,8 @@
 	free_buffer(vq,buf);
 }
 
-int vivi_map_sg (void *dev, struct scatterlist *sg, int nents,
-	   int direction)
+static int vivi_map_sg(void *dev, struct scatterlist *sg, int nents,
+		       int direction)
 {
 	int i;
 
@@ -807,15 +797,15 @@
 	return nents;
 }
 
-int vivi_unmap_sg(void *dev,struct scatterlist *sglist,int nr_pages,
-					int direction)
+static int vivi_unmap_sg(void *dev,struct scatterlist *sglist,int nr_pages,
+			 int direction)
 {
 	dprintk(1,"%s\n",__FUNCTION__);
 	return 0;
 }
 
-int vivi_dma_sync_sg(void *dev,struct scatterlist *sglist,int nr_pages,
-					int direction)
+static int vivi_dma_sync_sg(void *dev,struct scatterlist *sglist, int nr_pages,
+			    int direction)
 {
 //	dprintk(1,"%s\n",__FUNCTION__);
 
@@ -899,7 +889,7 @@
 	return 1;
 }
 
-static inline int res_locked(struct vivi_dev *dev)
+static int res_locked(struct vivi_dev *dev)
 {
 	return (dev->resources);
 }

