Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVE0N4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVE0N4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0Nz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:55:59 -0400
Received: from mail.timesys.com ([65.117.135.102]:63238 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261679AbVE0NzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:55:02 -0400
Message-ID: <4297265B.3090606@timesys.com>
Date: Fri, 27 May 2005 09:53:31 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com> <20050513074439.GB25458@elte.hu> <4284A7B6.4090408@timesys.com> <42935715.2000505@timesys.com> <20050527072534.GA8172@elte.hu>
In-Reply-To: <20050527072534.GA8172@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2005 13:48:30.0515 (UTC) FILETIME=[C438A030:01C562C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * john cooper <john.cooper@timesys.com> wrote:
>>The RPC code is attempting to replicate state of
>>timer ownership for a given rpc_task via RPC_TASK_HAS_TIMER
>>in rpc_task.tk_runstate.  Besides not working
>>correctly in the case of preemptable context it is
>>a replication of state of a timer pending in the
>>cascade structure (ie: timer->base).  The fix
>>changes the RPC code to use timer->base when
>>deciding whether an outstanding timer registration
>>exists during rpc_task tear down.
>>
>>Note: this failure occurred in the 40-04 version of
>>the patch though it applies to more current versions.
>>It was seen when executing stress tests on a number
>>of PPC targets running on an NFS mounted root though
>>was not observed on a x86 target under similar
>>conditions.
> 
> 
> should this fix go upstream too?

Yes.  The RPC code is attempting to replicate existing
and easily accessible state information in a timer
structure.  The simplistic means by which it does so
fails if ksoftirqd/rpc_run_timer() runs in preemptive
context.

-john


-- 
john.cooper@timesys.com
