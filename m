Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbUDFNLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUDFNLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:11:48 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:44203 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263808AbUDFNLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:11:47 -0400
Date: Tue, 06 Apr 2004 22:11:56 +0900 (JST)
Message-Id: <20040406.221156.124921543.taka@valinux.co.jp>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [patch 4/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406140224.B23527@flint.arm.linux.org.uk>
References: <20040406.214123.129013798.taka@valinux.co.jp>
	<20040406.214801.127823252.taka@valinux.co.jp>
	<20040406140224.B23527@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > @@ -1667,6 +1670,7 @@ int handle_mm_fault(struct mm_struct *mm
> >  pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
> >  {
> >  	pmd_t *new;
> > +	struct page *page;
> >  
> >  	spin_unlock(&mm->page_table_lock);
> >  	new = pmd_alloc_one(mm, address);
> > @@ -1682,6 +1686,8 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
> >  		pmd_free(new);
> >  		goto out;
> >  	}
> > +	page = virt_to_page(new);
> > +	pmd_add_rmap(new, mm, address);
> 
> Doesn't this want to be:
> 
> 	pmd_add_rmap(page, mm, address);
> 
> ?
> 
> And how about collapsing this down to:
> 
> 	pmd_add_rmap(virt_to_page(new), mm, address);

Yes, it can be. I'll fix it. 

But I guess these code would be replaced with objrmap in no distant
future.

Thank you,
Hirokazu Takahashi.
