Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVAKU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVAKU7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVAKU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:59:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56049 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262691AbVAKU73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:59:29 -0500
Message-ID: <41E43E26.2060303@mvista.com>
Date: Tue, 11 Jan 2005 12:59:18 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>
CC: Andi Kleen <ak@muc.de>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com> <41DC34EF.7010507@mvista.com> <41E3F2DA.5030900@sgi.com> <41E42268.5090404@mvista.com> <41E4295F.1010909@sgi.com>
In-Reply-To: <41E4295F.1010909@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

> Steve Longerbeam wrote:
>
>
>>
>> isn't this already taken care of? read_swap_cache_async() is given
>> a vma, and passes it to alloc_page_vma(). So if you have earlier
>> changed the policy for that vma, the new policy will be used
>> when allocating the page during the swap in.
>>
>> Steve
>>
>
> What if the policy associated with a vma is the default policy?


then read_swap_cache_async() would probably allocate pages for
the swap readin from the wrong nodes, but then migrate_process_pages
would move those to the correct nodes later. But if migrate_process_pages
is called *before* swap readin, the policies will be changed and
read_swap_cache_async() would allocate from the correct nodes.

Maybe I'm missing something, but let me rephrase my argument.
If read_swap_cache_async() is called *before* the vma policies are
changed, they will most likely be allocated from the wrong nodes but
will then be migrated to the correct nodes during the
policy-change-and-page-migrate syscall, and if the swap readin happens
*after* the syscall, the page allocations will use the new policies.

Steve



