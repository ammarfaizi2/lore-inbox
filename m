Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbUDFNCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUDFNCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:02:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263801AbUDFNC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:02:28 -0400
Date: Tue, 6 Apr 2004 14:02:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [patch 4/6] memory hotplug for hugetlbpages
Message-ID: <20040406140224.B23527@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takahashi <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp> <20040406.214123.129013798.taka@valinux.co.jp> <20040406.214801.127823252.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040406.214801.127823252.taka@valinux.co.jp>; from taka@valinux.co.jp on Tue, Apr 06, 2004 at 09:48:01PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:48:01PM +0900, Hirokazu Takahashi wrote:
> @@ -1667,6 +1670,7 @@ int handle_mm_fault(struct mm_struct *mm
>  pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
>  {
>  	pmd_t *new;
> +	struct page *page;
>  
>  	spin_unlock(&mm->page_table_lock);
>  	new = pmd_alloc_one(mm, address);
> @@ -1682,6 +1686,8 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
>  		pmd_free(new);
>  		goto out;
>  	}
> +	page = virt_to_page(new);
> +	pmd_add_rmap(new, mm, address);

Doesn't this want to be:

	pmd_add_rmap(page, mm, address);

?

And how about collapsing this down to:

	pmd_add_rmap(virt_to_page(new), mm, address);

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
