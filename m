Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUIFXKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUIFXKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUIFXKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:10:11 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:62660 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267445AbUIFXKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:10:03 -0400
References: <413CB661.6030303@sgi.com>
Message-ID: <cone.1094512172.450816.6110.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ray Bryant <raybry@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>, Nick Piggin <piggin@cyberone.com.au>,
       Martin =?ISO-8859-1?B?Si4=?= Bligh <mbligh@aracnet.com>
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Date: Tue, 07 Sep 2004 09:09:32 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant writes:

> Andrew (et al),
> 
> The attached results started as an exercise to try to understand what value of 
> "swappiness" we should be recommending to our Altix customers when they start 
> running Linux 2.6 kernels.  The benchmark is very simple -- a task first 
> mallocs around 90% of memory, touches all of the memory, then sleeps forever.
> After the task begins to sleep, we start up a bunch of "dd" copies.  When the 
> dd's all complete, we record the amount of swap used, the size of the page 
> cache, and the data rates for the dd's.  (Exact details are given in the 
> attachment.)  The benchmark was repeated for swappiness values of 0, 20, 40, 
> 60, 80, 100, for a number of recent 2.6 kernels.
> 
> What is unexpected is that the amount of swap space used at a particular
> swappiness setting varies dramatically with the kernel version being tested, 
> in spite of the fact that the basic swap_tendency calculation in 
> refile_ianctive_zone() is unchanged.  (Other, subtle changes in the vm as a 
> whole and this routine in particular clearly effect the impact of that 
> computation.)
> 
> For example, at a swappiness value of 0, Kernel 2.6.5 swapped out 0 bytes,
> whereas Kernel 2.6.9-rc1-mm3 swapped out 10 GB.  Similarly, most kernels
> have a significant change in behavior for swappiness values near 100, but
> for SLES9 the change point occurs at swappness=60.
> 
> A scan of the change logs for swappiness related changes shows nothing that 
> might explain these changes.  My question is:  "Is this change in behavior
> deliberate, or just a side effect of other changes that were made in the vm?" 
> and "What kind of swappiness behavior might I expect to find in future kernels?".

The change was not deliberate but there have been some other people report 
significant changes in the swappiness behaviour as well (see archives). It 
has usually been of the increased swapping variety lately. It has been 
annoying enough to the bleeding edge desktop users for a swag of out-of-tree 
hacks to start appearing (like mine).

Cheers,
Con

