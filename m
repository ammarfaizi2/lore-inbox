Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSFDPrY>; Tue, 4 Jun 2002 11:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSFDPrX>; Tue, 4 Jun 2002 11:47:23 -0400
Received: from vivi.uptime.at ([62.116.87.11]:30381 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S314149AbSFDPrU>;
	Tue, 4 Jun 2002 11:47:20 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Jan-Benedict Glaw'" <jbglaw@lug-owl.de>, <linux-kernel@vger.kernel.org>
Cc: <axp-kernel-list@redhat.com>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Date: Tue, 4 Jun 2002 17:47:10 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <002801c20bdf$199a2460$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0029_01C20BEF.DD22F460"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020604142207.GN20788@lug-owl.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0029_01C20BEF.DD22F460
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Jan Benedict Glaw wrote:
[ ... ]
> > PS: Anybody want's the patches???
> 
> /me

OK, I attached the patches:
a small part is from: Anton Blanchard;
a big part from: Ivan Kokshaysky
a small part from: me...

And I took an idea from: "davidm@napali.hpl.hp.com" (See the
2.5.20 Changelog)

-Oliver

------=_NextPart_000_0029_01C20BEF.DD22F460
Content-Type: application/octet-stream;
	name="kernel-2.5.20.alpha.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel-2.5.20.alpha.patch"

diff -r -C2 tarballs/linux-2.5.20/arch/alpha/kernel/osf_sys.c =
linux-2.5.20/arch/alpha/kernel/osf_sys.c=0A=
*** tarballs/linux-2.5.20/arch/alpha/kernel/osf_sys.c	Mon Jun  3 =
03:44:37 2002=0A=
--- linux-2.5.20/arch/alpha/kernel/osf_sys.c	Tue Jun  4 11:19:48 2002=0A=
***************=0A=
*** 34,37 ****=0A=
--- 34,38 ----=0A=
  #include <linux/types.h>=0A=
  #include <linux/ipc.h>=0A=
+ #include <linux/namei.h>=0A=
  =0A=
  #include <asm/fpu.h>=0A=
diff -r -C2 tarballs/linux-2.5.20/arch/alpha/kernel/pci.c =
linux-2.5.20/arch/alpha/kernel/pci.c=0A=
*** tarballs/linux-2.5.20/arch/alpha/kernel/pci.c	Mon Jun  3 03:44:41 =
2002=0A=
--- linux-2.5.20/arch/alpha/kernel/pci.c	Tue Jun  4 11:19:48 2002=0A=
***************=0A=
*** 191,200 ****=0A=
  #undef GB=0A=
  =0A=
! static void __init=0A=
  pcibios_init(void)=0A=
  {=0A=
! 	if (!alpha_mv.init_pci)=0A=
! 		return;=0A=
! 	alpha_mv.init_pci();=0A=
  }=0A=
  =0A=
--- 191,200 ----=0A=
  #undef GB=0A=
  =0A=
! static int __init=0A=
  pcibios_init(void)=0A=
  {=0A=
! 	if (alpha_mv.init_pci)=0A=
! 		alpha_mv.init_pci();=0A=
! 	return 0;=0A=
  }=0A=
  =0A=
diff -r -C2 tarballs/linux-2.5.20/arch/alpha/kernel/signal.c =
linux-2.5.20/arch/alpha/kernel/signal.c=0A=
*** tarballs/linux-2.5.20/arch/alpha/kernel/signal.c	Mon Jun  3 03:44:49 =
2002=0A=
--- linux-2.5.20/arch/alpha/kernel/signal.c	Tue Jun  4 11:19:48 2002=0A=
***************=0A=
*** 19,22 ****=0A=
--- 19,23 ----=0A=
  #include <linux/stddef.h>=0A=
  #include <linux/tty.h>=0A=
+ #include <linux/binfmts.h>=0A=
  =0A=
  #include <asm/bitops.h>=0A=
diff -r -C2 tarballs/linux-2.5.20/drivers/pci/pci-driver.c =
linux-2.5.20/drivers/pci/pci-driver.c=0A=
*** tarballs/linux-2.5.20/drivers/pci/pci-driver.c	Mon Jun  3 03:44:51 =
2002=0A=
--- linux-2.5.20/drivers/pci/pci-driver.c	Tue Jun  4 16:46:39 2002=0A=
***************=0A=
*** 193,197 ****=0A=
  }=0A=
  =0A=
