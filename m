Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUCPCdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263318AbUCPC34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:29:56 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:40083 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262927AbUCPC3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:29:32 -0500
Date: Tue, 16 Mar 2004 11:32:09 +0900 (JST)
Message-Id: <20040316.113209.63031370.taka@valinux.co.jp>
To: ak@suse.de
Cc: n-yoshida@pst.fujitsu.com, raybry@sgi.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: Hugetlbpages in very large memory machines.......
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040316015401.GF9931@wotan.suse.de>
References: <20040313.135638.78732994.taka@valinux.co.jp>
	<JP20040316093003.3103921@pst.fujitsu.com>
	<20040316015401.GF9931@wotan.suse.de>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > +   pte = huge_pte_alloc(mm, address);
> > +   set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
> 
> This looks broken. Another CPU could have raced to the same fault
> and already added an PTE here. You have to handle that.
> 
> (my i386 version originally had the same problem)

Yes, you are true.
In the fault handler, we should use find_lock_page() instead of
find_get_page() to find a hugepage associated with the fault address.
After that pte_none(*pte) should be called again to check whether 
some races has happened.

> > +/*      update_mmu_cache(vma, address, *pte); */
> 
> I have not studied low level IA64 VM in detail, but don't you need
> some kind of TLB flush here?
> 
> -Andi


Thank you,
Hirokazu Takahashi.
