Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUIISZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUIISZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUIISYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:24:23 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:46201 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266622AbUIISNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:13:32 -0400
Message-ID: <4140997F.1080706@yahoo.com.au>
Date: Fri, 10 Sep 2004 03:57:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.9-rc1-mm4
References: <544180000.1094575502@[10.10.2.4]> <20040907141741.58174cfd.akpm@osdl.org> <564620000.1094740068@[10.10.2.4]>
In-Reply-To: <564620000.1094740068@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>Well, the good news is that it compiles now, and without forcing ACPI on.
>>> Yay!
>>
>>Does it boot?
> 
> 
> Yup. Performance is the same as other -mm's (scheduler changes bring it
> down from mainline quite a bit, but otherwise OK).
> 
> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>                               Elapsed      System        User         CPU
>                 2.6.9-rc1       44.97       98.66      576.77     1501.33
>             2.6.9-rc1-mm1       46.92      107.27      594.10     1493.67
>             2.6.9-rc1-mm2       46.95      107.80      593.65     1493.33
>             2.6.9-rc1-mm4       46.93      108.91      593.19     1495.00
> 

I'm looking into this performance thing a bit now (although I think
Andrew is going to drop nicksched from the next mm).

It doesn't seem to be from lack of timeslice: with the default
timeslice, nicksched gives average timeslices for a make -j vmlinux
roughly the same size as those for the 2.6 scheduler (22ms).

Increasing base_timeslice can get it up to more than 25% (28ms) larger,
but it still isn't as quick.

I suspect it may be unfairness in the 2.6 scheduler improving cache
utilisation. Need to find a way to measure that though :P
