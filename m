Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKXVhn>; Fri, 24 Nov 2000 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130154AbQKXVhd>; Fri, 24 Nov 2000 16:37:33 -0500
Received: from [209.143.110.29] ([209.143.110.29]:39947 "HELO
        mail.the-rileys.net") by vger.kernel.org with SMTP
        id <S129518AbQKXVhX>; Fri, 24 Nov 2000 16:37:23 -0500
Message-ID: <3A1ED883.9AD8136A@the-rileys.net>
Date: Fri, 24 Nov 2000 16:07:15 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.6-15apmac ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        linuxppc-dev@lists.linuxppc.org
Subject: asm-ppc/elf.h error
Content-Type: multipart/mixed;
 boundary="------------418C4271965BDC49095F50E4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------418C4271965BDC49095F50E4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In asm-ppc/elf.h, <asm/types.h> is not included.  This breaks
compilations of anything that compiles it (e.g. binutils) because the
vector registers for Altivec aren't defined elsewhere.  Included is a
quick diff.  I didn't know which PPC maintainer to send this to, so I
posted it to the linuxppc-dev list.

Thanks,
	David
--------------418C4271965BDC49095F50E4
Content-Type: text/plain; charset=us-ascii;
 name="elf.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="elf.h.diff"

--- linux/include/asm-ppc/elf.h.old	Fri Nov 24 15:42:44 2000
+++ linux/include/asm-ppc/elf.h	Fri Nov 24 15:43:54 2000
@@ -4,6 +4,7 @@
 /*
  * ELF register definitions..
  */
+#include <linux/config.h>
 #include <asm/ptrace.h>
 
 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
@@ -25,9 +26,11 @@
 typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
+#ifdef CONFIG_ALTIVEC
 /* Altivec registers */
 typedef __vector128 elf_vrreg_t;
 typedef elf_vrreg_t elf_vrregset_t[ELF_NVRREG];
+#endif
 
 #ifdef __KERNEL__
 

--------------418C4271965BDC49095F50E4--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
