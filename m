Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVGPDvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVGPDvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVGPDvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:51:01 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:42273 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261826AbVGPDu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:50:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FNzmkQch4RQwVBI86YcSiAQpq5/zQoa89Qhu2c6KA5FYa2n5Qz9iiVN9ZK1OVgmoVyzuUmRBrb1o16fALoB8cgg5GE7r0rOhCyiItdixZkveWeF7oaUuWe37RWOHBYK7fqBCV7HVaSEwnkD6XZ8BN2Z4BS0oefe+cc+3LmyZO28=
Message-ID: <42D8841A.6010600@gmail.com>
Date: Sat, 16 Jul 2005 12:50:50 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Daniel McNeil <daniel@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>	 <42D70318.1000304@gmail.com> <42D74724.8000703@us.ibm.com>	 <42D77293.3050900@gmail.com> <1121450079.6755.96.camel@dyn9047017102.beaverton.ibm.com>
In-Reply-To: <1121450079.6755.96.camel@dyn9047017102.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Fri, 2005-07-15 at 17:23 +0900, Tejun Heo wrote:
> 
>>Badari Pulavarty wrote:
> 
> ...
> 
>>>> I don't know why you wanna relax the alignment requirement, but 
>>>>wouldn't it be easier to just write/use block-aligned allocator for 
>>>>such buffers?  It will even make the program more portable.
>>>>
>>>
>>>I can imagine a reason for relaxing the alignment. I keep getting asked
>>>whether we can do "O_DIRECT mount option".  Database folks wants to
>>>make sure all the access to files in a given filesystem are O_DIRECT
>>>(whether they are accessing or some random program like ftp, scp, cp
>>>are acessing them). This was mainly to ensure that buffered accesses to
>>>the file doesn't polute the pagecache (while database is using O_DIRECT
>>>access). Seems like a logical request, but not easy to do :(
>>>
>>>Thanks,
>>>Badari
>>
>>  I don't know much about VM, but, if that's necessary, I think that 
>>limiting pagecache size per mounted fs (or by some other applicable 
>>category) is easier/more complete approach.  After all, you cannot mmap 
>>w/ O_DIRECT and many programs (gcc, ld come to mind) mmap large part of 
>>their memory usage.
> 
> 
> I agree. I guess for mmap()ed access we can kick it back to buffered
> mode.
> 
> I don't think limiting pagecache use per filesystem is an acceptable
> option. In fact, database folks exactly want this -  to limit the
> pagecache use by filesystems - but I don't think its right thing to do,
> so I am trying to propose mount O_DIRECT as an alternative (if its
> feasible).

  Just out of curiosity, can you tell me why you think limiting 
pagecache isn't the right thing to do (tm)?  O_DIRECT mount seems to me 
incomplete/complex solution (DMA alignment etc...).  Forgive me if this 
issue has been discussed to death already.

-- 
tejun
