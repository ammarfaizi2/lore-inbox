Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTEKM7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTEKM6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:58:07 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:26608 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261339AbTEKM5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:57:25 -0400
Date: Sun, 11 May 2003 15:05:27 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: linux-2.4.21-rc2: agpgart_be.c errors
Message-Id: <20030511150527.5366d9bb.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.21-rc2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Under powerpc I've got:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-rc2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/src/linux-2.4.21-rc2/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.21-rc2/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:86: #error "Please define flush_cache."
agpgart_be.c: In function `agp_generic_create_gatt_table':
agpgart_be.c:580: warning: assignment from incompatible pointer type
agpgart_be.c: At top level:
agpgart_be.c:392: warning: `agp_generic_agp_enable' defined but not used
agpgart_be.c:485: warning: `agp_generic_create_gatt_table' defined but not used
agpgart_be.c:609: warning: `agp_generic_suspend' defined but not used
agpgart_be.c:614: warning: `agp_generic_resume' defined but not used
agpgart_be.c:619: warning: `agp_generic_free_gatt_table' defined but not used
agpgart_be.c:671: warning: `agp_generic_insert_memory' defined but not used
agpgart_be.c:733: warning: `agp_generic_remove_memory' defined but not used
agpgart_be.c:750: warning: `agp_generic_alloc_by_type' defined but not used
agpgart_be.c:755: warning: `agp_generic_free_by_type' defined but not used
agpgart_be.c:773: warning: `agp_generic_alloc_page' defined but not used
agpgart_be.c:793: warning: `agp_generic_destroy_page' defined but not used
make[3]: *** [agpgart_be.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-rc2/drivers/char/agp'
make[2]: *** [_modsubdir_agp] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-rc2/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc2/drivers'
make: *** [_mod_drivers] Error 2


However, the following little change would make it compile:

diff -rauN linux-2.4.21-rc2/drivers/char/agp/agpgart_be.c_orig linux-2.4.21-rc2/drivers/char/agp/agpgart_be.c 
--- linux-2.4.21-rc2/drivers/char/agp/agpgart_be.c_orig Sun May 11 15:26:34 2003
+++ linux-2.4.21-rc2/drivers/char/agp/agpgart_be.c      Sun May 11 15:52:47 2003
@@ -83,7 +83,8 @@
           Ditto for IA-64. --davidm 00/08/07 */
        mb();
 #else
-#error "Please define flush_cache."
+       mb();
+//#error "Please define flush_cache."
 #endif
 }


Any clues ? My architecture is a normal PowerBook4,3 (PowerPC G3 900MHz).


*Kristian

-- 

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 ::                            _\_V
  :.........................:
