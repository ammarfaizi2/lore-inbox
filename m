Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUGZEGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUGZEGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 00:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUGZEGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 00:06:07 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:37255 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264853AbUGZEGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 00:06:04 -0400
Message-ID: <41048324.8070302@yahoo.com.au>
Date: Mon, 26 Jul 2004 14:05:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] consolidate sched domains
References: <41008386.9060009@yahoo.com.au> <20040723153022.GA16563@sgi.com> <200407231450.47070.suresh.b.siddha@intel.com> <20040726022202.GA21602@sgi.com>
In-Reply-To: <20040726022202.GA21602@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich wrote:

>On Fri, Jul 23, 2004 at 02:50:46PM -0700, Siddha, Suresh B wrote:
>
>>On Friday 23 July 2004 08:30, Dimitri Sivanich wrote:
>>
>>>Do other architectures need to define their own cpu_sibling_maps, or am I
>>>missing something that would define that for IA64 and others?
>>>
>>Nick means, all the architectures which use CONFIG_SCHED_SMT needs to define 
>>cpu_sibling_map.
>>
>>Nick, aren't you missing the attached fix in your patch?
>>
>>thanks,
>>suresh
>>
>
>Ok, but cpu_to_phys_group() does a lookup in cpu_sibling map:
>__init static int cpu_to_phys_group(int cpu)
>{
>        return first_cpu(cpu_sibling_map[cpu]);
>}
>
>and is called from outside of a CONFIG_SCHED_SMT ifdef here:
>

Yes of course, thank you.

The fix is for cpu_to_phys_group() to just return cpu when 
!CONFIG_SCHED_SMT.


