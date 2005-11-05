Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVKEQev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVKEQev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVKEQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:46795 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932105AbVKEQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:31 -0500
Message-Id: <20051105162719.428824000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:11 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, reiserfs-dev@namesys.com,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 21/25] reiserfs: remove ioctl conversion code
Content-Disposition: inline; filename=reiserfs_ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An earlier patch in this series already adds a handler for
this in reiserfs itself, so the code in compat_ioctl.c
is no longer needed.

CC: reiserfs-dev@namesys.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-04 01:19:31.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-04 01:20:04.000000000 +0100
@@ -356,16 +356,6 @@
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
-#define REISERFS_IOC_UNPACK32               _IOW(0xCD,1,int)
-
-static int reiserfs_ioctl32(unsigned fd, unsigned cmd, unsigned long ptr)
-{
-        if (cmd == REISERFS_IOC_UNPACK32)
-                cmd = REISERFS_IOC_UNPACK;
-
-        return sys_ioctl(fd,cmd,ptr);
-}
-
 struct serial_struct32 {
         compat_int_t    type;
         compat_int_t    line;
@@ -435,7 +425,6 @@
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
-HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
 /* Serial */
 HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)

--

