Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUAVHAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUAVHAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:00:53 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:53973 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264411AbUAVHAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:00:51 -0500
Message-ID: <400F751D.1040308@cyberone.com.au>
Date: Thu, 22 Jan 2004 18:00:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: markw@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: DBT-2 anticipatory scheduler and filesystem results with 2.6.1
References: <200401211623.i0LGNHo04546@mail.osdl.org>
In-Reply-To: <200401211623.i0LGNHo04546@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



markw@osdl.org wrote:

>On 19 Jan, Andrew Morton wrote:
>
>>markw@osdl.org wrote:
>>
>>> I ran some dbt-2 tests against 5 filesystems with 2.6.1-mm4 and 2.6.1. I
>>> see a degradation from 0 to 7% in throughput. 
>>>
>>-mm4 also had readahead changes which will adversely impact database-style
>>workloads.  I'd suggest that you revert
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/readahead-revert-lazy-readahead.patch
>>
>>and retest.
>>
>>We reverted lazy readahead because it broke NFS linear reads and was doing
>>the wrong thing anyway.  We need to come up with something else for
>>database-style workloads.
>>
>
>Ok, ran through a set of tests a -R of the
>readahead-revert-lazy-readahead.patch.  Saw a significant improvement
>with xfs, but the other file systems appeared to improve only marginally
>compared to 2.6.1-mm4 with that patch.
>
>Here's a summary compared to 2.6.1:
>
>		% throughput change from 2.6.1 to 2.6.1-mm4 -R readahead
>ext2		-4.9
>ext3		-4.3
>jfs		-5.1
>reiserfs	-3.8
>xfs		14.8
>
>Here's the summary of the original 2.6.1-mm4 for reference:
>
>		% throughput change from 2.6.1 to 2.6.1-mm4
>ext2		-5.9%
>ext3		-5.1%
>jfs		-7.0%
>reiserfs	-2.2%
>xfs		-0.3%
>

Thanks Mark.
Thats better but still not great. I have a test case from Nigel
Cunningham that performs very badly with AS. I'll try to get
that fixed up first and it might improve your case.

There are other things in mm that might change your results, not
least of which being the new SMP scheduler work.


