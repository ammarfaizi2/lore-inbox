Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbULORzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbULORzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbULORzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:55:38 -0500
Received: from [194.90.79.130] ([194.90.79.130]:35339 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262420AbULORzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:55:13 -0500
Message-ID: <41C07A7C.1050905@argo.co.il>
Date: Wed, 15 Dec 2004 19:55:08 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il> <E1CZG1J-0004zW-00@dorka.pomaz.szeredi.hu> <41ACFAE7.2050002@argo.co.il> <E1CZHH7-0005Ev-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CZHH7-0005Ev-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2004 17:55:12.0014 (UTC) FILETIME=[3944E2E0:01C4E2CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(with apologies for the long delay)

Miklos Szeredi wrote:

>>If you plan on partitioning system memory into none-fuse and fuse 
>>memory, yes, that could work. but it's horribly inflexible - right now 
>>memory is balanced dynamically according to actual use. 
>>    
>>
>
>No partitioning is needed.  If fuse doesn't consume too much memory
>for dirty data buffers that memory is free to use for other purposes.
>
>But fuse would be limited in the number of pages which it can use for
>dirty buffers exactly to prevent it from causing OOM.
>  
>
yes, that will work. wil need to be extra-careful when one fuse is 
loopback-mounted on another.

I'm concerned that you're duplicating all the accounting done currently, 
and all of the writeback logic that is dependent on the number of dirty 
pages.

an additional concern is a fuse/non-fuse mix - how do you balance them out?

with a single accounting it happens naturally.

>  
>
>>you may also have a hard time with mmap.
>>    
>>
>
>What sort?  You can mmap a 4G file on a machine with 32M memory.  More
>memory can improve performance, of course, but otherwise the amount of
>memory doesn't matter.
>  
>
I'm no mmap expert. but doesn't writing to a mmaped page have to 
increase your dirty counter somehow?

>  
>
>>my proposal (with the per-process allocation thredsholds) only reserves 
>>a small amount of memory to the fuse(s), with the rest allocated 
>>dynamically using the normal kernel policies, with no special 
>>restrictions on fuse.
>>    
>>
>
>Yes, but what you reserve (which may be large for some filesystems) is
>totally unusable memory except in the special case of helping writeout
>in low memory situation, while in my solution the rest of the system
>is not limited only the fuse filesystem.
>
>There's not that much difference between what we are saying, but as I
>said, I detest the thought, that the filesystem process has to be
>special, and I'm prepared to give up some flexibility and performance
>for this.
>  
>
I think this is a good summary.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

