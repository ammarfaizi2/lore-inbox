Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSGXGJI>; Wed, 24 Jul 2002 02:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSGXGJI>; Wed, 24 Jul 2002 02:09:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:52942 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S316864AbSGXGJH>; Wed, 24 Jul 2002 02:09:07 -0400
X-KENId: 00006EB8KEN001A4C06
X-KENRelayed: 00006EB8KEN001A4C06@PCDR800
Date: Wed, 24 Jul 2002 08:11:11 +0200
From: "Christoph Baumann" <cb@sorcus.com>
Subject: Resolving physical addresses (change in 2.4.x?)
To: <linux-kernel@vger.kernel.org>
Reply-To: "Christoph Baumann" <cb@sorcus.com>
Message-Id: <010f01c232d8$e9b56860$2b65a8c0@Mitarb>
Mime-Version: 1.0
Content-Type: text/plain;
   charset="iso-8859-1"
X-Priority: 3
Organization: SORCUS Computer GmbH
Content-Transfer-Encoding: 7bit
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with a 2.2.19 kernel I used the routine below to resolve physical addresses
for preparing gather/scatter DMA. Using it on unmapped memory (allocated but
not yet used) it returned zero. Knowing this I could force the mapping of
such memory. Now with 2.4.x kernels I get something like 0x100000 for
unmapped pages.
Even recognizing these as unmapped and resolving anew, produced a frozen
machine once the DMA used these addresses. Was there a change in 2.4.x so
that my resolving routine now works incorrect?

/*resolve virt. addresses to phys.*/
unsigned long ch_get_physpage(unsigned long virtaddr)
{
  /*Stuff for browsing through the memory page tables*/
  pgd_t *pgd_t_dir;
  pmd_t *pmd_t_dir;
  pte_t *pte_t_dir;

  /*Get physical address*/
  pgd_t_dir=pgd_offset(current->mm,virtaddr);
  pmd_t_dir=pmd_offset(pgd_t_dir,virtaddr);
  pte_t_dir=pte_offset(pmd_t_dir,virtaddr);
  return virt_to_bus((void *)pte_page(*pte_t_dir));
}


Mit freundlichen Gruessen / Best regards
Dipl.-Phys. Christoph Baumann
---
SORCUS Computer GmbH
Im Breitspiel 11 c
D-69126 Heidelberg

Tel.: +49(0)6221/3206-0
Fax: +49(0)6221/3206-66

