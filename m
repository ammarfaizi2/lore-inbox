Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSC2AZk>; Thu, 28 Mar 2002 19:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313315AbSC2AZb>; Thu, 28 Mar 2002 19:25:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:900 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313314AbSC2AZS>; Thu, 28 Mar 2002 19:25:18 -0500
Date: Thu, 28 Mar 2002 19:25:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200203290025.g2T0PHr04174@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Char devices drivers
In-Reply-To: <mailman.1017359089.18550.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Can anyone explain what is the utility of the callout devices 
>> > in the char drivers ???

The utility is this (mind, it is only a nice idea in someone's
empty head, in reality it does not really work that way):

1. You run getty on /dev/cua0 or /dev/cua1.
2. Getty waits for the carrier, and keeps /dev/cuaN open.
3. Meanwhile, you can use cu, kermit, and uucico to dial
   out using /dev/ttya or /dev/ttyb.

Sounds very nifty, and this is how SunOS worked and Solaris
tries to (with devices renamed a bit). The devil is details,
or course. The hellishly complicated semantics of this
twin-tailed device makes the driver pretty buggy.

>[...]
> So eliminating cua means more work for the programmer but less confusion
> for users.  Overall, it's a good thing since there are many more users
> than programmers.
> 
> 			David Lawyer

I think it's more important that devices work as advertised
more often if drivers are simpler. In my expirience, users
are not really confused by callout devices, but rather are
annoyed when they step on a bug.

-- Pete
