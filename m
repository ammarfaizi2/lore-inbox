Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRAJFGw>; Wed, 10 Jan 2001 00:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131794AbRAJFGn>; Wed, 10 Jan 2001 00:06:43 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:44773 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129826AbRAJFGc>; Wed, 10 Jan 2001 00:06:32 -0500
Date: Tue, 9 Jan 2001 21:06:25 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transemta.com
Subject: Patch: linux-2.4.0-pre1/arch/i386/i386_ksyms.c needs to export mmu_cr4_features
Message-ID: <20010109210625.A2924@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	linux-2.4.1-pre1/drivers/md/xor.c calls the macro XOR_TRY_TEMPLATES,
which is defined in include/asm-i386/xor.h to use HAVE_XMM, which is
defined in include/asm-i386/processor.h to reference mmu_cr4_features.
So, to support compilation of raid5 as a module, i386_ksyms.c needs
to export mmu_cr4_features.  I have attached the one line patch below.

	Let me also add that 2.4.1-pre1 so far has been really smooth
sailing.  The problems with 2.4.0 hanging on the Sony PictureBook PCG-C1VN
have somehow disappeared with this version, usb-uhci.c does not generate
a kernel oops on that hardware, and this minor addition to i386_ksyms.c
was the only change that I had to make to get a clean build.  Hooray!

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksyms.diff"

--- linux-2.4.1-pre1/arch/i386/kernel/i386_ksyms.c	Wed Dec  6 21:00:12 2000
+++ linux/arch/i386/kernel/i386_ksyms.c	Tue Jan  9 15:46:14 2001
@@ -49,6 +50,7 @@
 
 /* platform dependent support */
 EXPORT_SYMBOL(boot_cpu_data);
+EXPORT_SYMBOL(mmu_cr4_features);
 #ifdef CONFIG_EISA
 EXPORT_SYMBOL(EISA_bus);
 #endif

--LZvS9be/3tNcYl/X--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
