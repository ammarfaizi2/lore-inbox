Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbUJ0XH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUJ0XH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbUJ0XED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:04:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1735 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262782AbUJ0XCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:02:43 -0400
Message-ID: <41802A7F.7020001@sgi.com>
Date: Wed, 27 Oct 2004 18:08:47 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Robin Holt <holt@sgi.com>, Jesse Barnes <jbarnes@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041026022322.GD17038@holomorphy.com> <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com> <Pine.LNX.4.58.0410271103500.18165@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0410271103500.18165@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 26 Oct 2004, Robin Holt wrote:
> 
> 
>>Sorry for being a stickler here, but the BTE is really part of the
>>I/O Interface portion of the shub.  That portion has a seperate clock
>>frequency from the memory controller (unfortunately slower).  The BTE
>>can zero at a slightly slower speed than the processor.  It does, as
>>you pointed out, not trash the CPU cache.
>>
>>One other feature of the BTE is it can operate asynchronously from
>>the cpu.  This could be used to, during a clock interrupt, schedule
>>additional huge page zero filling on multiple nodes at the same time.
>>This could result in a huge speed boost on machines that have multiple
>>memory only nodes.  That has not been tested thoroughly.  We have done
>>considerable testing of the page zero functionality as well as the
>>error handling.
> 
> 
> If the huge patch would support some way of redirecting the clearing of a
> huge page then we could:
> 
> 1. set the huge pte to not present so that we get a fault on access
> 2. run the bte clearer.
> 3. On receiving a huge fault we could check for the bte being finished.
> 
> This would parallelize the clearing of huge pages. But is that really more
> efficient? There may be complexity involved in allowing the clearing of
> multiple pages and tracking of the clear in progress is additional
> overhead.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Another point is that if you zero pages off line from the application,
then depending on how many pre-zeroed pages an application finds, its
execution time may not be repeatable.  I. e. if the system has been idle
a long time, then the BTEs will have zeroed all of the allocated hugetlbpags
and startup will be fast.  But then the next time the application runs, those
pages it used and released will have to be zeroed before it can run.  I think
I would vote for repeatability here rather than using the BTE offline to
zero pages.

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
