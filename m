Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317560AbSGORrM>; Mon, 15 Jul 2002 13:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317561AbSGORrL>; Mon, 15 Jul 2002 13:47:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4001 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317560AbSGORrF>;
	Mon, 15 Jul 2002 13:47:05 -0400
Message-ID: <3D330AEF.3070105@us.ibm.com>
Date: Mon, 15 Jul 2002 10:48:31 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch[ Simple Topology API
References: <3D2F75D7.3060105@us.ibm.com.suse.lists.linux.kernel> <3D2F9521.96D7080B@zip.com.au.suse.lists.linux.kernel> <p73ofdbv1a4.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Andrew Morton <akpm@zip.com.au> writes:
>>AFAIK, the interested parties with this and the memory binding API are
>>ia32-NUMA, ia64, PPC, some MIPS and x86-64-soon.  It would be helpful
>>if the owners of those platforms could review this work and say "yes,
>>this is something we can use and build upon".  Have they done that?
> 
> Comment from the x86-64 side: 
> 
> Current x86-64 NUMA essentially has no 'nodes', just each CPU has
> local memory that is slightly faster than remote memory. This means
> the node number would be always identical to the CPU number. As long
> as the API provides it's ok for me. Just the node concept will not be
> very useful on that platform. memblk will also be identity mapped to
> node/cpu.
> 
> Some way to tell user space about memory affinity seems to be useful,
> but...
That shouldn't be a problem at all.  Since each architecture is responsible for 
defining the 5 main topology functions, you could do this:

#define _cpu_to_node(cpu)	(cpu)
#define _memblk_to_node(memblk)	(memblk)
#define _node_to_node(node)	(node)
#define _node_to_cpu(node)	(node)
#define _node_to_memblk(node)	(node)

> General comment:
> 
> I don't see what the application should do with the memblk concept
> currently. Just knowing about it doesn't seem too useful. 
> Surely it needs some way to allocate memory in a specific memblk to be useful?
> Also doesn't it need to know how much memory is available in each memblk?
> (otherwise I don't see how it could do any useful partitioning)
For that, you need to look at the Memory Binding API that I sent out moments 
after this patch...  It builds on top of this infrastructure to allow binding 
processes to individual memory blocks or groups of memory blocks.

Cheers!

-Matt

> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


