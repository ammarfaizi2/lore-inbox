Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTEMWHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTEMWHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:07:03 -0400
Received: from palrel13.hp.com ([156.153.255.238]:3780 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263612AbTEMWG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:06:58 -0400
Date: Tue, 13 May 2003 15:19:31 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: [PATCH 2.5] IrDA patches changelog (for 2.5.70)
Message-ID: <20030513221931.GA2634@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	This is the next batch of IrDA patches that has been patiently
waiting on my web page. The first patch is all over the place, so you
may want to apply before too much spelling fixes happen in the kernel.

	The first patch is the result of joint work between Jan Kiszka
and me. Jan has ported the Linux-IrDA stack to Win2k, and his
implementation doesn't tolerate any skb leaks. So, we were forced to
fix all skb leaks in Linux-IrDA. Patch intensively tested.
	I also spent some quality time with the irport driver and made
it functional again. A crasher in irnet, the new smsc-ircc2 driver and
many little fixes. All tested in 2.5.69-bk7 SMP.

	Would you mind pushing those patches to Linus ?

	Regards,

	Jean

P.S.: For Andrew that like to keep todo lists for 2.5.X :
	o all known functional bugs in the core Linux-IrDA stacks are fixed.
	o some IrDA driver work has to take place :
		- dongle drivers need to be converted to sir-dev
		- irport need to be converted to sir-kthread
		- new drivers (irtty-sir/smsc-ircc2/donauboe) need more testing
	o The list of cleanups and wishes is long, and many people complain
	  that the source s***s, but those don't prevent usage of Linux-IrDA

---------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir259_skb_get-7.diff :
--------------------
		<Inspired by patches from Jan Kiszka>
	o [CORRECT] Fix skb leaks in IrDA state machines
	o [CORRECT] Fix skb leaks in connect/request error paths
	o [FEATURE] Fix skb leaks in ASSERT
	o [FEATURE] Simplify & document skb handling throughout the stack
	o [FEATURE] other minor cleanups

ir257_irnet_bh.diff :
-------------------
	o [CRITICA] Replace spin_lock_irqsave() with spin_lock_bh()
		to be compatible with ppp_generic locking
	o [CRITICA] Disable call to ppp_unregister_channel()

ir257_caddr_mask.diff :
---------------------
		<Patch from Jan Kiszka>
	o [CORRECT] ignore the C/R bit in the LAP connection address.

ir259_sir_kthread_Morton-2.diff :
-------------------------------
	o [CORRECT] fix module ownership in irtty-sir
	o [FEATURE] important comment in sir_kthread

ir259_trans_start-4.diff :
------------------------
	o [CORRECT] Properly initialise dev->trans_start in various drivers
	o [CRITICA] Unregister power management at unload in smc-ircc
	o [CORRECT] fix module ownership in smc-ircc

ir259_irport-6.diff :
-------------------
	o [CORRECT] fix module ownership in irport
	o [CORRECT] Properly initialise dev->trans_start in irport
	o [CORRECT] Add delay to drain the Tx fifo to avoid corrupting
		last outgoing Tx byte when changing speed
	o [FEATURE] Safer locking around speed change in irport_hard_xmit()
	o [FEATURE] Enforce half duplex operation in interrupt handler
	o [FEATURE] Optimise interrupt handler for latency and I/O ops
	o [FEATURE] Optimise Tx path in irport_write()
	o [FEATURE] Add ZeroCopy Rx
	o [FEATURE] Better debugging in watchdog timeout
	o [FEATURE] Various other cleanups and comments

ir259_smsc-ircc2-6.diff :
-----------------------
		<Original patch from Daniele Peri>
	o [FEATURE] New driver smsc-ircc2, improved FIR support

