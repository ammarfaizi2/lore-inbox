Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTJBTXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 15:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJBTXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 15:23:03 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39406 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263356AbTJBTW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 15:22:59 -0400
Message-ID: <3F7C7AA9.2050404@austin.ibm.com>
Date: Thu, 02 Oct 2003 14:21:13 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Minutes from 10/1 LSE Call
References: <37940000.1065035945@w-hlinder> <20031001162916.5fc2241b.akpm@osdl.org>
In-Reply-To: <20031001162916.5fc2241b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hanna Linder <hannal@us.ibm.com> wrote:
>  
>
>>In mainline, once block size is over 32k our throuput actually drops off.
>>It levels off around 128k but at a greater cpu utilization.
>>Dont really understand why that is. 
>>    
>>
>
>Probably thrashing the CPU's L1 cache.
>  
>
>>In mm tree, maintains throughput for all block size but the cpu utilzation
>>keeps going up to do the same throughput.  Readprofile shows the extra time 
>>is being spent in copy_to_user (in mm tree). Backing out readahead patch 
>>reduces cpu by 10% for all block sizes but still shows the spike. So that
>>isnt the main problem.
>>    
>>
>
>If you have a loop like:
>
>	char *buf;
>
>	for (lots) {
>		read(fd, buf, size);
>	}
>
>
>the optimum value of `size' is small: as little as 8k.  Once `size' gets
>close to half the size of the L1 cache you end up pushing the memory at
>`buf' out of CPU cache all the time.
>
>  
>
Sure, but why do I only see this is the mm tree, and not the mainline 
tree. Also, there are 160 threads doing this loop, so even at 32k block 
size the  working set of 'buf's is over 5MB with only a 2MB L2 cache.

Steve

>
>-------------------------------------------------------
>This sf.net email is sponsored by:ThinkGeek
>Welcome to geek heaven.
>http://thinkgeek.com/sf
>_______________________________________________
>Lse-tech mailing list
>Lse-tech@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/lse-tech
>  
>

