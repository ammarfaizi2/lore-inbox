Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312348AbSC3UI6>; Sat, 30 Mar 2002 15:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312353AbSC3UIs>; Sat, 30 Mar 2002 15:08:48 -0500
Received: from alteon01b.roc.frontiernet.net ([66.133.130.232]:33132 "HELO
	relay05.roc.frontiernet.net") by vger.kernel.org with SMTP
	id <S312348AbSC3UIn>; Sat, 30 Mar 2002 15:08:43 -0500
Date: Sat, 30 Mar 2002 15:07:06 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: vt ioctl to get new vt requested by change_console?
Message-ID: <20020330150706.A4932@vaxerdec.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone consider this patch? I don't know how else to get this info
from a user program.  I want to use VT_RELDISP ioctl to say it's not ok
to do a VT switch, based on which VT was requested for activation.  This
information is not otherwise available.

diff -ur linux-2.4.19-pre4/drivers/char/vt.c linux-2.4.19-pre4.new/drivers/char/vt.c
--- linux-2.4.19-pre4/drivers/char/vt.c	Fri Nov 16 13:08:28 2001
+++ linux-2.4.19-pre4.new/drivers/char/vt.c	Fri Mar 29 20:24:47 2002
@@ -735,6 +735,10 @@
 		return copy_to_user((void*)arg, &(vt_cons[console]->vt_mode), 
 							sizeof(struct vt_mode)) ? -EFAULT : 0; 
 
+	case VT_GETNEWVT:
+		return copy_to_user((void*)arg, &(vt_cons[console]->vt_newvt), 
+							sizeof(int)) ? -EFAULT : 0; 
+
 	/*
 	 * Returns global vt state. Note that VT 0 is always open, since
 	 * it's an alias for the current VT, and people can't use it here.
diff -ur linux-2.4.19-pre4/include/linux/vt.h linux-2.4.19-pre4.new/include/linux/vt.h
--- linux-2.4.19-pre4/include/linux/vt.h	Sun Mar 24 05:09:37 1996
+++ linux-2.4.19-pre4.new/include/linux/vt.h	Fri Mar 29 20:25:19 2002
@@ -51,4 +51,6 @@
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
 
+#define VT_GETNEWVT	0x560D	/* which vt has yet to complete VT_ACTIVATE */
+
 #endif /* _LINUX_VT_H */
