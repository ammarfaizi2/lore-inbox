Return-Path: <linux-kernel-owner+w=401wt.eu-S932219AbXAIQfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbXAIQfN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbXAIQfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:35:13 -0500
Received: from CHOKECHERRY.SRV.CS.CMU.EDU ([128.2.185.41]:60627 "EHLO
	chokecherry.srv.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932219AbXAIQfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:35:11 -0500
Message-ID: <45A3C420.8010708@cs.cmu.edu>
Date: Tue, 09 Jan 2007 11:34:40 -0500
From: Benjamin Gilbert <bgilbert@cs.cmu.edu>
User-Agent: Thunderbird 1.5.0.7 (X11/20060916)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Srivatsa Vaddagiri <vatsa@in.ibm.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Failure to release lock after CPU hot-unplug canceled
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu> <20070109121738.GC9563@osiris.boeblingen.de.ibm.com> <20070109122740.GC22080@in.ibm.com> <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
> On Tue, Jan 09, 2007 at 05:57:40PM +0530, Srivatsa Vaddagiri wrote:
>> On Tue, Jan 09, 2007 at 01:17:38PM +0100, Heiko Carstens wrote:
>>> The workqueue code grabs a lock on CPU_[UP|DOWN]_PREPARE and releases it
>>> again on CPU_DOWN_FAILED/CPU_UP_CANCELED. If something in the callchain
>>> returns NOTIFY_BAD the rest of the entries in the callchain won't be
>>> called anymore. But DOWN_FAILED/UP_CANCELED will be called for every
>>> entry.
>>> So we might even end up with a mutex_unlock(&workqueue_mutex) even if
>>> mutex_lock(&workqueue_mutex) hasn't been called...
 >>
>> This is a known problem. Gautham had sent out patches to address them
>>
>> http://lkml.org/lkml/2006/11/14/93
>>
>> Looks like they are in latest mm tree. Perhaps the testcase should be
>> retried against latest mm.
 >
> Ah, nice! Wasn't aware of that. But I still think we should have a
> CPU_DOWN_FAILED in case CPU_DOWN_PREPARED failed.
> Also the slab cache code hasn't been changed to make use of the of the
> new CPU_LOCK_[ACQUIRE|RELEASE] stuff. I'm going to send patches in reply
> to this mail.

2.6.20-rc3-mm1 plus your patches fixes it for me.

Thanks
--Benjamin Gilbert

