Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSFFVDx>; Thu, 6 Jun 2002 17:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSFFVDv>; Thu, 6 Jun 2002 17:03:51 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:65456
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317187AbSFFVCx>; Thu, 6 Jun 2002 17:02:53 -0400
Date: Thu, 6 Jun 2002 14:02:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] More work on removing <linux/mm.h> from <linux/vmalloc.h>
Message-ID: <20020606210234.GH14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <20020606194454.GE14252@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 12:44:54PM -0700, Tom Rini wrote:
> This removes <linux/mm.h> from <linux/vmalloc.h>.
> 
> This then goes and fixes all of the files (x86 and PPC) which relied on
> implicit includes which don't happen anymore.  This also takes
> <linux/kdev_t.h> out of fs/mpage.c and puts it into include/linux/bio.h
> where it belongs since <linux/bio.h> references 'kdev_t' directly.
> 
> A quick summary of the of the added includes:
> arch/i386/kernel/microcode.c: needs extern for num_physpages, in linux/mm.h
> include/linux/spinlock.h: local_irq* is defined in <asm/system.h> but
> this was never directly included.
> 
> This depends on the patch to move the vmalloc wrappers out of
> <linux/vmalloc.h>

And the following is in addition to that patch for stuff that's in the
current linux-2.5 tree but wasn't when I tested the inital patch.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/i386/kernel/cpu/amd.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/cpu/amd.c	Wed May  8 08:11:31 2002
+++ edited/arch/i386/kernel/cpu/amd.c	Thu Jun  6 13:51:10 2002
@@ -1,5 +1,6 @@
 #include <linux/init.h>
 #include <linux/bitops.h>
+#include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 
===== include/asm-i386/desc.h 1.4 vs edited =====
--- 1.4/include/asm-i386/desc.h	Sat Apr 27 10:47:46 2002
+++ edited/include/asm-i386/desc.h	Thu Jun  6 13:45:09 2002
@@ -49,6 +49,9 @@
 #define __LDT(n) (((n)<<2) + __FIRST_LDT_ENTRY)
 
 #ifndef __ASSEMBLY__
+
+#include <asm/mmu.h>
+
 struct desc_struct {
 	unsigned long a,b;
 };
