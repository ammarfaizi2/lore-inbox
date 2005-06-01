Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFAVFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFAVFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFAVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:05:07 -0400
Received: from mail.timesys.com ([65.117.135.102]:26240 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261259AbVFAVBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:01:23 -0400
Message-ID: <429E21B8.2070404@timesys.com>
Date: Wed, 01 Jun 2005 16:59:36 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>	 <1117312557.10746.6.camel@lade.trondhjem.org>	 <4299332F.6090900@timesys.com>	 <1117352410.10788.29.camel@lade.trondhjem.org>	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>	 <429DF8DE.7060008@timesys.com>	 <1117650718.10733.65.camel@lade.trondhjem.org>	 <429E0A86.7000507@timesys.com> <1117657267.10733.106.camel@lade.trondhjem.org>
In-Reply-To: <1117657267.10733.106.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2005 20:54:36.0718 (UTC) FILETIME=[1EEE5CE0:01C566EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> on den 01.06.2005 Klokka 15:20 (-0400) skreiv john cooper:
> 
>>You might have missed in my earlier mail as
>>this is a not an MP kernel ie: !CONFIG_SMP
>>The synchronous timer delete primitives don't
>>exist in this configuration:
> 
> 
> This probably explains your trouble. It makes no sense to allow
> __run_timer to be preemptible without having the synchronous timer
> delete primitives. Synchronisation is impossible without them.

The addition of CONFIG_PREEMPT_SOFTIRQS in this context
came into place in more recent RT patch versions than
with what I'm dealing.  I've just pulled it in but this
doesn't appear to alter the nature of the failure.
I'm still catching an inconsistency at the very head of
rpc_delete_timer() in the case of:

     BUG_ON(!test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) &&
         timer_pending(&task->tk_timer));

> Which version of the RT patches are you using? The one I'm looking at
> (2.6.12-rc5-rt-V0.7.47-15) certainly defines both del_timer_sync() and
> del_singleshot_timer_sync() to be the same as the SMP versions if you
> are running an RT kernel with preemptible softirqs.

Yes later versions of the patch do.  The version at hand
40-04 is based on 2.6.11.  We intend to sync-up with a
more recent version of the RT patch pending resolution
of this issue.

I have two potential work-arounds I'm trying to validate.
Though I have a bit more tree-shaking to do before I've
completed this exercise.

-john


-- 
john.cooper@timesys.com
