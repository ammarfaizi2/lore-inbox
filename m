Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319439AbSIGBhm>; Fri, 6 Sep 2002 21:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319440AbSIGBhm>; Fri, 6 Sep 2002 21:37:42 -0400
Received: from dsl-213-023-039-069.arcor-ip.net ([213.23.39.69]:43189 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319439AbSIGBhl>;
	Fri, 6 Sep 2002 21:37:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: <imran.badr@cavium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Calculating kernel logical address ..
Date: Sat, 7 Sep 2002 03:44:53 +0200
X-Mailer: KMail [version 1.3.2]
References: <00d301c25556$4290f5e0$9e10a8c0@IMRANPC>
In-Reply-To: <00d301c25556$4290f5e0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17nUee-0006Lc-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 05:34, Imran Badr wrote:
> if (!pgd_none(*pgd)) {
> 	pmd = pmd_offset(pgd, adr);
> 	if (!pmd_none(*pmd)) {
> 		ptep = pte_offset(pmd, adr);
> 		pte = *ptep;
> 		if(pte_present(pte)) {
> 			kaddr  = (unsigned long) page_address(pte_page(pte));
> 			kaddr |= (adr & (PAGE_SIZE - 1));
> 		}
> 	}
> }
> 
> Will this code always give me correct kernel logical address?
> 
> I will really appreciate any guidance.

It looks good to me.  Note that somebody has added some new voodoo in 2.5
so that page table pages can be in highmem, with the result that the above
code won't work in 2.5, whether or not highmem is configured.

-- 
Daniel
