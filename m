Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSHVUkU>; Thu, 22 Aug 2002 16:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHVUkU>; Thu, 22 Aug 2002 16:40:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15316 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316971AbSHVUkT>; Thu, 22 Aug 2002 16:40:19 -0400
Message-ID: <3D654C8F.30400@us.ibm.com>
Date: Thu, 22 Aug 2002 13:41:51 -0700
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
Subject: Re: [Lse-tech] [patch] SImple Topology API v0.3 (1/2)
References: <3D6537D3.3080905@us.ibm.com> <20020822202239.A30036@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file asm/mmzone.h needs to be included in both the CONFIG_DISCONTIGMEM and 
!CONFIG_DISCONTIGMEM cases (at least after my patch).  This just pulls the 
#include out of the #ifdefs.

Cheers!

-Matt

Christoph Hellwig wrote:
> On Thu, Aug 22, 2002 at 12:13:23PM -0700, Matthew Dobson wrote:
> 
>>--- linux-2.5.27-vanilla/include/linux/mmzone.h	Sat Jul 20 12:11:05 2002
>>+++ linux-2.5.27-api/include/linux/mmzone.h	Wed Jul 24 17:33:41 2002
>>@@ -220,15 +20,15 @@
>> #define NODE_MEM_MAP(nid)	mem_map
>> #define MAX_NR_NODES		1
>> 
>>-#else /* !CONFIG_DISCONTIGMEM */
>>-
>>-#include <asm/mmzone.h>
>>+#else /* CONFIG_DISCONTIGMEM */
>> 
>> /* page->zone is currently 8 bits ... */
>> #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
>> 
>> #endif /* !CONFIG_DISCONTIGMEM */
>> 
>>+#include <asm/mmzone.h>
>>+
> 
> 
> What is the exact purpose of this change?
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 


