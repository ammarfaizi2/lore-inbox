Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVLWACY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVLWACY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVLWACY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:02:24 -0500
Received: from smtpout.mac.com ([17.250.248.72]:41191 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751162AbVLWACY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:02:24 -0500
In-Reply-To: <1135292364.9769.58.camel@lade.trondhjem.org>
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <1135171280.7958.16.camel@lade.trondhjem.org> <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com> <1135172453.7958.26.camel@lade.trondhjem.org> <43AA0EEA.8070205@bigpond.net.au> <1135289282.9769.2.camel@lade.trondhjem.org> <43AB29B8.7050204@bigpond.net.au> <1135292364.9769.58.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] sched: Fix adverse effects	of	NFS	client	on	interactive response
Date: Thu, 22 Dec 2005 19:02:10 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 22, 2005, at 17:59, Trond Myklebust wrote:
> On Fri, 2005-12-23 at 09:33 +1100, Peter Williams wrote:
>>> It still has sod all business being in the NFS code. We don't  
>>> touch task scheduling in the filesystem code.
>>
>> How do you explain the use of the TASK_INTERRUPTIBLE flag then?
>
> Oh, please...
>
> TASK_INTERRUPTIBLE is used to set the task to sleep. It has NOTHING  
> to do with scheduling.

Putting a task to sleep _is_ rescheduling it.  TASK_NONINTERACTIVE  
means that you are about to reschedule and are willing to tolerate a  
higher wakeup latency.  TASK_INTERRUPTABLE means you are about to  
sleep and want to be woken up using the "standard" latency.  If you  
do any kind of sleep at all, both are valid, independent of what part  
of the kernel you are.  There's a reason that both are TASK_* flags.

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley



