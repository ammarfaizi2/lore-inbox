Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUIFVSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUIFVSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUIFVSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:18:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10447 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266845AbUIFVSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:18:16 -0400
Message-ID: <413CD4FF.8070408@sgi.com>
Date: Mon, 06 Sep 2004 16:22:07 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com, kernel@kolivas.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <20040906131027.227b99ac.akpm@osdl.org>
In-Reply-To: <20040906131027.227b99ac.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

> 
> That being said, your tests are interesting.  There's a wide spread of
> results across different kernel versions and across different swappiness
> settings.  But the question is: which behaviour is correct for your users,
> and why?
> 

Andrew,

Behavior more like that of 2.6.5 and 2.6.6 is what we would like to see, I 
think.  We have had problems in the past with a single large HPC application 
that runs for a long time then wants to push its data out quickly.  What 
happens to us in 2.4.21 is that the page cache pages swap out the user pages, 
and that is somethine we would like to avoid, since it can reduce the data
rate significantly.

We were planning on suggesting that such users set swappiness=0 to give
user pages priority over the page cache pages.  But it doesn't look like that 
works very well in the more recent kernels.

One (perhaps) desirable feature would be for intermediate values of swappiness 
to have behavior in between the two extremes (mapped pages have higher 
priority vs page cache pages having priority over unreferenced mapped pages),
so that one would have finer grain control over the amount of swap used.  I'm 
not sure how to achieve such a goal, however.  :-)

On a separate issue, the response to my proposal for a mempolicy to control
allocation of page cache pages has been <ahem> underwhelming.

(See: http://marc.theaimsgroup.com/?l=linux-mm&m=109416852113561&w=2
  and  http://marc.theaimsgroup.com/?l=linux-mm&m=109416852416997&w=2 )

I wonder if this is because I just posted it to linux-mm or its not fleshed 
out enough yet to be interesting?

Thanks,
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

