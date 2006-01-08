Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752604AbWAHFvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbWAHFvw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbWAHFvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:51:51 -0500
Received: from mail.gmx.net ([213.165.64.21]:56042 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752604AbWAHFvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:51:40 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060108054203.00bf38c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 08 Jan 2006 06:51:24 +0100
To: Peter Williams <pwil3058@bigpond.net.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client     
  on	interactive response
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43C0517E.8020604@bigpond.net.au>
References: <5.2.1.1.2.20060107085929.00c24f98@pop.gmx.net>
 <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
 <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
 <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <43BB2414.6060400@bigpond.net.au>
 <43A8EF87.1080108@bigpond.net.au>
 <1135145341.7910.17.camel@lade.trondhjem.org>
 <43A8F714.4020406@bigpond.net.au>
 <20060102110145.GA25624@aitel.hist.no>
 <43B9BD19.5050408@bigpond.net.au>
 <43BB2414.6060400@bigpond.net.au>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
 <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
 <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
 <5.2.1.1.2.20060107085929.00c24f98@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:40 AM 1/8/2006 +1100, Peter Williams wrote:
>Mike Galbraith wrote:
>>>   One slight variation of your scheme would be to measure the average 
>>> length of the CPU runs that the task does (i.e. how long it runs 
>>> without voluntarily relinquishing the CPU) and not allowing them to 
>>> defer the shift to the expired array if this average run length is 
>>> greater than some specified value.  The length of this average for each 
>>> task shouldn't change with system load.  (This is more or less saying 
>>> that it's ok for a task to stay on the active array provided it's 
>>> unlikely to delay the switch between the active and expired arrays for 
>>> very long.)
>>
>>Average burn time would indeed probably be a better metric, but that 
>>would require doing bookkeeping is the fast path.
>
>Most of the infrastructure is already there and the cost of doing the 
>extra bits required to get this metric would be extremely small.  The 
>hardest bit would be deciding on the "limit" to be applied when deciding 
>whether to let a supposed interactive task stay on the active array.

Yeah, I noticed run_time when I started implementing my first cut.  (which 
is of course buggy)


>By the way, it seems you have your own scheduler versions?  If so are you 
>interested in adding them to the collection in PlugSched?

No, I used to do a bunch of experimentation in fairness vs interactivity, 
but they all ended up just trading one weakness for an other.

         -Mike 

