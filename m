Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVDVVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVDVVGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVDVVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:06:42 -0400
Received: from fmr18.intel.com ([134.134.136.17]:59074 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262130AbVDVVGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:06:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17001.26444.246648.14231@sodium.jf.intel.com>
Date: Fri, 22 Apr 2005 14:06:20 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
In-Reply-To: <20050422073408.GA5470@elte.hu>
References: <20050325145908.GA7146@elte.hu>
	<20050331085541.GA21306@elte.hu>
	<20050401104724.GA31971@elte.hu>
	<20050405071911.GA23653@elte.hu>
	<20050421073537.GA1004@elte.hu>
	<20050422062714.GA23667@elte.hu>
	<20050422073408.GA5470@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ingo Molnar <mingo@elte.hu> writes:

>> this includes fixes from Daniel Walker, which could fix the plist
>> related slowdown bugs:

> there are still some problems remaining: i just ran Esben Nielsen's
> priority-inheritance validation testsuite, and the plist code gives
> a worst-case latency of 9.0 msecs.

With which machine is this? 

I tried to reproduce with V0.7.45-01 in my 2xPIII 0.9 Ghz I cannot get
more than 1.9ms when doing 2000 samples repeatedly (60 iterations and
counting). 

Did you use other parameters to 'test'?

# cnt=0 
# while true
> do echo -n "$cnt "
> ./test --samples 2000 file.hist 2>&1 | grep maximum; cnt=$(($cnt+1))
> done

With 2.6.12-rc3-V0.7.46-02 I get:

...
2 maximum cycle time: 0.003ms
3 maximum cycle time: 1.706ms
4 maximum cycle time: 1.538ms
5 maximum cycle time: 1.168ms
6 maximum cycle time: 0.003ms
7 maximum cycle time: 0.008ms
8 maximum cycle time: 1.821ms
9 maximum cycle time: 1.013ms
10 maximum cycle time: 1.043ms
11 maximum cycle time: 1.787ms
12 maximum cycle time: 1.519ms
13 ...

roughly the same as with 0.7.45-01:

0 maximum cycle time: 1.872ms
1 maximum cycle time: 0.008ms
2 maximum cycle time: 1.947ms
3 maximum cycle time: 1.902ms
4 maximum cycle time: 1.925ms
5 maximum cycle time: 0.002ms
6 maximum cycle time: 1.950ms
7 maximum cycle time: 0.008ms
8 maximum cycle time: 0.008ms
9 maximum cycle time: 0.008ms
10 maximum cycle time: 1.943ms
11 maximum cycle time: 1.173ms
12 maximum cycle time: 0.008ms
13 maximum cycle time: 0.008ms
...


-- 

Inaky

