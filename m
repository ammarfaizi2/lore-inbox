Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131403AbRBAXYZ>; Thu, 1 Feb 2001 18:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131950AbRBAXYP>; Thu, 1 Feb 2001 18:24:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131403AbRBAXYF>;
	Thu, 1 Feb 2001 18:24:05 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102012319.f11NJM813793@flint.arm.linux.org.uk>
Subject: Re: obscure bug in vmalloc
To: duanev@interactivesi.com (duane voth)
Date: Thu, 1 Feb 2001 23:19:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A79EC64.2060502@interactivesi.com> from "duane voth" at Feb 01, 2001 05:08:20 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

duane voth writes:
> duane voth wrote:
> > ... I've attached a patch that
> > can be used to watch for the problem.  The following is a 2.2 patch (2.4
> > will follow in a few minutes).  If you see "vmalloc error" you might want
> > to uncomment the look_for_dangling_pgds function to get a better feel for
> > the pgds that cause the probem.
> 
> Here is the 2.4.1 version.

> +int
> +duanev_ensure_pgds_same(unsigned long addr, unsigned long size)
>...
> +       for_each_task(p) {
> +               for (va = addr; va < addr + size; va = (va + PGDIR_SIZE) & PGDIR_MASK) {
> +                       pgd_t kpgd = *pgd_offset_k(va);
> +                       if (pgd_val(*pgd_offset(p->mm, va)) != pgd_val(kpgd)) {
>...

In 2.4 kernels, it is legal for a processes pgds in the vmalloc area to be
different from those of the init task in so much as they may be entries
that will cause a fault.  The page fault handler will then fill in the
pgd entry for us.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
