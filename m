Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVKLElO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVKLElO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVKLElO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:41:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39808 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751303AbVKLElN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:41:13 -0500
Message-ID: <43757263.2030401@us.ibm.com>
Date: Fri, 11 Nov 2005 20:41:07 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@suse.de, linux-kernel@vger.kernel.org, hugh@veritas.com,
       dvhltc@us.ibm.com, linux-mm@kvack.org, blaisorblade@yahoo.it,
       jdike@addtoit.com
Subject: Re: [PATCH] 2.6.14 patch for supporting madvise(MADV_REMOVE)
References: <1130366995.23729.38.camel@localhost.localdomain>	<20051028034616.GA14511@ccure.user-mode-linux.org>	<43624F82.6080003@us.ibm.com>	<20051028184235.GC8514@ccure.user-mode-linux.org>	<1130544201.23729.167.camel@localhost.localdomain>	<20051029025119.GA14998@ccure.user-mode-linux.org>	<1130788176.24503.19.camel@localhost.localdomain>	<20051101000509.GA11847@ccure.user-mode-linux.org>	<1130894101.24503.64.camel@localhost.localdomain>	<20051102014321.GG24051@opteron.random>	<1130947957.24503.70.camel@localhost.localdomain>	<20051111162511.57ee1af3.akpm@osdl.org>	<1131755660.25354.81.camel@localhost.localdomain> <20051111174309.5d544de4.akpm@osdl.org>
In-Reply-To: <20051111174309.5d544de4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
>>>Why does madvise_remove() have an explicit check for swapper_space?
>>
>>I really don't remember (I yanked code from some other kernel routine
>>vmtruncate()).
> 
> 
> I don't see such a thing anywhere.  vmtruncate() has the IS_SWAPFILE()
> test, which I guess vmtruncate_range() ought to have too, for
> future-safety.

Yep. That was the check. Since I don't have inode and have mapping
handy anyway, check was made using that. I could change it, if you wish.

> 
> Logically, vmtruncate() should just be a special case of vmtruncate_range().
> But it's not - ugly, but hard to do anything about (need to implement
> ->truncate_range in all filesystems, but "know" which ones only support
> ->truncate_range() at eof).
> 
> 
>>>In your testing, how are you determining that the code is successfully
>>>removing the correct number of pages, from the correct file offset?
>>
>>I verified with test programs, added debug printk + looked through live
>>"crash" session + verified with UML testcases.
> 
> 
> OK, well please be sure to test it on 32-bit and 64-bit, operating in three
> ranges of the file: <2G, 2G-4G amd >4G.
> 
Will do.

Thanks,
Badari

