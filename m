Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282210AbRK2ABD>; Wed, 28 Nov 2001 19:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282190AbRK2AAy>; Wed, 28 Nov 2001 19:00:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:49418 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282210AbRK2AAp>;
	Wed, 28 Nov 2001 19:00:45 -0500
Subject: [PATCH] silly ide without proc compile fix
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 19:00:39 -0500
Message-Id: <1006992039.813.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE subsystem fails to compile without proc support because
ide_remove_proc_entries is called but not defined.  Other uses of the
function are properly ifdef'ed, the following in ide-disk.c and
ide-floppy.c are not.

Please apply.

	Robert Love

diff -urN linux-2.4.17-pre1/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.4.17-pre1/drivers/ide/ide-disk.c	Wed Nov 28 15:15:35 2001
+++ linux/drivers/ide/ide-disk.c	Wed Nov 28 17:05:07 2001
@@ -856,10 +856,12 @@
 			printk (KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
 			failed++;
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
diff -urN linux-2.4.17-pre1/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.4.17-pre1/drivers/ide/ide-floppy.c	Wed Nov 28 15:15:35 2001
+++ linux/drivers/ide/ide-floppy.c	Wed Nov 28 17:09:21 2001
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

