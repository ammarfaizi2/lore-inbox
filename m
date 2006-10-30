Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWJ3NxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWJ3NxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWJ3NxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:53:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:3293 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751581AbWJ3NxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:53:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pLjFmyuXMj+0tPhzqB6LisI6YCqtzXh8V2X4hzTOYbeHzaXGJDNOeigSo3HSqcDOAJlZ+TjGxSW5P/YZL6OKtHhVBxv6GmiuoTDZSRflovjBGMfX9MsSrKXSwDRviVYKWYbwjO096Ibw+OSRDkTuDzEKK7vu3snSVKKw6UqeHdU=
Message-ID: <653402b90610300553t405c67e6u69dee3c83c22dae5@mail.gmail.com>
Date: Mon, 30 Oct 2006 14:53:15 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4545C756.30403@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061026174858.b7c5eab1.maxextreme@gmail.com>
	 <20061026220703.37182521.akpm@osdl.org>
	 <4545C756.30403@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Andrew,
>
> Andrew Morton wrote:
> > On Thu, 26 Oct 2006 17:48:58 +0000
> > Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
> >
> [snip]
> >
> >> +struct page *cfag12864bfb_vma_nopage(struct vm_area_struct *vma,
> >> +    unsigned long address, int *type)
> >
> > This function can have static scope.
> >
> >> +{
> >> +    struct page *page;
> >> +    down(&cfag12864bfb_sem);
> >> +
> >> +    page = virt_to_page(cfag12864b_buffer);
> >> +    get_page(page);
> >> +
> >> +    if(type)
> >> +            *type = VM_FAULT_MINOR;
> >> +
> >> +    up(&cfag12864bfb_sem);
> >> +    return page;
> >> +}
> >
>
> Any idea why LDD3 states:
>
>         An interesting limitation of remap_pfn_range is that it gives
>         access only to reserved pages and physical addresses above the
>         top of physical memory.
>
> Is that true we can't do:
>
>         buf = (char *)__get_free_page(...);
>         pfn = PFN_DOWN(virt_to_phys(buf));
>         remap_pfn_range(vma, vma->vm_start, pfn, PAGE_SIZE, vma->vm_page_prot);
>
> Thanks
>                 Franck
>

Again: Please read LDD3. It explains it well. Read all the "Remapping
RAM" chapter and you will understand what I've done, or just try to
remap RAM yourself with remap_pfn_range. (I really tried it using
different ways and I couldn't map it with remap_pfn_range, it returns
you a place full with zeros, as LDD3 states).
