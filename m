Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284603AbSABMqc>; Wed, 2 Jan 2002 07:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286992AbSABMqY>; Wed, 2 Jan 2002 07:46:24 -0500
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:764 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284603AbSABMqU>; Wed, 2 Jan 2002 07:46:20 -0500
Message-ID: <3C330114.D4F66B45@bellsouth.net>
Date: Wed, 02 Jan 2002 07:46:12 -0500
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ollie@sis.com.tw, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18-pre1 sound/trident fix with newer binutils
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ollie,
Small problem.
I cannot build kernel with binutils-2.11.92.0.12.3

Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
drivers/sound/trident.o(.data+0x154): undefined reference to `local symbols in discarded section .text.exit'

Please submit the attached patch to Marcelo and Linus
for 2.4 and 2.5 respectfully.  This patch also works
with older binutils-2.11.2
Thanks,
Albert
--- linux-2.4.18-pre1/drivers/sound/trident.c.orig      Mon Dec 31 16:32:25 2001
+++ linux/drivers/sound/trident.c       Mon Dec 31 16:32:44 2001
@@ -4141,7 +4141,7 @@
        goto out;
 }
 
-static void __exit trident_remove(struct pci_dev *pci_dev)
+static void __devexit trident_remove(struct pci_dev *pci_dev)
 {
        int i;
        struct trident_card *card = pci_get_drvdata(pci_dev);
@@ -4194,7 +4194,9 @@
        name:           TRIDENT_MODULE_NAME,
        id_table:       trident_pci_tbl,
        probe:          trident_probe,
+#ifdef DEVEXIT_LINKED
        remove:         trident_remove,
+#endif
        suspend:        trident_suspend,
        resume:         trident_resume
 };
@@ -4214,7 +4216,7 @@
        return 0;
 }
 
-static void __exit trident_cleanup_module (void)
+static void __devexit trident_cleanup_module (void)
 {
        pci_unregister_driver(&trident_pci_driver);
 }


-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

