Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUGAHuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUGAHuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUGAHtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:49:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39856 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264256AbUGAHsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:48:42 -0400
Date: Thu, 1 Jul 2004 00:47:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: jakub@redhat.com, wesolows@foobazco.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040701004746.70f8440a.davem@redhat.com>
In-Reply-To: <20040630225220.GA32560@mail.shareable.org>
References: <20040630030503.GA25149@mail.shareable.org>
	<20040630082804.GS21264@devserv.devel.redhat.com>
	<20040630135419.25b843b8.davem@redhat.com>
	<20040630225220.GA32560@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 23:52:20 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> The PaX security patch already implements R!X pages on Sparc64, so you
> could just cut out that part of the patch.  Just pick out the changes
> to arch/sparc64/* and include/asm-sparc64/*:
> 
> 	http://pax.grsecurity.net/pax-linux-2.6.7-200406252135.patch
> 
> It appears to use exactly the technique Jakub describes, and has been tested.

Again, thanks for pointing this out.  I'm going to push the following
upstream to Linus for 2.6.x and I'm going to backport this to 2.4.x
as well.

It makes your test_prot program do the following on my UltraSPARC-III
machine.

Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r--    !w-    rw-    r-x    r-x    rwx    rwx
MAP_PRIVATE    | ---    r--    !w-    rw-    r-x    r-x    rwx    rwx

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/01 00:38:22-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Non-executable page support.
#   
#   Based upon the PAX patches.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# include/asm-sparc64/pgtable.h
#   2004/07/01 00:37:55-07:00 davem@nuts.davemloft.net +21 -10
#   [SPARC64]: Non-executable page support.
#   
#   Based upon the PAX patches.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# arch/sparc64/mm/fault.c
#   2004/07/01 00:37:55-07:00 davem@nuts.davemloft.net +11 -1
#   [SPARC64]: Non-executable page support.
#   
#   Based upon the PAX patches.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# arch/sparc64/kernel/itlb_base.S
#   2004/07/01 00:37:55-07:00 davem@nuts.davemloft.net +3 -3
#   [SPARC64]: Non-executable page support.
#   
#   Based upon the PAX patches.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# ChangeSet
#   2004/06/30 23:02:26-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Reserve a software PTE bit for _PAGE_EXEC.
#   
#   Based upon the PAX sparc64 patches.  Also, reformat
#   the comments here so the lines fit in 80 columns.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# include/asm-sparc64/pgtable.h
#   2004/06/30 23:02:00-07:00 davem@nuts.davemloft.net +42 -29
#   [SPARC64]: Reserve a software PTE bit for _PAGE_EXEC.
#   
#   Based upon the PAX sparc64 patches.  Also, reformat
#   the comments here so the lines fit in 80 columns.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# ChangeSet
#   2004/06/30 20:21:47-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Document reserved and soft2 bits in PTE.
# 
# include/asm-sparc64/pgtable.h
#   2004/06/30 20:21:22-07:00 davem@nuts.davemloft.net +3 -0
#   [SPARC64]: Document reserved and soft2 bits in PTE.
# 
diff -Nru a/arch/sparc64/kernel/itlb_base.S b/arch/sparc64/kernel/itlb_base.S
--- a/arch/sparc64/kernel/itlb_base.S	2004-07-01 00:40:02 -07:00
+++ b/arch/sparc64/kernel/itlb_base.S	2004-07-01 00:40:02 -07:00
@@ -41,6 +41,9 @@
 	CREATE_VPTE_OFFSET2(%g4, %g6)			! Create VPTE offset
 	ldxa		[%g3 + %g6] ASI_P, %g5		! Load VPTE
 1:	brgez,pn	%g5, 3f				! Not valid, branch out
+	 sethi		%hi(_PAGE_EXEC), %g4		! Delay-slot
+	andcc		%g5, %g4, %g0			! Executable?
+	be,pn		%xcc, 3f			! Nope, branch.
 	 nop						! Delay-slot
 2:	stxa		%g5, [%g0] ASI_ITLB_DATA_IN	! Load PTE into TLB
 	retry						! Trap return
@@ -69,9 +72,6 @@
 	done						! Do it to it
 
 /* ITLB ** ICACHE line 4: Unused...	*/
-	nop
-	nop
-	nop
 	nop
 	nop
 	nop
diff -Nru a/arch/sparc64/mm/fault.c b/arch/sparc64/mm/fault.c
--- a/arch/sparc64/mm/fault.c	2004-07-01 00:40:02 -07:00
+++ b/arch/sparc64/mm/fault.c	2004-07-01 00:40:02 -07:00
@@ -257,7 +257,7 @@
 	 * in that case.
 	 */
 
