Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287707AbSABOIk>; Wed, 2 Jan 2002 09:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287832AbSABOI2>; Wed, 2 Jan 2002 09:08:28 -0500
Received: from mail106.mail.bellsouth.net ([205.152.58.46]:51907 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S287707AbSABOGg>; Wed, 2 Jan 2002 09:06:36 -0500
Message-ID: <3C3313E4.10B5E0D2@bellsouth.net>
Date: Wed, 02 Jan 2002 09:06:28 -0500
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ollie@sis.com.tw, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: [PATCH]take2 2.4.18-pre1 sound/trident fix with newer binutils
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take 2.  Mistake in previous patch.  Sorry.
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
--- trident.c.orig      Wed Jan  2 06:36:12 2002
+++ trident.c   Wed Jan  2 08:59:09 2002
@@ -4141,7 +4141,7 @@
        goto out;
 }
 
-static void __exit trident_remove(struct pci_dev *pci_dev)
+static void __devexit trident_remove(struct pci_dev *pci_dev)
 {
        int i;
        struct trident_card *card = pci_get_drvdata(pci_dev);
@@ -4194,7 +4194,7 @@
        name:           TRIDENT_MODULE_NAME,
        id_table:       trident_pci_tbl,
        probe:          trident_probe,
-       remove:         trident_remove,
+       remove:         __devexit_p(trident_remove),
        suspend:        trident_suspend,
        resume:         trident_resume
 };
@@ -4214,7 +4214,7 @@
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

