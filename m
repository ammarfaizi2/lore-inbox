Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbUK3UEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUK3UEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUK3UEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:04:06 -0500
Received: from [194.90.79.130] ([194.90.79.130]:38412 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262288AbUK3Tzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:55:49 -0500
Message-ID: <41ACD03C.9010300@argo.co.il>
Date: Tue, 30 Nov 2004 21:55:40 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2004 19:55:43.0462 (UTC) FILETIME=[935A0860:01C4D716]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:

>>>And I firmly believe that this can be done without having to special
>>>case filesystem serving processes.
>>> 
>>>
>>>      
>>>
>>I firmly believe the opposite. When a userspace process calls the kernel 
>>which (directly or indirectly) calls the userspace filesystem, the 
>>filesystem must have elevated priviledges, or it can deadlock when 
>>calling back in.
>>    
>>
>
>No.
>
>Just by making the filesystem not contribute to the dirty counters
>(like ramfs), the deadlock problem can be solved.  In this case you
>simply could not get a deadlock, because all those dirty pages
>produced by the filesystem look just like normal allocations, which
>simply cannot be touched when the userspace filesystem wants to
>allocate more memory.
>
>In this case the allocation would just fail.  Deadlock doesn't happen,
>though the filesystem wasn't given any elevated privileges.
>
>Of course this isn't a good situation: the memory is filled in with
>dirty data of the filesystem which it cannot write back.  All sorts of
>  
>
you're describing the deadlock here: all memory is full, no process 
which allocates memory can make any progress. This is not a true oom 
situation: there can be plenty of memory in dirty pagecache which we 
could reclaim if we had that tiny bit of reserve memory.

>I looked at ramfs, it isn't even limited.  You can easily crash your
>system just by filling it up with data, but no deadlock will happen.
>  
>
Right. But ramfs doesn't call a userspace process which calls the kernel 
right back.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

