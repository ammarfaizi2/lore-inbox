Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbUK3XBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbUK3XBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUK3W73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:59:29 -0500
Received: from [194.90.79.130] ([194.90.79.130]:63758 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262394AbUK3W5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:57:53 -0500
Message-ID: <41ACFAE7.2050002@argo.co.il>
Date: Wed, 01 Dec 2004 00:57:43 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il> <E1CZG1J-0004zW-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CZG1J-0004zW-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2004 22:57:48.0375 (UTC) FILETIME=[031B7670:01C4D730]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:

>I have observed it too (not yet fixed, but working on it).  But
>realize that my proposal would excempt userspace filesystem pages from
>being blocked on by kswapd.  That's a fundamental difference.
>
>Since you don't believe me, I'll have to make an implementation, so
>you can experiment with it.  And if you'll still be able to cause a
>deadlock, I'll subject myself to extreme repentance, and promise never
>to touch an operating system ever again :)
>
>  
>
>>with ramfs, once it accounts for memory, there would be no deadlock and 
>>no oom.
>>    
>>
>
>And once fuse acounts for memory there will be no deadlock and no oom.
>See the symmetry?
>
>  
>
If you plan on partitioning system memory into none-fuse and fuse 
memory, yes, that could work. but it's horribly inflexible - right now 
memory is balanced dynamically according to actual use. you may also 
have a hard time with mmap.

my proposal (with the per-process allocation thredsholds) only reserves 
a small amount of memory to the fuse(s), with the rest allocated 
dynamically using the normal kernel policies, with no special 
restrictions on fuse.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

