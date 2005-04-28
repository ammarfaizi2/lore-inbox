Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVD1Btq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVD1Btq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVD1Btp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:49:45 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:29299 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261667AbVD1Btk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:49:40 -0400
Message-ID: <42704130.9050005@yahoo.com.au>
Date: Thu, 28 Apr 2005 11:49:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: update to use the new 4L headers
References: <1114652039.7112.213.camel@gaston>
In-Reply-To: <1114652039.7112.213.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Hi !
> 
> This patch converts ppc64 to use the generic pgtable-nopud.h instead of
> the "fixup" header.
> 

Great! Nice work Ben.

> -
> -static void unmap_im_area_pmd(pgd_t *dir, unsigned long address,
> -				  unsigned long size)
> -{
> -	unsigned long base, end;
> -	pmd_t *pmd;
> -
> -	if (pgd_none(*dir))
> -		return;
> -	if (pgd_bad(*dir)) {
> -		pgd_ERROR(*dir);
> -		pgd_clear(dir);
> -		return;
> -	}
> -
> -	pmd = pmd_offset(dir, address);
> -	base = address & PGDIR_MASK;
> -	address &= ~PGDIR_MASK;
> -	end = address + size;
> -	if (end > PGDIR_SIZE)
> -		end = PGDIR_SIZE;
> -
> -	do {
> -		unmap_im_area_pte(pmd, base + address, end - address);
> -		address = (address + PMD_SIZE) & PMD_MASK;
> -		pmd++;
> -	} while (address < end);
> -}

Just a bit off-topic: I wonder how many more of these open
coded pt walks exist in arch code (yes I see you've cleaned
yours up - good).

I guess they don't matter much? They will probably get
converted when arches convert to the 4L headers.

-- 
SUSE Labs, Novell Inc.

