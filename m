Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUENDPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUENDPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 23:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUENDPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 23:15:44 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:31071 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264196AbUENDPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 23:15:42 -0400
Message-ID: <40A439DB.70902@yahoo.com.au>
Date: Fri, 14 May 2004 13:15:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, hugh@veritas.com
CC: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
References: <40A42892.5040802@yahoo.com.au> <20040513193328.11479d3e.akpm@osdl.org> <40A43152.4090400@yahoo.com.au> <40A438AC.9020506@yahoo.com.au>
In-Reply-To: <40A438AC.9020506@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Nick Piggin wrote:
> 
>> Andrew Morton wrote:
>>
>>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>
>>>> OK, I made a debug patch to printk and schedule_timeout in this
>>>> race window so I can easily truncate the file. When this happens,
>>>> it turns out that the readpage thinks it is reading a hole and
>>>> fills the page with zeros -> invalid result?
>>>
>>>
>>>
>>>
>>> A zero-filled pagecache page outside i_size is OK.
>>>
>>
>> Yes. But in this case the zero filled page actually gets
>> read by read(2).
>>
>> In any case, I think my patch won't close the race completely.
>>
> 
> This following patch should be right.
> 
> It causes the zeros to not get copied back unless i_size
> gets extended again.
> 

However, it causes the fast path reading off the end of a file
to always go into ->readpage and copy the non-existant page of
zeros. This could be fixed no problem, but I'll shut up and let
others comment in case I'm making a fool of myself :)
