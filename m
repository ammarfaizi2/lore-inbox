Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbUK3Sru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUK3Sru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUK3SqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:46:16 -0500
Received: from [194.90.79.130] ([194.90.79.130]:26891 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262257AbUK3So2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:44:28 -0500
Message-ID: <41ACBF87.4040206@argo.co.il>
Date: Tue, 30 Nov 2004 20:44:23 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2004 18:44:26.0965 (UTC) FILETIME=[9E5C6050:01C4D70C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:

>>http://lkml.org/lkml/2004/7/26/68
>>
>>discusses a userspace filesystem (implemented as a userspace nfs server 
>>mounted on a loopback nfs mount), the problem, a solution (exactly your 
>>suggestion), and a more generic solution.
>>    
>>
>
>Thanks for the pointer, very interesting read.
>
>However, I don't like the idea that the userspace filesystem must
>cooperate with the kernel in this regard.  With this you lose one of
>the advantages of doing filesystem in userspace: namely that you can
>be sure, that anything you do cannot bring the system down.
>  
>
I don't like it either.

>And I firmly believe that this can be done without having to special
>case filesystem serving processes.
>  
>
I firmly believe the opposite. When a userspace process calls the kernel 
which (directly or indirectly) calls the userspace filesystem, the 
filesystem must have elevated priviledges, or it can deadlock when 
calling back in.

>There are already "strange" filesystems in the kernel which cannot
>really get rid of dirty data.  I'm thinking of tmpfs and ramfs.
>Neither of them are prone to deadlock, though both of them are "worse
>off" than a userspace filesystem, in the sense that they have not even
>the remotest chance of getting rid of the dirty data.
>
>  
>
As others have mentioned, they are limited in the number of pages they 
are allowed to dirty.

>Of course, implementing this is probably not trivial.  But I don't see
>it as a theoretical problem as Linus does. 
>
>  
>
I don't see a theoretical problem, just some practical ones.

All can be overcome IMO, and it would be well worth it, too.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