-	if (!(fault_code & FAULT_CODE_WRITE) &&
+	if (!(fault_code & (FAULT_CODE_WRITE|FAULT_CODE_ITLB)) &&
 	    (insn & 0xc0800000) == 0xc0800000) {
 		if (insn & 0x2000)
 			asi = (regs->tstate >> 24);
@@ -408,6 +408,16 @@
 	 */
 good_area:
 	si_code = SEGV_ACCERR;
+
+	/* If we took a ITLB miss on a non-executable page, catch
+	 * that here.
+	 */
+	if ((fault_code & FAULT_CODE_ITLB) && !(vma->vm_flags & VM_EXEC)) {
+		BUG_ON(address != regs->tpc);
+		BUG_ON(regs->tstate & TSTATE_PRIV);
+		goto bad_area;
+	}
+
 	if (fault_code & FAULT_CODE_WRITE) {
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
diff -Nru a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h	2004-07-01 00:40:02 -07:00
+++ b/include/asm-sparc64/pgtable.h	2004-07-01 00:40:02 -07:00
@@ -106,33 +106,49 @@
 #endif /* !(__ASSEMBLY__) */
 
 /* Spitfire/Cheetah TTE bits. */
-#define _PAGE_VALID	_AC(0x8000000000000000,UL) /* Valid TTE               */
-#define _PAGE_R		_AC(0x8000000000000000,UL) /* Keep ref bit up to date */
-#define _PAGE_SZ4MB	_AC(0x6000000000000000,UL) /* 4MB Page                */
-#define _PAGE_SZ512K	_AC(0x4000000000000000,UL) /* 512K Page               */
-#define _PAGE_SZ64K	_AC(0x2000000000000000,UL) /* 64K Page                */
-#define _PAGE_SZ8K	_AC(0x0000000000000000,UL) /* 8K Page                 */
-#define _PAGE_NFO	_AC(0x1000000000000000,UL) /* No Fault Only           */
-#define _PAGE_IE	_AC(0x0800000000000000,UL) /* Invert Endianness       */
-#define _PAGE_SN	_AC(0x0000800000000000,UL) /* (Cheetah) Snoop         */
-#define _PAGE_PADDR_SF	_AC(0x000001FFFFFFE000,UL) /* (Spitfire) paddr [40:13]*/
-#define _PAGE_PADDR	_AC(0x000007FFFFFFE000,UL) /* (Cheetah) paddr [42:13] */
-#define _PAGE_SOFT	_AC(0x0000000000001F80,UL) /* Software bits           */
-#define _PAGE_L		_AC(0x0000000000000040,UL) /* Locked TTE              */
-#define _PAGE_CP	_AC(0x0000000000000020,UL) /* Cacheable in P-Cache    */
-#define _PAGE_CV	_AC(0x0000000000000010,UL) /* Cacheable in V-Cache    */
-#define _PAGE_E		_AC(0x0000000000000008,UL) /* side-Effect             */
-#define _PAGE_P		_AC(0x0000000000000004,UL) /* Privileged Page         */
-#define _PAGE_W		_AC(0x0000000000000002,UL) /* Writable                */
-#define _PAGE_G		_AC(0x0000000000000001,UL) /* Global                  */
-
-/* Here are the SpitFire software bits we use in the TTE's. */
-#define _PAGE_FILE	_AC(0x0000000000001000,UL)	/* Pagecache page     */
-#define _PAGE_MODIFIED	_AC(0x0000000000000800,UL)	/* Modified (dirty)   */
-#define _PAGE_ACCESSED	_AC(0x0000000000000400,UL)	/* Accessed (ref'd)   */
-#define _PAGE_READ	_AC(0x0000000000000200,UL)	/* Readable SW Bit    */
-#define _PAGE_WRITE	_AC(0x0000000000000100,UL)	/* Writable SW Bit    */
-#define _PAGE_PRESENT	_AC(0x0000000000000080,UL)	/* Present            */
+#define _PAGE_VALID	_AC(0x8000000000000000,UL) /* Valid TTE              */
+#define _PAGE_R		_AC(0x8000000000000000,UL) /* Keep ref bit up to date*/
+#define _PAGE_SZ4MB	_AC(0x6000000000000000,UL) /* 4MB Page               */
+#define _PAGE_SZ512K	_AC(0x4000000000000000,UL) /* 512K Page              */
+#define _PAGE_SZ64K	_AC(0x2000000000000000,UL) /* 64K Page               */
+#define _PAGE_SZ8K	_AC(0x0000000000000000,UL) /* 8K Page                */
+#define _PAGE_NFO	_AC(0x1000000000000000,UL) /* No Fault Only          */
+#define _PAGE_IE	_AC(0x0800000000000000,UL) /* Invert Endianness      */
+#define _PAGE_SOFT2	_AC(0x07FC000000000000,UL) /* Software bits, set 2   */
+#define _PAGE_RES1	_AC(0x0003000000000000,UL) /* Reserved               */
+#define _PAGE_SN	_AC(0x0000800000000000,UL) /* (Cheetah) Snoop        */
+#define _PAGE_RES2	_AC(0x0000780000000000,UL) /* Reserved               */
+#define _PAGE_PADDR_SF	_AC(0x000001FFFFFFE000,UL) /* (Spitfire) paddr[40:13]*/
+#define _PAGE_PADDR	_AC(0x000007FFFFFFE000,UL) /* (Cheetah) paddr[42:13] */
+#define _PAGE_SOFT	_AC(0x0000000000001F80,UL) /* Software bits          */
+#define _PAGE_L		_AC(0x0000000000000040,UL) /* Locked TTE             */
+#define _PAGE_CP	_AC(0x0000000000000020,UL) /* Cacheable in P-Cache   */
+#define _PAGE_CV	_AC(0x0000000000000010,UL) /* Cacheable in V-Cache   */
+#define _PAGE_E		_AC(0x0000000000000008,UL) /* side-Effect            */
+#define _PAGE_P		_AC(0x0000000000000004,UL) /* Privileged Page        */
+#define _PAGE_W		_AC(0x0000000000000002,UL) /* Writable               */
+#define _PAGE_G		_AC(0x0000000000000001,UL) /* Global                 */
+
+/* Here are the SpitFire software bits we use in the TTE's.
+ *
+ * WARNING: If you are going to try and start using some
+ *          of the soft2 bits, you will need to make
+ *          modifications to the swap entry implementation.
+ *	    For example, one thing that could happen is that
+ *          swp_entry_to_pte() would BUG_ON() if you tried
+ *          to use one of the soft2 bits for _PAGE_FILE.
+ *
+ * Like other architectures, I have aliased _PAGE_FILE with
+ * _PAGE_MODIFIED.  This works because _PAGE_FILE is never
+ * interpreted that way unless _PAGE_PRESENT is clear.
+ */
+#define _PAGE_EXEC	_AC(0x0000000000001000,UL)	/* Executable SW bit */
+#define _PAGE_MODIFIED	_AC(0x0000000000000800,UL)	/* Modified (dirty)  */
+#define _PAGE_FILE	_AC(0x0000000000000800,UL)	/* Pagecache page    */
+#define _PAGE_ACCESSED	_AC(0x0000000000000400,UL)	/* Accessed (ref'd)  */
+#define _PAGE_READ	_AC(0x0000000000000200,UL)	/* Readable SW Bit   */
+#define _PAGE_WRITE	_AC(0x0000000000000100,UL)	/* Writable SW Bit   */
+#define _PAGE_PRESENT	_AC(0x0000000000000080,UL)	/* Present           */
 
 #if PAGE_SHIFT == 13
 #define _PAGE_SZBITS	_PAGE_SZ8K
@@ -164,16 +180,27 @@
 
 /* Don't set the TTE _PAGE_W bit here, else the dirty bit never gets set. */
 #define PAGE_SHARED	__pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
-				  __ACCESS_BITS | _PAGE_WRITE)
+				  __ACCESS_BITS | _PAGE_WRITE | _PAGE_EXEC)
 
 #define PAGE_COPY	__pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
-				  __ACCESS_BITS)
+				  __ACCESS_BITS | _PAGE_EXEC)
 
 #define PAGE_READONLY	__pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
