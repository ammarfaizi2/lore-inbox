Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRATQjH>; Sat, 20 Jan 2001 11:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRATQi6>; Sat, 20 Jan 2001 11:38:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17924 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129944AbRATQil>; Sat, 20 Jan 2001 11:38:41 -0500
Date: Sat, 20 Jan 2001 08:38:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Albert Cranford <ac9410@bellsouth.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre9 fails to compile drm r128 as module
In-Reply-To: <3A68EEA7.1A806E6C@bellsouth.net>
Message-ID: <Pine.LNX.4.10.10101200836110.10154-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2001, Albert Cranford wrote:
>
> 2.4.1-pre9 changes to drivers/char/drm/drm.h are incorrect.
> Please reverse this small change to compile correctly.

Actually, please revert a bit more.

(The XFree86 CVS tree is being silly - they've renamed the ioctl's after
4.0.2 instead of just assigning new numbers. I hope they learn. The radeon
merge got a bit too much merged)

		Linus

----
diff -u --recursive --new-file pre9/linux/drivers/char/drm/drm.h linux/drivers/char/drm/drm.h
--- pre9/linux/drivers/char/drm/drm.h	Fri Jan 19 21:41:07 2001
+++ linux/drivers/char/drm/drm.h	Fri Jan 19 21:38:59 2001
@@ -374,15 +374,14 @@
 #define DRM_IOCTL_R128_CCE_RESET	DRM_IO(  0x43)
 #define DRM_IOCTL_R128_CCE_IDLE		DRM_IO(  0x44)
 #define DRM_IOCTL_R128_RESET		DRM_IO(  0x46)
-#define DRM_IOCTL_R128_FULLSCREEN	DRM_IOW( 0x47, drm_r128_fullscreen_t)
-#define DRM_IOCTL_R128_SWAP		DRM_IO(  0x48)
-#define DRM_IOCTL_R128_CLEAR		DRM_IOW( 0x49, drm_r128_clear_t)
-#define DRM_IOCTL_R128_VERTEX		DRM_IOW( 0x4a, drm_r128_vertex_t)
-#define DRM_IOCTL_R128_INDICES		DRM_IOW( 0x4b, drm_r128_indices_t)
-#define DRM_IOCTL_R128_BLIT		DRM_IOW( 0x4c, drm_r128_blit_t)
-#define DRM_IOCTL_R128_DEPTH		DRM_IOW( 0x4d, drm_r128_depth_t)
-#define DRM_IOCTL_R128_STIPPLE		DRM_IOW( 0x4e, drm_r128_stipple_t)
-#define DRM_IOCTL_R128_INDIRECT		DRM_IOWR(0x4f, drm_r128_indirect_t)
+#define DRM_IOCTL_R128_SWAP		DRM_IO(  0x47)
+#define DRM_IOCTL_R128_CLEAR		DRM_IOW( 0x48, drm_r128_clear_t)
+#define DRM_IOCTL_R128_VERTEX		DRM_IOW( 0x49, drm_r128_vertex_t)
+#define DRM_IOCTL_R128_INDICES		DRM_IOW( 0x4a, drm_r128_indices_t)
+#define DRM_IOCTL_R128_BLIT		DRM_IOW( 0x4b, drm_r128_blit_t)
+#define DRM_IOCTL_R128_DEPTH		DRM_IOW( 0x4c, drm_r128_depth_t)
+#define DRM_IOCTL_R128_STIPPLE		DRM_IOW( 0x4d, drm_r128_stipple_t)
+#define DRM_IOCTL_R128_PACKET		DRM_IOWR(0x4e, drm_r128_packet_t)
 
 /* Radeon specific ioctls */
 #define DRM_IOCTL_RADEON_CP_INIT	DRM_IOW( 0x40, drm_radeon_init_t)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
