Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbVCKCKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVCKCKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbVCKCKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:10:49 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:38525 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263108AbVCKCI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:08:58 -0500
Message-ID: <42319861.7000805@yahoo.com.au>
Date: Sat, 12 Mar 2005 00:08:49 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: re-inline sched functions
References: <200503110024.j2B0OFg06087@unix-os.sc.intel.com> <20050310163056.64878c24.akpm@osdl.org>
In-Reply-To: <20050310163056.64878c24.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
>>This could be part of the unknown 2% performance regression with
>>db transaction processing benchmark.
>>
>>The four functions in the following patch use to be inline.  They
>>are un-inlined since 2.6.7.
>>
>>We measured that by re-inline them back on 2.6.9, it improves performance
>>for db transaction processing benchmark, +0.2% (on real hardware :-)
>>
>>

Can you also inline requeue_task? No performance gain expected, but
it is just a simple wrapper around a list function.

>>The cost is certainly larger kernel size, cost 928 bytes on x86, and
>>2728 bytes on ia64.  But certainly worth the money for enterprise
>>customer since they improve performance on enterprise workload.
>>
>
>Less that 1k on x86 versus >2k on ia64.  No wonder those things have such
>big caches ;)
>
>
>>...
>>Possible we can introduce them back?
>>
>
>OK by me.
>
>

What happens if you leave task_timeslice out of line? It isn't exactly
huge, but it is called from a handful of places.


