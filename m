Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319287AbSHGTkb>; Wed, 7 Aug 2002 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319288AbSHGTkb>; Wed, 7 Aug 2002 15:40:31 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:38120 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S319287AbSHGTka>; Wed, 7 Aug 2002 15:40:30 -0400
Message-Id: <5.1.0.14.2.20020807122643.098f3ed0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 07 Aug 2002 12:43:48 -0700
To: kuznet@ms2.inr.ac.ru
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: "new style" netdevice allocation patch for TUN driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208062228.CAA25818@sex.inr.ac.ru>
References: <5.1.0.14.2.20020806135501.09799218@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey,

> > Please explain to me why do we have to hold rtnl lock while sleeping in
> > unregister_netdevice ?
>
>... not "while sleeping", but just "while".
>
>If the lock would be for the device, it would be local to the device,
>rather than global. The semaphore blocks all the networking configuration
>until caller will complete stuff related to unregistering.
>
>Forward references from the unregistered device under cannot be invalidated
>before the device is unregistered. All such work is done after unregistry
>for "old style" or in dev->uninit/destructor hooks, which are used
>by "new style" devices.
All I'm saying is that. Unregistration is effectively complete at the time
we call schedule(). At this point only, so to speak, buggy subsystems are
holding references. Adding new devices and routes won't hurt. Even if
it will only those buggy guys might have problems with that.

> > 1 - Something is not releasing device
>
>Let's find this something! It witnesses about really serious bug.
>
>I cannot reproduce this too. Understand, please, we _can_ follow
>your proposal, all 100% of old style devices do not need uninit in real
>life. But then we never will find the bug. You cannot reproduce it,
>I cannot too.
I'm not following you. How dropping rtnl_lock while calling schedule() 
would affect
our bug hunting :) ?
We still emit "waiting for ..." warning message and we still don't give 
control
to the driver unless refcount is 0.

> > fix it. If one thing is buggy it doesn't mean
>It means exactly this. Kernel panic would be even better, if it was
>possible to detect deadlock reliably.
There is no deadlock here.

Max

