Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVBVXno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVBVXno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVBVXno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:43:44 -0500
Received: from alog0019.analogic.com ([208.224.220.34]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261336AbVBVXnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:43:41 -0500
Date: Tue, 22 Feb 2005 18:42:39 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Chris Friesen <cfriesen@nortel.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
In-Reply-To: <421BBD75.6040504@nortel.com>
Message-ID: <Pine.LNX.4.61.0502221835190.5814@chaos.analogic.com>
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
 <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no>
 <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com>
 <421B9018.7020007@nodivisions.com> <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl>
 <421B9C86.8090800@nortel.com> <Pine.LNX.4.61.0502221619330.5460@chaos.analogic.com>
 <421BBD75.6040504@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Chris Friesen wrote:

> linux-os wrote:
>
>> Now, somebody needs a resource. It executes down(&semaphore);
>> once it gets control again, it has that resource. It attempts
>> to use that resource through a driver. The driver waits forever.
>> The resource is now permanently dorked --forever because its
>> driver is waiting forever. The user code never returns from
>> the driver so it can never execute up(&semaphore).
>
> What about something like a "robust mutex" (in OSDL terminology)?  The guy 
> holding it too long gets killed, and the mutex gets marked as dirty.  The 
> next guy to aquire the mutex is responsable for re-initializing the resource 
> (resetting the device to a known state, for instance).
>
> Chris
>

All wonderful. However, it dosn't fix the problem. You are,
again, assuming that the problem is the symptom! The problem
is that some piece of code is not handling an exception
properly. It is waiting forever for something that will
never happen. It's that CODE that needs to be fixed.

"Cleaning" up the immediate symptoms doesn't let
the next thread that acquires the "cleaned up" lock
use the hardware because it has jammed code between
that thread and the hardware.

The bad code needs to be fixed. If the bad code is
fixed, you will __never__ have a process stuck
in 'D' state unless you run for the 1000 years
that could statistically result in a bit in
the semaphore getting flipped.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
