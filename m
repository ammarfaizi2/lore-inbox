Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWCTPPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWCTPPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966418AbWCTPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:15:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34712 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966400AbWCTPPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:43 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 106/141] V4L/DVB (3374): Adds debuging v4l2_memory enum
Date: Mon, 20 Mar 2006 12:08:54 -0300
Message-id: <20060320150854.PS650420000106@infradead.org>
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

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1141009738 -0300

Some cleanup on printing enum names.
v4l2_memory now translated also to name.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index 9e41ab7..95a6e47 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -170,7 +170,7 @@ int v4l2_prio_check(struct v4l2_prio_sta
 
 
 /* ----------------------------------------------------------------- */
-/* some arrays for pretty-printing debug messages                    */
+/* some arrays for pretty-printing debug messages of enum types      */
 
 char *v4l2_field_names[] = {
 	[V4L2_FIELD_ANY]        = "any",
@@ -191,6 +191,14 @@ char *v4l2_type_names[] = {
 	[V4L2_BUF_TYPE_VBI_OUTPUT]    = "vbi-out",
 };
 
+static char *v4l2_memory_names[] = {
+	[V4L2_MEMORY_MMAP]    = "mmap",
+	[V4L2_MEMORY_USERPTR] = "userptr",
+	[V4L2_MEMORY_OVERLAY] = "overlay",
+};
+
+#define prt_names(a,arr) (((a)>=0)&&((a)<ARRAY_SIZE(arr)))?arr[a]:"unknown"
+
 /* ------------------------------------------------------------------ */
 /* debug help functions                                               */
 
@@ -328,8 +336,7 @@ static void v4l_print_pix_fmt (char *s, 
 	printk ("%s: width=%d, height=%d, format=%d, field=%s, "
 		"bytesperline=%d sizeimage=%d, colorspace=%d\n", s,
 		fmt->width,fmt->height,fmt->pixelformat,
-		((fmt->field>=0)&&(fmt->field<ARRAY_SIZE(v4l2_field_names)))?
-		v4l2_field_names[fmt->field]:"unknown",
+		prt_names(fmt->field,v4l2_field_names),
 		fmt->bytesperline,fmt->sizeimage,fmt->colorspace);
 };
 
@@ -461,17 +468,18 @@ void v4l_printk_ioctl_arg(char *s,unsign
 		struct v4l2_timecode *tc=&p->timecode;
 		printk ("%s: %02ld:%02d:%02d.%08ld index=%d, type=%s, "
 			"bytesused=%d, flags=0x%08d, "
-			"field=%0d, sequence=%d, memory=%d, offset/userptr=0x%08lx\n",
+			"field=%0d, sequence=%d, memory=%s, offset/userptr=0x%08lx\n",
 				s,
 				(p->timestamp.tv_sec/3600),
 				(int)(p->timestamp.tv_sec/60)%60,
 				(int)(p->timestamp.tv_sec%60),
 				p->timestamp.tv_usec,
 				p->index,
-				((p->type>=0)&&(p->type<ARRAY_SIZE(v4l2_type_names)))?
-				v4l2_type_names[p->type]:"unknown",
+				prt_names(p->type,v4l2_type_names),
 				p->bytesused,p->flags,
-				p->field,p->sequence,p->memory,p->m.userptr);
+				p->field,p->sequence,
+				prt_names(p->memory,v4l2_memory_names),
+				p->m.userptr);
 		printk ("%s: timecode= %02d:%02d:%02d type=%d, "
 			"flags=0x%08d, frames=%d, userbits=0x%08x",
 				s,tc->hours,tc->minutes,tc->seconds,
@@ -536,8 +544,7 @@ void v4l_printk_ioctl_arg(char *s,unsign
 	{
 		struct v4l2_format *p=arg;
 		printk ("%s: type=%s\n", s,
-				((p->type>=0)&&(p->type<ARRAY_SIZE(v4l2_type_names)))?
-				v4l2_type_names[p->type]:"unknown");
+				prt_names(p->type,v4l2_type_names));
 		switch (p->type) {
 		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 			v4l_print_pix_fmt (s, &p->fmt.pix);
@@ -646,8 +653,10 @@ void v4l_printk_ioctl_arg(char *s,unsign
 	case VIDIOC_REQBUFS:
 	{
 		struct v4l2_requestbuffers *p=arg;
-		printk ("%s: count=%d, type=%d, memory=%d\n", s,
-				p->count,p->type,p->memory);
+		printk ("%s: count=%d, type=%s, memory=%s\n", s,
+				p->count,
+				prt_names(p->type,v4l2_type_names),
+				prt_names(p->memory,v4l2_memory_names));
 		break;
 	}
 	case VIDIOC_INT_S_AUDIO_ROUTING:

