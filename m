Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWHCJsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWHCJsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHCJsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:48:42 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:36613 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932444AbWHCJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:48:41 -0400
Message-ID: <44D1C616.1060305@shadowen.org>
Date: Thu, 03 Aug 2006 10:47:02 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Re : Re : sparsemem usage
References: <20060803090706.99884.qmail@web25813.mail.ukl.yahoo.com>
In-Reply-To: <20060803090706.99884.qmail@web25813.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis wrote:
> Alan Cox wrote:
>> Mapping out parts of a section is quite normal - think about the 640K to
>> 1Mb hole in PC memory space.
> 
> OK. But I'm still worry. Please consider the following code
> 
>        for (...; ...; ...) {
>                 [...]
>                 if (pfn_valid(i))
>                        num_physpages++;
>                 [...]
>         }
> 
> In that case num_physpages won't store an accurate value. Still it will be
> used by the kernel to make some statistic assumptions on other kernel
> data structure sizes.

That would be incorrect usage.  pfn_valid() simply doesn't tell you if 
you have memory backing a pfn, it mearly means you can interrogate the 
page* for it.  A good example of code which counts pages in a region is 
in count_highmem_pages() which has a form as below:

			for (pfn = start; pfn < end; pfn++) {
  				if (!pfn_valid(pfn))
                                         continue;
                                 page = pfn_to_page(pfn);
                                 if (PageReserved(page))
                                         continue;
				num_physpages++;
			}

-apw
