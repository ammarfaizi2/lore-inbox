Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291509AbSBMKTw>; Wed, 13 Feb 2002 05:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291517AbSBMKTm>; Wed, 13 Feb 2002 05:19:42 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:11229 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291509AbSBMKTX>; Wed, 13 Feb 2002 05:19:23 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15466.15703.799443.916646@argo.ozlabs.ibm.com>
Date: Wed, 13 Feb 2002 21:17:59 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fix sd_find_target (v2.5.4)
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a compile error on PPC.  It's in sd_find_target, a
function that returns a kdev_t.  Linus, please apply.

Thanks,
Paul.

diff -urN linuxppc-2.5/drivers/scsi/sd.c pmac-2.5/drivers/scsi/sd.c
--- linuxppc-2.5/drivers/scsi/sd.c	Wed Feb  6 02:23:12 2002
+++ pmac-2.5/drivers/scsi/sd.c	Mon Feb 11 16:44:52 2002
@@ -133,7 +133,7 @@
         if (dp->device != NULL && dp->device->host == host
             && dp->device->id == tgt)
             return MKDEV_SD(i);
-    return 0;
+    return NODEV;
 }
 #endif
 
