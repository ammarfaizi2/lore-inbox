Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUC2L2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 06:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbUC2L2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 06:28:48 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:38560 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262813AbUC2L2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 06:28:46 -0500
Message-ID: <40680868.2070800@yahoo.com.au>
Date: Mon, 29 Mar 2004 21:28:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       jun.nakajima@intel.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <200403291021.i2TAKxx21370@owlet.beaverton.ibm.com>
In-Reply-To: <200403291021.i2TAKxx21370@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> I've got a web page up now on my home machine which shows data from
> schedstats across the various flavors of 2.6.4 and 2.6.5-rc2 under
> load from kernbench, SPECjbb, and SPECdet.
> 
>     http://eaglet.rain.com/rick/linux/sched-domain/index.html
> 

I can't see it

> Two things that stand out are that sched-domains tends to call
> load_balance() less frequently when it is idle and more frequently when
> it is busy (as compared to the "standard" scheduler.)  Another is that

John Hawkes noticed problems here too. mm5 has a patch to
improve this for NUMA node balancing. No change on non-NUMA
though if that is what you were testing - we might need to
tune this a bit if it is hurting.

> even though it moves fewer tasks on average, the sched-domains code shows
> about half of pull_task()'s work is coming from active_load_balance() ...

Yeah this is wrong and shouldn't be happening. It would have been
due to a bug in the imbalance calculation which is now fixed.