! subsys_initcall(pci_driver_init);=0A=
  =0A=
  EXPORT_SYMBOL(pci_match_device);=0A=
--- 193,197 ----=0A=
  }=0A=
  =0A=
! arch_initcall(pci_driver_init);=0A=
  =0A=
  EXPORT_SYMBOL(pci_match_device);=0A=
diff -r -C2 tarballs/linux-2.5.20/fs/mpage.c linux-2.5.20/fs/mpage.c=0A=
*** tarballs/linux-2.5.20/fs/mpage.c	Mon Jun  3 03:44:44 2002=0A=
--- linux-2.5.20/fs/mpage.c	Tue Jun  4 14:30:34 2002=0A=
***************=0A=
*** 13,16 ****=0A=
--- 13,17 ----=0A=
  #include <linux/kernel.h>=0A=
  #include <linux/module.h>=0A=
+ #include <linux/kdev_t.h>=0A=
  #include <linux/bio.h>=0A=
  #include <linux/fs.h>=0A=
diff -r -C2 tarballs/linux-2.5.20/include/asm-alpha/bitops.h =
linux-2.5.20/include/asm-alpha/bitops.h=0A=
*** tarballs/linux-2.5.20/include/asm-alpha/bitops.h	Mon Jun  3 03:44:49 =
2002=0A=
--- linux-2.5.20/include/asm-alpha/bitops.h	Tue Jun  4 11:19:49 2002=0A=
***************=0A=
*** 316,319 ****=0A=
--- 316,333 ----=0A=
  }=0A=
  =0A=
+ /*=0A=
+  * fls: find last bit set.=0A=
+  */=0A=
+ #if defined(__alpha_cix__) && defined(__alpha_fix__)=0A=
+ static inline int fls(int word)=0A=
+ {=0A=
+ 	long result;=0A=
+ 	__asm__("ctlz %1,%0" : "=3Dr"(result) : "r"(word & 0xffffffff));=0A=
+ 	return 64 - result;=0A=
+ }=0A=
+ #else=0A=
+ #define fls	generic_fls=0A=
+ #endif=0A=
+ =0A=
  /* Compute powers of two for the given integer.  */=0A=
  static inline int floor_log2(unsigned long word)=0A=
diff -r -C2 tarballs/linux-2.5.20/include/asm-alpha/mc146818rtc.h =
linux-2.5.20/include/asm-alpha/mc146818rtc.h=0A=
*** tarballs/linux-2.5.20/include/asm-alpha/mc146818rtc.h	Mon Jun  3 =
03:44:39 2002=0A=
--- linux-2.5.20/include/asm-alpha/mc146818rtc.h	Tue Jun  4 12:39:46 2002=0A=
***************=0A=
*** 25,27 ****=0A=
--- 25,29 ----=0A=
  })=0A=
  =0A=
+ #define RTC_IRQ 8=0A=
+ =0A=
  #endif /* __ASM_ALPHA_MC146818RTC_H */=0A=
diff -r -C2 tarballs/linux-2.5.20/include/asm-alpha/page.h =
linux-2.5.20/include/asm-alpha/page.h=0A=
*** tarballs/linux-2.5.20/include/asm-alpha/page.h	Mon Jun  3 03:44:52 =
2002=0A=
--- linux-2.5.20/include/asm-alpha/page.h	Tue Jun  4 12:07:23 2002=0A=
***************=0A=
*** 16,23 ****=0A=
  =0A=
  extern void clear_page(void *page);=0A=
! #define clear_user_page(page, vaddr)	clear_page(page)=0A=
  =0A=
  extern void copy_page(void * _to, void * _from);=0A=
! #define copy_user_page(to, from, vaddr)	copy_page(to, from)=0A=
  =0A=
  #ifdef STRICT_MM_TYPECHECKS=0A=
--- 16,23 ----=0A=
  =0A=
  extern void clear_page(void *page);=0A=
! #define clear_user_page(page, vaddr, pg)	clear_page(page)=0A=
  =0A=
  extern void copy_page(void * _to, void * _from);=0A=
