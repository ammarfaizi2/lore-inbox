Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVLIRuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVLIRuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVLIRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:50:09 -0500
Received: from smtpout.mac.com ([17.250.248.87]:52715 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964827AbVLIRuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:50:07 -0500
In-Reply-To: <1134147943.25408.36.camel@localhost.localdomain>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]> <1134147943.25408.36.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1125CAFD-A7C2-4F8A-9CBB-82D7EC7D51B8@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix coding style
Date: Fri, 9 Dec 2005 11:50:01 -0600
To: Adam Litke <agl@us.ibm.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 9, 2005, at 11:05 AM, Adam Litke wrote:

> On Fri, 2005-12-09 at 10:39 -0600, Mark Rustad wrote:
>> This patch makes the function make_huge_pte non-static, so it can  
>> be used
>> by drivers that want to mmap huge pages. Consequently, a prototype  
>> for the
>> function is added to hugetlb.h. Since I was looking here, I  
>> noticed some
>> coding style problems in the function and fix them with this patch.
>>
>> Signed-off-by: Mark Rustad <MRustad@mac.com>
>
> Call me crazy, but I cringe when I think of any old driver directly
> mucking with huge_ptes.  Forgive me if I am missing something, but why
> can't you just call do_mmap with a hugetlbfs file like everyone else?
> Otherwise, the CodingStyle cleanups look alright.

That would be nice, but we need multiple, contiguous huge pages.  
Actually, about 768M worth. Yeah, I guess I'll stipulate that what  
we're doing is pretty crazy, but it works well. I figure if I can  
call alloc_huge_page, I should be able to remap such a page.  
Actually, I would prefer an explicit remap call for this purpose, but  
in doing my own I found that I needed precisely the code that was  
already in make_huge_pte.

I don't have any strong feeling about whether this is accepted or  
not. I just thought that I should share a change that might be useful  
to others.

-- 
Mark Rustad, MRustad@mac.com

