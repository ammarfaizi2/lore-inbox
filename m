Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280883AbRK2TkQ>; Thu, 29 Nov 2001 14:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282510AbRK2TkG>; Thu, 29 Nov 2001 14:40:06 -0500
Received: from nat-pool-hsv.redhat.com ([12.150.234.132]:36101 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S280883AbRK2Tjv>; Thu, 29 Nov 2001 14:39:51 -0500
Date: Thu, 29 Nov 2001 13:39:11 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: seq_open, et. al. are not exported for modules
Message-Id: <20011129133911.4816fe2b.reynolds@redhat.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="e0'+kg=.IHf03GEl"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--e0'+kg=.IHf03GEl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Alex,

The patch below, relative to 2.4.16, exports the seq_FOO symbols so they can be
used from a loadable kernel module.

BTW: could the "kmalloc()" calls be safely changed to "vmalloc()"?

--- linux/kernel/ksyms.c.orig	Thu Nov 29 13:14:10 2001
+++ linux/kernel/ksyms.c	Thu Nov 29 13:15:29 2001
@@ -46,6 +46,7 @@
 #include <linux/tty.h>
 #include <linux/in6.h>
 #include <linux/completion.h>
+#include <linux/seq_file.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -559,3 +560,11 @@ EXPORT_SYMBOL(init_task_union);
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+/* Sequential file systems */
+
+EXPORT_SYMBOL(seq_open);
+EXPORT_SYMBOL(seq_read);
+EXPORT_SYMBOL(seq_lseek);
+EXPORT_SYMBOL(seq_release);
+EXPORT_SYMBOL(seq_escape);


---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--e0'+kg=.IHf03GEl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwGjuMACgkQWEn3bOOMcuqpYACgnNvxUEbkaaEO7Wh8oU1iD94x
VVkAn2WBSkJP0sdVeRaP9cImhgGV1Ckj
=oXll
-----END PGP SIGNATURE-----

--e0'+kg=.IHf03GEl--

