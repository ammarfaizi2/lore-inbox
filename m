Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRALVxx>; Fri, 12 Jan 2001 16:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbRALVxn>; Fri, 12 Jan 2001 16:53:43 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:8378 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129811AbRALVxd>; Fri, 12 Jan 2001 16:53:33 -0500
Date: Fri, 12 Jan 2001 13:53:31 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch(?): linux-2.4.1-pre3/include/asm-i386/xor.h referenced undefined HAVE_XMM
Message-ID: <20010112135331.A18858@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	linux-2.4.1-pre2 changed cpu_has_xmm references in
include/asm-i386/xor.h into HAVE_XMM references, which it that
patch also defined.  linux-2.4.1-pre3 removed the definition of
HAVE_XMM but did not revert the references in include/asm-i386/xor.h.
My guess is that cpu_has_xmm is the prefered name, so here is a patch
fixing include/asm-i386/xor.h.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xor.patch"

--- linux-2.4.1-pre3/include/asm-i386/xor.h	Fri Jan 12 05:29:00 2001
+++ linux/include/asm-i386/xor.h	Fri Jan 12 13:46:23 2001
@@ -843,7 +843,7 @@
 	do {						\
 		xor_speed(&xor_block_8regs);		\
 		xor_speed(&xor_block_32regs);		\
-	        if (HAVE_XMM)				\
+	        if (cpu_has_xmm)			\
 			xor_speed(&xor_block_pIII_sse);	\
 	        if (md_cpu_has_mmx()) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
@@ -855,4 +855,4 @@
    We may also be able to load into the L1 only depending on how the cpu
    deals with a load to a line that is being prefetched.  */
 #define XOR_SELECT_TEMPLATE(FASTEST) \
-	(HAVE_XMM ? &xor_block_pIII_sse : FASTEST)
+	(cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)

--PEIAKu/WMn1b1Hv9--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
