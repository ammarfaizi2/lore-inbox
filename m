Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSBKCaN>; Sun, 10 Feb 2002 21:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSBKCaE>; Sun, 10 Feb 2002 21:30:04 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:782 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S286343AbSBKC37>; Sun, 10 Feb 2002 21:29:59 -0500
Message-ID: <3C672CA5.1285184D@delusion.de>
Date: Mon, 11 Feb 2002 03:29:57 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.4-pre6 pci/proc.c compile fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The attached patch fixes the following compile warning in 2.5.4-pre6:

proc.c: In function `proc_bus_pci_read':
proc.c:49: warning: passing arg 1 of `PDE' discards qualifiers from pointer target type
proc.c: In function `proc_bus_pci_write':
proc.c:131: warning: passing arg 1 of `PDE' discards qualifiers from pointer target type

I see no reason why the two inline functions should not use const qualifier. Otherwise
the caller in proc.c should be fixed.

Regards,
Udo.

--- linux-2.5.4-pre-vanilla/include/linux/proc_fs.h     Mon Feb 11 03:03:48 2002
+++ linux-2.5.4-pre/include/linux/proc_fs.h     Mon Feb 11 03:09:50 2002
@@ -217,12 +217,12 @@
        struct inode vfs_inode;
 };
 
-static inline struct proc_inode *PROC_I(struct inode *inode)
+static inline struct proc_inode *PROC_I(const struct inode *inode)
 {
        return list_entry(inode, struct proc_inode, vfs_inode);
 }
 
-static inline struct proc_dir_entry *PDE(struct inode *inode)
+static inline struct proc_dir_entry *PDE(const struct inode *inode)
 {
        return PROC_I(inode)->pde;
 }
