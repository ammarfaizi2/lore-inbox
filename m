Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWG3Kkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWG3Kkm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWG3Kkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:40:42 -0400
Received: from mail.aknet.ru ([82.179.72.26]:4613 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932252AbWG3Kkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:40:41 -0400
Message-ID: <44CC8D4B.3070800@aknet.ru>
Date: Sun, 30 Jul 2006 14:43:23 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2-mm1 (fails without CONFIG_VIDEO_V4L1_COMPAT)
Content-Type: multipart/mixed;
 boundary="------------080903070408000201050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080903070408000201050307
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
Cannot be built with CONFIG_VIDEO_DEV without CONFIG_VIDEO_V4L1_COMPAT,
fails on compat_ioctl32.c.
The quick fix is attached.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------080903070408000201050307
Content-Type: text/x-patch;
 name="vidfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vidfix.diff"

--- a/include/linux/videodev.h	2006-07-30 13:35:21.000000000 +0400
+++ b/include/linux/videodev.h	2006-07-30 14:32:09.000000000 +0400
@@ -16,6 +16,7 @@
 
 #ifdef CONFIG_VIDEO_V4L1_COMPAT
 #define HAVE_V4L1 1
+#endif /* CONFIG_VIDEO_V4L1_COMPAT */
 
 struct video_capability
 {
@@ -337,8 +338,6 @@
 #define VID_HARDWARE_SN9C102	38
 #define VID_HARDWARE_ARV	39
 
-#endif /* CONFIG_VIDEO_V4L1_COMPAT */
-
 #endif /* __LINUX_VIDEODEV_H */
 
 /*

--------------080903070408000201050307--
