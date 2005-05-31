Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVEaJJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVEaJJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVEaJJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:09:12 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:45912 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261407AbVEaJIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:08:50 -0400
Message-ID: <429C299E.3030805@yahoo.com.au>
Date: Tue, 31 May 2005 19:08:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: Ashok Raj <ashok.raj@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com>	 <20050531010030.A5239@unix-os.sc.intel.com>	 <1117528509.3957.3.camel@linux-hp.sh.intel.com>	 <429C253E.10004@yahoo.com.au> <1117530667.4025.4.camel@linux-hp.sh.intel.com>
In-Reply-To: <1117530667.4025.4.camel@linux-hp.sh.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:
> On Tue, 2005-05-31 at 18:50 +1000, Nick Piggin wrote:
> 
>>Shaohua Li wrote:
>>
>>
>>>I must be over considering. Ok, how does this updated one look?
>>>
>>>
>>
>>Looks like you've found a race, alright. Nice work!
>>
>>I think it would be preferable to do the check in kernel/fork.c,
>>after the tasklist lock is taken (and you'll need to rediff the
>>patch for the -mm tree).
> 
> It seems there is still a race between copy_process and wake_up_new_task
> to me (cpu offline after copy_process). Am I missing anything?
> 

Offlining the CPU takes the tasklist lock to migrate off tasks.
So either the CPU will be offline first, in which case the a
check in kernel/fork.c will pick that up; or the task will be
added to the tasklist first, in which case CPU hotplug should
correctly migrate it away.

I think?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
