Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUJHV4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUJHV4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUJHV4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:56:53 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:52675 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S265943AbUJHV4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:56:15 -0400
Message-ID: <41670CFC.1020306@bigpond.net.au>
Date: Sat, 09 Oct 2004 07:56:12 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Erich Focht <efocht@hpce.nec.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis> <200410081214.20907.efocht@hpce.nec.com> <41666E90.2000208@yahoo.com.au> <1097261691.5650.23.camel@arrakis>
In-Reply-To: <1097261691.5650.23.camel@arrakis>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> On Fri, 2004-10-08 at 03:40, Nick Piggin wrote:
> 
>>And so you want to make a partition with CPUs {0,1,2,4,5}, and {3,6,7}
>>for some crazy reason, the new domains would look like this:
>>
>>0 1  2  4 5    3  6 7
>>---  -  ---    -  ---  <- 0
>>  |   |   |     |   |
>>  -----   -     -   -   <- 1
>>    |     |     |   |
>>    -------     -----   <- 2 (global, partitioned)
>>
>>Agreed? You don't need to get fancier than that, do you?
>>
>>Then how to input the partitions... you could have a sysfs entry that
>>takes the complete partition info in the form:
>>
>>0,1,2,3 4,5,6 7,8 ...
>>
>>Pretty dumb and simple.
> 
> 
> How do we describe the levels other than the first?  We'd either need
> to:
> 1) come up with a language to describe the full tree.  For your example
> I quoted above:
>    echo "0,1,2,4,5 3,6 7,8;0,1,2 4,5 3 6,7;0,1 2 4,5 3 6,7" > partitions

I think the idea was that the full hierarchy was (automatically) derived 
from the partition in a way that best matched the physical layout of the 
machine?

> 
> 2) have multiple files:
>    echo "0,1,2,4,5 3,6,7" > level2
>    echo "0,1,2 4,5 3 6,7" > level1
>    echo "0,1 2 4,5 3 6,7" > level0
> 
> 3) Or do it hierarchically as Paul implemented in cpusets, and as I
> described in an earlier mail:
>    mkdir level2
>    echo "0,1,2,4,5 3,6,7" > level2/partitions
>    mkdir level1
>    echo "0,1,2 4,5 3 6,7" > level1/partitions
>    mkdir level0
>    echo "0,1 2 4,5 3 6,7" > level0/partitions
> 
> I personally like the hierarchical idea.  Machine topologies tend to
> look tree-like, and every useful sched_domain layout I've ever seen has
> been tree-like.  I think our interface should match that.
> 
> -Matt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