! #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)=0A=
  =0A=
  #ifdef STRICT_MM_TYPECHECKS=0A=
***************=0A=
*** 96,101 ****=0A=
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))=0A=
  #ifndef CONFIG_DISCONTIGMEM=0A=
! #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))=0A=
! #define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)=0A=
  #endif /* CONFIG_DISCONTIGMEM */=0A=
  =0A=
--- 96,105 ----=0A=
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))=0A=
  #ifndef CONFIG_DISCONTIGMEM=0A=
! #define pfn_to_page(pfn)	(mem_map + (pfn))=0A=
! #define page_to_pfn(page)	((unsigned long)((page) - mem_map))=0A=
! #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)=0A=
! =0A=
! #define pfn_valid(pfn)		((pfn) < max_mapnr)=0A=
! #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)=0A=
  #endif /* CONFIG_DISCONTIGMEM */=0A=
  =0A=
diff -r -C2 tarballs/linux-2.5.20/include/asm-alpha/pgtable.h =
linux-2.5.20/include/asm-alpha/pgtable.h=0A=
*** tarballs/linux-2.5.20/include/asm-alpha/pgtable.h	Mon Jun  3 =
03:44:45 2002=0A=
--- linux-2.5.20/include/asm-alpha/pgtable.h	Tue Jun  4 12:10:18 2002=0A=
***************=0A=
*** 180,188 ****=0A=
  #if defined(CONFIG_ALPHA_GENERIC) || \=0A=
      (defined(CONFIG_ALPHA_EV6) && !defined(USE_48_BIT_KSEG))=0A=
! #define PHYS_TWIDDLE(phys) \=0A=
!   ((((phys) & 0xc0000000000UL) =3D=3D 0x40000000000UL) \=0A=
!   ? ((phys) ^=3D 0xc0000000000UL) : (phys))=0A=
  #else=0A=
! #define PHYS_TWIDDLE(phys) (phys)=0A=
  #endif=0A=
  =0A=
--- 180,189 ----=0A=
  #if defined(CONFIG_ALPHA_GENERIC) || \=0A=
      (defined(CONFIG_ALPHA_EV6) && !defined(USE_48_BIT_KSEG))=0A=
! #define KSEG_PFN	(0xc0000000000UL >> PAGE_SHIFT)=0A=
! #define PHYS_TWIDDLE(pfn) \=0A=
!   ((((pfn) & KSEG_PFN) =3D=3D (0x40000000000UL >> PAGE_SHIFT)) \=0A=
!   ? ((pfn) ^=3D KSEG_PFN) : (pfn))=0A=
  #else=0A=
! #define PHYS_TWIDDLE(pfn) (pfn)=0A=
  #endif=0A=
  =0A=
***************=0A=
*** 200,209 ****=0A=
  =0A=
  #ifndef CONFIG_DISCONTIGMEM=0A=
  #define mk_pte(page, pgprot)						\=0A=
  ({									\=0A=
  	pte_t pte;							\=0A=
  									\=0A=
! 	pte_val(pte) =3D ((unsigned long)(page - mem_map) << 32) |	\=0A=
! 		       pgprot_val(pgprot);				\=0A=
  	pte;								\=0A=
  })=0A=
--- 201,211 ----=0A=
  =0A=
  #ifndef CONFIG_DISCONTIGMEM=0A=
+ #define pte_pfn(pte)	(pte_val(pte) >> 32)=0A=
+ #define pte_page(pte)	pfn_to_page(pte_pfn(pte))=0A=
  #define mk_pte(page, pgprot)						\=0A=
  ({									\=0A=
  	pte_t pte;							\=0A=
  									\=0A=
! 	pte_val(pte) =3D (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\=0A=
  	pte;								\=0A=
  })=0A=
***************=0A=
*** 220,227 ****=0A=
  	pte;									\=0A=
  })=0A=
  #endif=0A=
  =0A=
! extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t =
pgprot)=0A=
! { pte_t pte; pte_val(pte) =3D (PHYS_TWIDDLE(physpage) << =
(32-PAGE_SHIFT)) | pgprot_val(pgprot); return pte; }=0A=
  =0A=
  extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)=0A=
