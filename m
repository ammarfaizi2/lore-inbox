Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVALUtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVALUtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVALUpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:45:52 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:61493 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261429AbVALUgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:36:06 -0500
Date: Wed, 12 Jan 2005 22:36:06 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com, VANDROVE@vc.cvut.cz
Subject: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050112203606.GA23307@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106140636.GE25629@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I just noticed that my original patch says "ioctl_compat" all over the place
while the actual field name in -mm2 is "compat_ioctl". Doh.
Here's a replacement patch.
PS. Please dont flame me, I do not maintain out of kernel modules, myself :)

To make life bearable for out-of kernel modules, the following patch
adds 2 macros so that existance of unlocked_ioctl and compat_ioctl
can be easily detected.
 
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff -puN include/linux/fs.h~ioctl-rework include/linux/fs.h
--- 25/include/linux/fs.h~ioctl-rework	Thu Dec 16 15:48:31 2004
+++ 25-akpm/include/linux/fs.h	Thu Dec 16 15:48:31 2004
@@ -907,6 +907,12 @@ typedef struct {
 
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long, unsigned long);
 
+/* These macros are for out of kernel modules to test that
+ * the kernel supports the unlocked_ioctl and compat_ioctl
+ * fields in struct file_operations. */
+#define HAVE_COMPAT_IOCTL 1
+#define HAVE_UNLOCKED_IOCTL 1
+
 /*
  * NOTE:
  * read, write, poll, fsync, readv, writev can be called
