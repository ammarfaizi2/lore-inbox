Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSHVUoF>; Thu, 22 Aug 2002 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSHVUoD>; Thu, 22 Aug 2002 16:44:03 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40410 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317066AbSHVUoC>; Thu, 22 Aug 2002 16:44:02 -0400
Message-ID: <3D654D6F.1050701@us.ibm.com>
Date: Thu, 22 Aug 2002 13:45:35 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Bligh <mjbligh@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [patch] Simple Topology API v0.3 (2/2)
References: <3D65383B.9030406@us.ibm.com> <20020822202412.B30036@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,
	I've had some comments/flames about that...  One of the better suggestions that 
I've heard so far is to change it to a /proc interface.  I'll probably do that 
today and resent the userspace patch.  If you (or anyone) has better 
suggestions, I'm definitely all ears (or eyes, I suppose ;)!

Cheers!

-Matt

Christoph Hellwig wrote:
> On Thu, Aug 22, 2002 at 12:15:07PM -0700, Matthew Dobson wrote:
> 
>>diff -Nur linux-2.5.27-vanilla/kernel/sys.c linux-2.5.27-api/kernel/sys.c
>>--- linux-2.5.27-vanilla/kernel/sys.c	Sat Jul 20 12:11:07 2002
>>+++ linux-2.5.27-api/kernel/sys.c	Wed Jul 24 17:33:41 2002
>>@@ -20,6 +20,7 @@
>> #include <linux/device.h>
>> #include <linux/times.h>
>> #include <linux/security.h>
>>+#include <linux/topology.h>
>> 
>> #include <asm/uaccess.h>
>> #include <asm/io.h>
>>@@ -1236,6 +1237,31 @@
>> 	mask = xchg(&current->fs->umask, mask & S_IRWXUGO);
>> 	return mask;
>> }
>>+
>>+asmlinkage long sys_check_topology(int convert_type, int to_convert)
>>+{
>>+	int ret = 0;
>>+
>>+	switch (convert_type) {
>>+		case CPU_TO_NODE:
>>+			ret = cpu_to_node(to_convert);
>>+			break;
>>+		case MEMBLK_TO_NODE:
>>+			ret = memblk_to_node(to_convert);
>>+			break;
>>+		case NODE_TO_NODE:
>>+			ret = node_to_node(to_convert);
>>+			break;
>>+		case NODE_TO_CPU:
>>+			ret = node_to_cpu(to_convert);
>>+			break;
>>+		case NODE_TO_MEMBLK:
>>+			ret = node_to_memblk(to_convert);
>>+			break;
>>+	}
>>+
>>+	return (long)ret;
>>+}
> 
> 
> You don't consider this a proper syscall API, do you?
> 
> 


