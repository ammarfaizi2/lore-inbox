Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCKKHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 05:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUCKKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 05:07:19 -0500
Received: from [202.125.86.130] ([202.125.86.130]:30358 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261161AbUCKKHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 05:07:17 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: not syncing! error
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 11 Mar 2004 15:33:28 +0530
Message-ID: <1118873EE1755348B4812EA29C55A972176470@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: not syncing! error
Thread-Index: AcQHUBnwmOJz+g82TfiMCK/r00CxfA==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a hardware that sends in interrupts on every command that is passed to it.

What I do is when I get the initial interrupt I schedule the tasklet and carry out the device initialization from the tasklet. The tasklet is the ultimate action performer on any interrupt. The ISR just acknowledges and clears the interrupt.

The tasklet itself sends in commands to initialize the hardware. We do a interruptible_sleep_on() after a command is sent (wait for wake_up). When a command is sent an interrupt occurs and again the tasklet is scheduled (I guess so). Now from some other part in the tasklet I send a wake_up_interruptible(). This goes into trouble and the kernel ends up saying "kernel not syncing". If I remove interruptible_sleep_on the driver at least gets loaded and wake_up_interruptible() are sent..

I guess the problem is synchronization of these events. At present I have not used any locks. Can any one help me understand how I can take care of this scenario? The locking I will have to use should work for SMP too. Any pointers with easy to understand example codes is more than welcome. ?

Cheers!
-Jinu
Novice slowly trying to become guru!