-				  __ACCESS_BITS)
+				  __ACCESS_BITS | _PAGE_EXEC)
 
 #define PAGE_KERNEL	__pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
-				  __PRIV_BITS | __ACCESS_BITS | __DIRTY_BITS)
+				  __PRIV_BITS | \
+				  __ACCESS_BITS | __DIRTY_BITS | _PAGE_EXEC)
+
+#define PAGE_SHARED_NOEXEC	__pgprot (_PAGE_PRESENT | _PAGE_VALID | \
+					  _PAGE_CACHE | \
+					  __ACCESS_BITS | _PAGE_WRITE)
+
+#define PAGE_COPY_NOEXEC	__pgprot (_PAGE_PRESENT | _PAGE_VALID | \
+					  _PAGE_CACHE | __ACCESS_BITS)
+
+#define PAGE_READONLY_NOEXEC	__pgprot (_PAGE_PRESENT | _PAGE_VALID | \
+					  _PAGE_CACHE | __ACCESS_BITS)
 
 #define _PFN_MASK	_PAGE_PADDR
 
@@ -181,18 +208,18 @@
 		   __ACCESS_BITS | _PAGE_E)
 
 #define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
+#define __P001	PAGE_READONLY_NOEXEC
+#define __P010	PAGE_COPY_NOEXEC
+#define __P011	PAGE_COPY_NOEXEC
 #define __P100	PAGE_READONLY
 #define __P101	PAGE_READONLY
 #define __P110	PAGE_COPY
 #define __P111	PAGE_COPY
 
 #define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
+#define __S001	PAGE_READONLY_NOEXEC
+#define __S010	PAGE_SHARED_NOEXEC
+#define __S011	PAGE_SHARED_NOEXEC
 #define __S100	PAGE_READONLY
 #define __S101	PAGE_READONLY
 #define __S110	PAGE_SHARED
