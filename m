Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129548AbRBVOJG>; Thu, 22 Feb 2001 09:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129589AbRBVOI4>; Thu, 22 Feb 2001 09:08:56 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:64413 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129548AbRBVOIl>; Thu, 22 Feb 2001 09:08:41 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200102221407.PAA08636@sunrise.pg.gda.pl>
Subject: Re: Linux-2.4.2
To: azz@gnu.org (Adam Sampson)
Date: Thu, 22 Feb 2001 15:07:39 +0100 (MET)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <87ae7eonla.fsf@cartman.azz.net> from "Adam Sampson" at Feb 22, 2001 01:26:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam Sampson wrote:"
> I get this while compiling 2.4.2:
> 
> msdos.c:403: `MINIX_PARTITION' undeclared (first use in this function)
> msdos.c:403: (Each undeclared identifier is reported only once
> msdos.c:403: for each function it appears in.)
> msdos.c:406: `MINIX_NR_SUBPARTITIONS' undeclared (first use in this function)
> msdos.c: In function `msdos_partition':
> msdos.c:571: `MINIX_PARTITION' undeclared (first use in this function)
> make[3]: *** [msdos.o] Error 1
> 
> My config:
> 
[...]
> CONFIG_MINIX_SUBPARTITION=y

It seems that Linus didn't fully merge some stuff from Alan patches.
Try the following patch:

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/linux/genhd.h linux.ac/include/linux/genhd.h
--- linux-2.4.2/include/linux/genhd.h	Thu Jan  4 22:50:47 2001
+++ linux/include/linux/genhd.h	Tue Feb 20 20:46:28 2001
@@ -222,6 +222,11 @@
 };  /* 408 */
 
 #endif /* CONFIG_UNIXWARE_DISKLABEL */
+
+#ifdef CONFIG_MINIX_SUBPARTITION
+#   define MINIX_PARTITION         0x81  /* Minix Partition ID */
+#   define MINIX_NR_SUBPARTITIONS  4
+#endif /* CONFIG_MINIX_SUBPARTITION */
 
 #ifdef __KERNEL__
 extern struct gendisk *gendisk_head;	/* linked list of disks */

--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
