Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315949AbSEGTW2>; Tue, 7 May 2002 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315950AbSEGTW1>; Tue, 7 May 2002 15:22:27 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:22541 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315949AbSEGTWZ>; Tue, 7 May 2002 15:22:25 -0400
Date: Tue, 7 May 2002 21:22:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
In-Reply-To: <Pine.LNX.4.44.0205051708420.23089-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.21.0205072115360.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Thunder from the hill wrote:

As long as CONFIG_DISCONTIGMEM isn't used the replacement functions are
quite simple.

>  - pfn_to_page(pfn) is declared as (mem_map + (pfn)) for i386. Can this 
>    apply to Sparc64 as well?

Yes.

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

bye, Roman

