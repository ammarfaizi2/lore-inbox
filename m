Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUGWAdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUGWAdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 20:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266861AbUGWAdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 20:33:53 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:56487 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266798AbUGWAdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 20:33:51 -0400
Message-ID: <41005CE6.7040803@yahoo.com.au>
Date: Fri, 23 Jul 2004 10:33:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <nathanl@austin.ibm.com>
CC: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched domains bringup race?
References: <1089944026.32312.47.camel@nighthawk>	 <20040718134559.A25488@unix-os.sc.intel.com>	 <40FB78D5.1070604@yahoo.com.au> <1090533339.3041.13.camel@booger>
In-Reply-To: <1090533339.3041.13.camel@booger>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:

>On Mon, 2004-07-19 at 02:31, Nick Piggin wrote:
>
>>Keshavamurthy Anil S wrote:
>>
>>>Even on my system which is Intel 865 chipset (P4 with HT enabled system) 
>>>I see a bug check somewhere in the schedular_tick during boot.
>>>However if I move the sched_init_smp() after do_basic_setup() the
>>>kernel boots without any problem. Any clue here?
>>>
>>There shouldn't be any problem doing that if we have to, obviously we
>>need to know why. Is it possible that cpu_sibling_map, or one of the
>>CPU masks isn't set up correctly at the time of the call?
>>
>
>In 2.6.8-rc1-mm1 at least, backing this patch out fixed it for me on
>ppc64:
>
>http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/broken-out/detect-too-early-schedule-attempts.patch
>
>Code with statements of the form:
>
>if (system_state == SYSTEM_BOOTING)
>	/* do something boot-specific */
>else
>	/* do something assuming system_state == SYSTEM_RUNNING */
>
>is broken by this change.  Parts of the cpu bringup code in arch/ppc64
>do this (and thus need to be fixed if the above change is kept). 
>Chances are there is similar code in some x86 setups.
>
>

That patch can be dropped AFAIKS.

sched-clean-init-idle.patch introduces a better check.


