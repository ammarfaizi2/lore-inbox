Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSEIRrQ>; Thu, 9 May 2002 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSEIRrP>; Thu, 9 May 2002 13:47:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13074 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S314052AbSEIRrO>;
	Thu, 9 May 2002 13:47:14 -0400
Subject: [PATCH] Fix scsi.c kmod noise
From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 (1.0.2-3) 
Date: 09 May 2002 13:36:52 -0400
Message-Id: <1020965812.1777.9.camel@zorak.rdu.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the scsi kmod issue that annoyed me to tears, and
confused me on several bug reports. This error crops up whenever scsi.c
is compiled in (which is fairly common in 2.4, Red Hat Linux does this
as well). Since its in scsi.c, this bug occurs on all archs, not just
sparc/sparc64 (which is where I'm working).

"kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2"

I didn't see it in bk, so I sent it here.

~spot
---
Tom "spot" Callaway <tcallawa@redhat.com> Red Hat Sales Engineer
Sair Linux and GNU Certified Administrator (LCA)
Red Hat Certified Engineer (RHCE)
GPG: D786 8B22 D9DB 1F8B 4AB7  448E 3C5E 99AD 9305 4260

The words and opinions reflected in this message do not necessarily
reflect those of my employer, Red Hat, and belong solely to me.

"Immature poets borrow, mature poets steal." --- T. S. Eliot
----


--- linux/drivers/scsi/scsi.c.OLD	Wed May  1 16:33:14 2002
+++ linux/drivers/scsi/scsi.c	Wed May  1 16:34:46 2002
@@ -2389,10 +2389,18 @@
 
 		/* Load upper level device handler of some kind */
 	case MODULE_SCSI_DEV:
+
+/* This doesn't make much sense to do unless CONFIG_SCSI is a module itself.
+ *
+ * ~spot <tcallawa@redhat.com> 05012002
+ */
+
+#ifdef MODULE
 #ifdef CONFIG_KMOD
 		if (scsi_hosts == NULL)
 			request_module("scsi_hostadapter");
 #endif
+#endif
 		return scsi_register_device_module((struct Scsi_Device_Template *) ptr);
 		/* The rest of these are not yet implemented */
 

