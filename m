Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283140AbRK2UJg>; Thu, 29 Nov 2001 15:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283133AbRK2UJ1>; Thu, 29 Nov 2001 15:09:27 -0500
Received: from nat-pool-hsv.redhat.com ([12.150.234.132]:16652 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S283200AbRK2UJM>; Thu, 29 Nov 2001 15:09:12 -0500
Date: Thu, 29 Nov 2001 14:08:35 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seq_open, et. al. are not exported for modules
Message-Id: <20011129140835.26e8e40e.reynolds@redhat.com>
In-Reply-To: <20011129133911.4816fe2b.reynolds@redhat.com>
In-Reply-To: <20011129133911.4816fe2b.reynolds@redhat.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.6KI)B)fOEAt3rX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.6KI)B)fOEAt3rX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

More important activities lacking, "Tommy Reynolds" <reynolds@redhat.com> wrote:

> Alex,
> 
> The patch below, relative to 2.4.16, exports the seq_FOO symbols so they can be
> used from a loadable kernel module.

The patch omitted "seq_printf" ;-(

This one doesn't:

--- linux/kernel/ksyms.c.orig	Thu Nov 29 13:14:10 2001
+++ linux/kernel/ksyms.c	Thu Nov 29 13:58:27 2001
@@ -46,6 +46,7 @@
 #include <linux/tty.h>
 #include <linux/in6.h>
 #include <linux/completion.h>
+#include <linux/seq_file.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -559,3 +560,12 @@ EXPORT_SYMBOL(init_task_union);
 
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
+EXPORT_SYMBOL(seq_printf);


---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.6KI)B)fOEAt3rX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwGlcgACgkQWEn3bOOMcuqjowCfbxhw62uDZZQjtINZE+2dlY/8
OZAAnj+2ZUkwM54cppIjCDZdUyLwPZ6t
=4O8M
-----END PGP SIGNATURE-----

--=.6KI)B)fOEAt3rX--

