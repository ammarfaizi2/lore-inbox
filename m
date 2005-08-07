Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753033AbVHGWUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbVHGWUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 18:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbVHGWUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 18:20:19 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:35224 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1753033AbVHGWUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 18:20:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DVgFqIyWwe+SIy9sTYXuatEyW5Su3t5cKex9T96vbAhaKUXAK9o/iBJ4l54Dqd13t0GHDRfRvhVYIBvdc0j7J+BL6ksm881GZwxW7tsJIzbQ13NeEfcsxqS4TfTFoo0wen91pJsmtCv/BEHJzWBSlGetZ0Sc/XXQsJb5aXxBFSQ=
Date: Mon, 8 Aug 2005 02:28:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: [PATCH C&C] gdth: remove GDTIOCTL_OSVERS
Message-ID: <20050807222829.GA20558@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/gdth.c       |   12 ------------
 drivers/scsi/gdth_ioctl.h |    8 --------
 2 files changed, 20 deletions(-)

diff -uprN linux-vanilla/drivers/scsi/gdth.c linux-gdth/drivers/scsi/gdth.c
--- linux-vanilla/drivers/scsi/gdth.c	2005-08-08 02:16:47.000000000 +0400
+++ linux-gdth/drivers/scsi/gdth.c	2005-08-08 02:19:59.000000000 +0400
@@ -5411,18 +5411,6 @@ static int gdth_ioctl(struct inode *inod
                 return -EFAULT;
         break;
       }
-      
-      case GDTIOCTL_OSVERS:
-      { 
-        gdth_ioctl_osvers osv; 
-
-        osv.version = (unchar)(LINUX_VERSION_CODE >> 16);
-        osv.subversion = (unchar)(LINUX_VERSION_CODE >> 8);
-        osv.revision = (ushort)(LINUX_VERSION_CODE & 0xff);
-        if (copy_to_user(argp, &osv, sizeof(gdth_ioctl_osvers)))
-                return -EFAULT;
-        break;
-      }
 
       case GDTIOCTL_CTRTYPE:
       { 
diff -uprN linux-vanilla/drivers/scsi/gdth_ioctl.h linux-gdth/drivers/scsi/gdth_ioctl.h
--- linux-vanilla/drivers/scsi/gdth_ioctl.h	2005-08-08 02:16:47.000000000 +0400
+++ linux-gdth/drivers/scsi/gdth_ioctl.h	2005-08-08 02:20:19.000000000 +0400
@@ -10,7 +10,6 @@
 #define GDTIOCTL_GENERAL    (GDTIOCTL_MASK | 0) /* general IOCTL */
 #define GDTIOCTL_DRVERS     (GDTIOCTL_MASK | 1) /* get driver version */
 #define GDTIOCTL_CTRTYPE    (GDTIOCTL_MASK | 2) /* get controller type */
-#define GDTIOCTL_OSVERS     (GDTIOCTL_MASK | 3) /* get OS version */
 #define GDTIOCTL_HDRLIST    (GDTIOCTL_MASK | 4) /* get host drive list */
 #define GDTIOCTL_CTRCNT     (GDTIOCTL_MASK | 5) /* get controller count */
 #define GDTIOCTL_LOCKDRV    (GDTIOCTL_MASK | 6) /* lock host drive */
@@ -296,13 +295,6 @@ typedef struct {
     unchar channel;                             /* channel */
 } gdth_ioctl_lockchn;
 
-/* GDTIOCTL_OSVERS */
-typedef struct {
-    unchar version;                             /* OS version */
-    unchar subversion;                          /* OS subversion */
-    ushort revision;                            /* revision */
-} gdth_ioctl_osvers;
-
 /* GDTIOCTL_CTRTYPE */
 typedef struct {
     ushort ionode;                              /* controller number */

