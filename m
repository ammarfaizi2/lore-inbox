Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268710AbRG0SbP>; Fri, 27 Jul 2001 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbRG0SbF>; Fri, 27 Jul 2001 14:31:05 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:57498 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268710AbRG0Sav>; Fri, 27 Jul 2001 14:30:51 -0400
Message-Id: <4.3.1.0.20010727112236.03454b30@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Fri, 27 Jul 2001 11:31:22 -0700
To: Andrea Arcangeli <andrea@suse.de>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: 2.4.7 softirq incorrectness.
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20010727170107.J22784@athlon.random>
In-Reply-To: <4.3.1.0.20010726165025.0574cdc0@mail1>
 <200107261746.VAA31697@ms2.inr.ac.ru>
 <20010726002357.D32148@athlon.random>
 <200107261746.VAA31697@ms2.inr.ac.ru>
 <20010726202939.D22784@athlon.random>
 <4.3.1.0.20010726165025.0574cdc0@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > Should we then create generic function (something like netif_rx_from_user) than will call do_softirq 
> > after calling netif_rx ?
>
>creating such a function is certainly ok (it must first check pending()
>before running do_softirq of course). The name shouldn't be "from user"
>because we actually call it from normal kernel context.
Sure.

> > I queue it and do tasklet_schedule(tx_task). Everything works just fine but on SMP machine I noticed that sometimes 
> > data is sent in the wrong order. And the only reason why reordering could happen is if several tx_tasks are runing at the 
>
>Do you use tasklet_enable ? 
Yep. To sync rx and tx tasks.

>This patch fixes a bug in tasklet_enable.
>(bug found by David Mosemberg) We are thinking at more CPU friendly ways
>to handle the tasklet_disable, Linus just had a suggestion, but I don't
>have time right now to think much about the alternate approches (i'm at
>ols), I will do next week. If you are usng tasklet_enable you may want
>to give it a spin.
Applied to 2.4.8-pre1. Didn't make any difference. 
Also it doesn't fix the scenario that I described (reschedule while running). I'm still wondering why don't I hit that trylock/BUG 
in tasklet_action.

Thanks
Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

