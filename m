Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284810AbRLEXVS>; Wed, 5 Dec 2001 18:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284817AbRLEXVI>; Wed, 5 Dec 2001 18:21:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:51972 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284810AbRLEXUu>;
	Wed, 5 Dec 2001 18:20:50 -0500
Subject: [PATCH] simple ide without proc compile fix
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 18:20:49 -0500
Message-Id: <1007594451.28567.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patch is a repost now against 2.4.17-pre4.

IDE will not compile without CONFIG_PROC_FS defined.  This patch fixes
that.

Yes, ifdefs in the code are not preferred.  But this is merely following
the pattern in the rest of the ide*.c files (see other uses of
ide_remove_proc_entries -- just these two seem to be without ifdefs).

Please, apply.

	Robert Love

--- linux-2.4.17-pre4/drivers/ide/ide-disk.c	Wed Dec  5 15:16:57 2001
+++ linux/drivers/ide/ide-disk.c	Wed Dec  5 18:13:35 2001
@@ -858,8 +858,10 @@
 		}
 		/* We must remove proc entries defined in this module.
 		   Otherwise we oops while accessing these entries */
+#ifdef CONFIG_PROC_FS
 		if (drive->proc)
 			ide_remove_proc_entries(drive->proc, idedisk_proc);
+#endif
 	}
 	ide_unregister_module(&idedisk_module);
 }
--- linux-2.4.17-pre4/drivers/ide/ide-floppy.c	Wed Dec  5 15:16:57 2001
+++ linux/drivers/ide/ide-floppy.c	Wed Dec  5 18:13:35 2001
@@ -2071,8 +2071,10 @@
 		}
 		/* We must remove proc entries defined in this module.
 		   Otherwise we oops while accessing these entries */
+#ifdef CONFIG_PROC_FS
 		if (drive->proc)
 			ide_remove_proc_entries(drive->proc, idefloppy_proc);
+#endif
 	}
 	ide_unregister_module(&idefloppy_module);
 }

