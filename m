Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTBTX4F>; Thu, 20 Feb 2003 18:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBTX4F>; Thu, 20 Feb 2003 18:56:05 -0500
Received: from palrel12.hp.com ([156.153.255.237]:59286 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S267241AbTBTX4E>;
	Thu, 20 Feb 2003 18:56:04 -0500
Date: Thu, 20 Feb 2003 16:06:05 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: irda-users@lists.sourceforge.net
Subject: IrDA patches on the way for 2.5.63...
Message-ID: <20030221000605.GA26770@bougret.hpl.hp.com>
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

	I've just checked 2.5.62, and IrDA is happy (i82365 is another
story). Here is another batch of patches for 2.5.X. All those patches
have been on my web page over two months (except the IrNET fix) and
have been tested with 2.5.62.
	The remaining IrDA work before 2.6.X :
		o drivers (especially dongles)
		o skb leaks (found by Jan Kiszka and more)
        Would you mind passing those patches to Linus ?

	Have fun...

	Jean

-------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir253_discovery_locking-2.diff :
------------------------------
	o [CRITICA] Fix remaining locking problem with discovery log
	o [CRITICA] Don't call expiry callback under spinlock
	o [FEATURE] Simplify/cleanup/optimise discovery/expiry code

ir253_dynamic_fix-2.diff :
------------------------
	o [FEATURE] Fix the dynamic window code to properly send the pf bit.
		Increase perf by 40% for large packets at SIR.

ir253_usb_rx_skb-2.diff :
-----------------------
	o [CORRECT] Don't do usb_clear_halt() on USB control pipe
	o [FEATURE] Cleanup and simplify the USB Rx path

ir253_sir-dev_wrapper-4.diff :
----------------------------
	o [FEATURE] Enable ZeroCopy Rx in irtty-sir/sir-dev
		(provided by the new SIR wrapper in 2.5.61).

ir253_timer_mod.diff :
--------------------
	o [FEATURE] Make IrDA timers use mod_timer instead of add+del_timer

ir253_irnet_mod_hints-2.diff :
----------------------------
	o [CORRECT] Fix module refcounting (MOD_INC/DEC => .owner)
	o [FEATURE] Add hints to discovery (control channel)
