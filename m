Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUEVAXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUEVAXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUEVAE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:28 -0400
Received: from mail.fastclick.com ([205.180.85.17]:53720 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S265067AbUEUXnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:43:00 -0400
Message-ID: <40AE93E0.7060308@fastclick.com>
Date: Fri, 21 May 2004 16:42:24 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it><1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it><1YmMN-4Kh-17@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it> <m3lljld1v1.fsf@averell.firstfloor.org> <93090000.1085171530@flay>
In-Reply-To: <93090000.1085171530@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>"Martin J. Bligh" <mbligh@aracnet.com> writes:
>>
>>
>>>For any given situation, you can come up with a scheduler mod that improves
>>>things. The problem is making something generic that works well in most
>>>cases. 
>>
>>The point behind numa api/numactl is that if the defaults
>>don't work well enough you can tune it by hand to be better.
>>
>>There are some setups which can be significantly improved with some
>>hand tuning, although in many cases the default behaviour is good enough
>>too.
> 
> 
> Oh, I'm not denying it can make things better ... just 90% of the people
> who want to try it would be better off leaving it the hell alone ;-)
> 
> M.
> 

Right now, 5 processes are running taking up a good deal of the CPU 
doing memory-intensive work(cacheing) and I notice that none of the 
processes seem to have CPU affinity.  top shows they execute pseudo 
randomly on the CPU's.


At this point I'd like to decrease the number of processes to 4 and test 
performance with and without setting CPU & memory allocation affinity.

I've read the archives and I'm not sure how to get numactl running, both 
.5 and .6 versions give me:

# numactl --show
No NUMA support available on this system.

despite using kernel 2.6.6.

running numactl under strace gives me:

32144 sched_getaffinity(32144, 16,  { 0 }) = 8
32144 syscall_239(0, 0, 0, 0, 0, 0, 0x401e30, 0x401e30, 0x401e30, 
0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 
0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 
0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 0x401e30, 
0x401e30, 0x401e30) = -1 (errno 38)
32144 fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 53), ...}) = 0
32144 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x2a9556c000
32144 write(1, "No NUMA support available on thi"..., 42) = 42
32144 munmap(0x2a9556c000, 4096)        = 0
32144 exit_group(1)                     = ?


In case someone might have ran into this before.



Thanks,

Brett

