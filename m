Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315973AbSEGVUc>; Tue, 7 May 2002 17:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSEGVUb>; Tue, 7 May 2002 17:20:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9633 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315973AbSEGVUa>;
	Tue, 7 May 2002 17:20:30 -0400
Date: Tue, 07 May 2002 14:08:48 -0700 (PDT)
Message-Id: <20020507.140848.29493830.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: thunder@ngforever.de, linux-kernel@vger.kernel.org
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0205072115360.32715-100000@serv>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 7 May 2002 21:22:13 +0200 (CEST)

   On Tue, 7 May 2002, Thunder from the hill wrote:
   
   >  - pte_pfn(x) is declared as
   >    ((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
   >    in 2-level pgtable,
   >    (((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
   >    in 3-level. I suppose 2-level shouldn't exactly match here, how far 
   >    must the 3-level version be changed in order to fit sparc64? A lot?
   
   #define pte_pfn(x) (pte_val(x) >> PAGE_SHIFT)
   
   >  - pfn_valid(pfn) is described as ((pfn) < max_mapnr). Suppose this is OK 
   >    on Sparc64 either?
   
   Yes.
   
   >  - pfn_pte(page,prot) is defined as
   >    __pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
   >    How far does this go for Sparc64?
   
   #define pfn_pte(pfn,prot) mk_pte_phys(pfn << PAGE_SHIFT, prot)
   but you should better replace mk_pte_phys completely.

All of this is ignoring the fact that phys_base has to be subtracted
from any physical address before applying as an index to mem_map on
sparc64.

I have the correct fixes for sparc64 in my tree and I'll merge it
all to Linus.
