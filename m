Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbWJ3Jex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbWJ3Jex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWJ3Jex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:34:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:25405 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030527AbWJ3Jew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HC+qt1WRfbq1SK7YBKjgnQGrfuXQct8Nb1P841FBEM1ZXcJV9vDSOHbYEtMBGfUjBIsYPiWsex7tPoTIbM1HvR654mX2zIR0C1Ok83Qj5bw9UeG1r2aM3vwucaTj0Sqkyb1Otn22pm6apg83QKF0KqZKjt77HIQF8sjUX0Leeu4=
Message-ID: <4545C756.30403@innova-card.com>
Date: Mon, 30 Oct 2006 10:35:18 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Miguel Ojeda Sandonis <maxextreme@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
References: <20061026174858.b7c5eab1.maxextreme@gmail.com> <20061026220703.37182521.akpm@osdl.org>
In-Reply-To: <20061026220703.37182521.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Andrew Morton wrote:
> On Thu, 26 Oct 2006 17:48:58 +0000
> Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
> 
[snip]
> 
>> +struct page *cfag12864bfb_vma_nopage(struct vm_area_struct *vma,
>> +	unsigned long address, int *type)
> 
> This function can have static scope.
> 
>> +{
>> +	struct page *page;
>> +	down(&cfag12864bfb_sem);
>> +
>> +	page = virt_to_page(cfag12864b_buffer);
>> +	get_page(page);
>> +
>> +	if(type)
>> +		*type = VM_FAULT_MINOR;
>> +
>> +	up(&cfag12864bfb_sem);
>> +	return page;
>> +}
> 

Any idea why LDD3 states:

	An interesting limitation of remap_pfn_range is that it gives
	access only to reserved pages and physical addresses above the
	top of physical memory.

Is that true we can't do:

	buf = (char *)__get_free_page(...);
	pfn = PFN_DOWN(virt_to_phys(buf));
	remap_pfn_range(vma, vma->vm_start, pfn, PAGE_SIZE, vma->vm_page_prot);

Thanks
		Franck
