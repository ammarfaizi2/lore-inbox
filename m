Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289097AbSAJAOk>; Wed, 9 Jan 2002 19:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSAJAO3>; Wed, 9 Jan 2002 19:14:29 -0500
Received: from petreley.org ([64.170.109.178]:56214 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S289093AbSAJAOK>;
	Wed, 9 Jan 2002 19:14:10 -0500
Date: Wed, 9 Jan 2002 16:13:59 -0800
From: Nicholas Petreley <nicholas@petreley.com>
To: linux-kernel@vger.kernel.org
Subject: NVidia patch for kdev_t
Message-ID: <20020110001357.GA1654@petreley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: The fellow who noted that kdev_t breaks the current nv.c driver.

I'm just guessing here based on what other patches I've seen, so pardon me
if this isn't the proper way to handle the change, or if I missed anything. 
But it worked for me and my GeForce3.  This patch is against
NVIDIA_kernel-1.0-2314.

--- nv.c Fri Nov 30 20:11:06 2001
+++ NVIDIA_kernel-1.0-2314/nv.c  Thu Jan  3 17:18:42 2002
@@ -1146,11 +1146,11 @@

     /* for control device, just jump to its open routine */
     /* after setting up the private data */
-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+    if (NV_DEVICE_IS_CONTROL_DEVICE(minor(inode->i_rdev)))
         return nv_kern_ctl_open(inode, file);

     /* what device are we talking about? */
-    devnum = NV_DEVICE_NUMBER(inode->i_rdev);
+    devnum = NV_DEVICE_NUMBER(minor(inode->i_rdev));
     if (devnum >= NV_MAX_DEVICES)
     {
         rc = -ENODEV;
@@ -1257,7 +1257,7 @@

     /* for control device, just jump to its open routine */
     /* after setting up the private data */
-    if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+    if (NV_DEVICE_IS_CONTROL_DEVICE(minor(inode->i_rdev)))
         return nv_kern_ctl_close(inode, file);

     NV_DMSG(nv, "close");






-- 
***********************************************************
Nicholas Petreley        http://www.VarLinux.org
nicholas@petreley.com    http://www.computerworld.com
http://www.petreley.org  http://www.linuxworld.com Eph 6:12
***********************************************************
