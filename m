Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVEaIuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVEaIuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVEaIug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:50:36 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:42926 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261390AbVEaIuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:50:13 -0400
Message-ID: <429C253E.10004@yahoo.com.au>
Date: Tue, 31 May 2005 18:50:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: Ashok Raj <ashok.raj@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com>	 <20050531010030.A5239@unix-os.sc.intel.com> <1117528509.3957.3.camel@linux-hp.sh.intel.com>
In-Reply-To: <1117528509.3957.3.camel@linux-hp.sh.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:

> I must be over considering. Ok, how does this updated one look?
> 
> 

Looks like you've found a race, alright. Nice work!

I think it would be preferable to do the check in kernel/fork.c,
after the tasklist lock is taken (and you'll need to rediff the
patch for the -mm tree).

One problem with doing it in wake_up_new_task is that I think
some newly forked tasks don't get woken up by wake_up_new_task!

Thanks,
Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
