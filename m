Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273021AbTHKVC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273028AbTHKVC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:02:28 -0400
Received: from palrel13.hp.com ([156.153.255.238]:3507 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S273021AbTHKVC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:02:26 -0400
Date: Mon, 11 Aug 2003 14:02:20 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.X, resend
Message-ID: <20030811210220.GA21178@bougret.hpl.hp.com>
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

	Hi,

	I've just downloaded and tested 2.6.0-test3, and I was
surprised to see that the IrDA patches I sent you are included. That's
incredibly fast ;-)
	Unfortunately, it seems that 3 patches were lost in the
process. One of them did no longer apply to -test3 (my fault), so I
rediffed it. All tested on -test3.

	Thanks !

	Jean

--------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir260_ircomm_owner.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Andrey Borzenkov>
	o [CORRECT] Update module refcount in IrCOMM module

ir260_nsc_39x_fixes.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Jan Frey>
	o [CORRECT] Make NSC 3839x probe and init *really* work
		The new 3839x code was totally broken.
		Won't affect code for 38108/38338 chips.

ir2603_vlsi-05.diff :
~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* correct endianess conversion of hardware exposed fields
* we need to check crc16 of rx frames in SIR-mode
  (hardware does this in MIR/FIR modes). Use irda_calc_crc16.
* get rid of BUG'gers - having them in interrupt path isn't fun.
* don't return NET_XMIT_DROP when we drop (dev_kfree_skb_any)
  frames. This value is meant to ask for retransmit so we would
  corrupt the skb slab.
* locking review, corrections and improvements: particularly focus 
  on speed setting and start_xmit paths, but also reducing time
  we are staying with interrupts disabled.
* printk-cleanup: less/better syslog msgs, use IRDA_DEBUG and friends.
* default qos_mtt_bits should be 1ms or longer (0x07), not exactly 1ms
* rename IRENABLE_IREN -> IRENABLE_PHYANDCLOCK
* few minor improvements 
* compatibility stuff to preserve 2.4 backport path
* it's a pci controller, so we should depend on CONFIG_PCI
* DRIVER_VERSION 0.5
