Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267142AbUBMVPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUBMVPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:15:18 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:4357 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S267142AbUBMVPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:15:03 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-kernel@vger.kernel.org
Subject: FW: spinlocks dont work
Date: Fri, 13 Feb 2004 16:12:08 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a uniprocessor system, with config_smp NOT Defined...

Note the following example:

driver 'A' calls spin_lock_irqsave and gets through (but does not call
..unlock).
driver 'B' calls spin_lock_irqsave and gets through???

How can B get through if A did not unlock yet?

-Mike

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]
Sent: Friday, February 13, 2004 3:25 PM
To: RANDAZZO@ddc-web.com
Subject: RE: spinlocks dont work


On Fri, 13 Feb 2004 RANDAZZO@ddc-web.com wrote:

> if I need to lock out in the ISR, and I haven't
> compiled for SMP, what can I use instead?
>
> Mike

spinlock_t mylock = SPIN_LOCK_UNLOCKED;

You put:
        unsigned int flags;

	spin_lock_irqsave(&mylock, flags);
	//
        // Critical section code
	//
        spin_unlock_irqrestore(&mylock flags);

...this construct around any critical section. If you
don't know how to write interrupt service routines and
insist upon enabling interrupts within the ISR, you
need the same thing in the ISR.


Whether or not it's compiled for SMP should not then make
any difference because the 'cli' in the macro will still
exist.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

