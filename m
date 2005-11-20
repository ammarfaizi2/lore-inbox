Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVKTJzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVKTJzB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 04:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKTJzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 04:55:01 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:3790 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751202AbVKTJzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 04:55:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Marcel Zalmanovici <MARCEL@il.ibm.com>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
Date: Sun, 20 Nov 2005 20:54:50 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <OFEF2B25AC.706FA8BA-ONC22570BF.00336502-C22570BF.0033F2B7@il.ibm.com>
In-Reply-To: <OFEF2B25AC.706FA8BA-ONC22570BF.00336502-C22570BF.0033F2B7@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511202054.50690.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005 20:27, Marcel Zalmanovici wrote:
> Hi,
>
> I am trying, as part of my thesis, to make some improvement to the linux
> scheduler.
> Therefore I've written a small multithreaded application and tested how
> long on average it takes for it to complete.
>
> The results were very surprising. I expected to see the completion time
> vary 1 to 2 seconds at most.
> Instead what I've got was an oscillation where the maximum time was twice
> and more than the minimum!! For a short test results ranged ~7sec to ~16
> sec, and the same happened to longer tests where the min was ~1min and the
> max ~2:30min.
>
> Does anyone have any clue as to what might happen ?
> Is there anything I can do to get stable results ?
>
> Here is a small test case program:
>
> (See attached file: sched_test.c)
>
> The test was always done on a pretty much empty machine. I've tried both
> kernel 2.6.4-52 and 2.6.13.4 but the results were the same.
>
> I'm working on a Xeon Intel machine, dual processor, hyperthreaded.
                                                       ^^^^^^^^^^^^^^

I suspect what you're seeing is the random nature of threads to bind either to 
a hyperthread sibling or a real core. If all your threads land on only one 
physical cpu and both hyperthread siblings it will run much slower than if 
half land on one physical cpu and half on the other physical cpu. To confirm 
this, try setting cpu affinity just for one logical core of each phyiscal cpu 
(like affinity for cpu 1 and 3 only for example) or disabling hyperthread in 
the bios.

Cheers,
Con