--- 222,239 ----=0A=
  	pte;									\=0A=
  })=0A=
+ #define pte_page(x)							\=0A=
+ ({									\=0A=
+ 	unsigned long kvirt;						\=0A=
+ 	struct page * __xx;						\=0A=
+ 									\=0A=
+ 	kvirt =3D (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\=0A=
+ 	__xx =3D virt_to_page(kvirt);					\=0A=
+ 									\=0A=
+ 	__xx;								\=0A=
+ })=0A=
  #endif=0A=
  =0A=
! extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)=0A=
! { pte_t pte; pte_val(pte) =3D (PHYS_TWIDDLE(physpfn) << 32) | =
pgprot_val(pgprot); return pte; }=0A=
  =0A=
  extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)=0A=
***************=0A=
*** 234,251 ****=0A=
  { pgd_val(*pgdp) =3D _PAGE_TABLE | ((((unsigned long) pmdp) - =
PAGE_OFFSET) << (32-PAGE_SHIFT)); }=0A=
  =0A=
- #ifndef CONFIG_DISCONTIGMEM=0A=
- #define pte_page(x)	(mem_map+(unsigned long)((pte_val(x) >> 32)))=0A=
- #else=0A=
- #define pte_page(x)							\=0A=
- ({									\=0A=
- 	unsigned long kvirt;						\=0A=
- 	struct page * __xx;						\=0A=
- 									\=0A=
- 	kvirt =3D (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\=0A=
- 	__xx =3D virt_to_page(kvirt);					\=0A=
- 									\=0A=
- 	__xx;								\=0A=
- })=0A=
- #endif=0A=
  =0A=
  extern inline unsigned long=0A=
--- 246,249 ----=0A=
diff -r -C2 tarballs/linux-2.5.20/include/asm-alpha/tlb.h =
linux-2.5.20/include/asm-alpha/tlb.h=0A=
*** tarballs/linux-2.5.20/include/asm-alpha/tlb.h	Mon Jun  3 03:44:48 =
2002=0A=
--- linux-2.5.20/include/asm-alpha/tlb.h	Tue Jun  4 11:19:48 2002=0A=
***************=0A=
*** 1 ****=0A=
--- 1,15 ----=0A=
+ #ifndef _ALPHA_TLB_H=0A=
+ #define _ALPHA_TLB_H=0A=
+ =0A=
+ #define tlb_start_vma(tlb, vma)			do { } while (0)=0A=
+ #define tlb_end_vma(tlb, vma)			do { } while (0)=0A=
+ #define tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)=0A=
+ =0A=
+ #define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)=0A=
+ =0A=
  #include <asm-generic/tlb.h>=0A=
+ =0A=
+ #define pte_free_tlb(tlb,pte)			pte_free(pte)=0A=
+ #define pmd_free_tlb(tlb,pmd)			pmd_free(pmd)=0A=
+  =0A=
+ #endif=0A=
diff -r -C2 tarballs/linux-2.5.20/include/linux/bio.h =
linux-2.5.20/include/linux/bio.h=0A=
*** tarballs/linux-2.5.20/include/linux/bio.h	Mon Jun  3 03:44:52 2002=0A=
--- linux-2.5.20/include/linux/bio.h	Tue Jun  4 12:56:40 2002=0A=
***************=0A=
*** 129,134 ****=0A=
   * will die=0A=
   */=0A=
! #define bio_to_phys(bio)	(page_to_phys(bio_page((bio))) + (unsigned =
long) bio_offset((bio)))=0A=
! #define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (unsigned =
long) (bv)->bv_offset)=0A=
  =0A=
  /*=0A=
--- 129,134 ----=0A=
   * will die=0A=
   */=0A=
! #define bio_to_phys(bio)	((page_to_pfn(bio_page((bio))) << PAGE_SHIFT) =
+ (unsigned long) bio_offset((bio)))=0A=
! #define bvec_to_phys(bv)	((page_to_pfn((bv)->bv_page) << PAGE_SHIFT) + =
(unsigned long) (bv)->bv_offset)=0A=
  =0A=
  /*=0A=

------=_NextPart_000_0029_01C20BEF.DD22F460--


