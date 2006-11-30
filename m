Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031577AbWK3WbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031577AbWK3WbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031579AbWK3WbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:31:10 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:44346 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031577AbWK3WbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:31:08 -0500
Message-ID: <456F5BB4.6050208@oracle.com>
Date: Thu, 30 Nov 2006 14:31:16 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>	<20061129174558.3dfd13df.akpm@osdl.org>	<1164870000.11036.23.camel@earth>	<20061130141140.a1b7d7cc.randy.dunlap@oracle.com> <20061130142719.7474b4c0.akpm@osdl.org>
In-Reply-To: <20061130142719.7474b4c0.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 30 Nov 2006 14:11:40 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>> On Thu, 30 Nov 2006 08:00:00 +0100 Ingo Molnar wrote:
>>
>>> On Wed, 2006-11-29 at 17:45 -0800, Andrew Morton wrote:
>>>> No, I think this patch is right - the declaration of the CONFIG_SMP
>>>> smp_call_function_single() is in linux/smp.h so the !CONFIG_SMP
>>>> declaration
>>>> or definition should be there too.
>>>>
>>>> It's still buggy though.  It should disable local interrupts around
>>>> the
>>>> call to match the SMP version.  I'll fix that separately. 
>>> hm, didnt i send an updated patch for that already? See the patch below,
>>> from many days ago. I sent it after the tsc-sync-rewrite patch.
>> Hi Ingo,
>>
>> Has there been a patch for this one?  (UP again, not SMP)
>>
>> drivers/input/ff-memless.c:384: warning: implicit declaration of function 'local_bh_disable'
>> drivers/input/ff-memless.c:393: warning: implicit declaration of function 'local_bh_enable'
>>
>> Thanks,
>> ---
>> ~Randy
>> config:  http://oss.oracle.com/~rdunlap/configs/config-input-up-header
> 
> eww..  I guess linux/spinlock.h should really include linux/interrupt.h. 
> But interrupt.h includes stuff like sched.h which will want spinlock.h.
> 
> This, maybe?

Looks good.  I had already tried (and failed) adding interrupt.h to spinlock.h --
what a mess.

-- 
~Randy
