Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271748AbTHHSuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTHHSuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:50:52 -0400
Received: from palrel10.hp.com ([156.153.255.245]:18369 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S271748AbTHHSuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:50:37 -0400
Date: Fri, 8 Aug 2003 11:50:35 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.X
Message-ID: <20030808185035.GA13274@bougret.hpl.hp.com>
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

	More IrDA driver fixes that I want you to push in
2.6.0-testX. VIA has updated their driver according to your whishes
(with help from Oliver Neukum).
	Patches tested on 2.6.0-test2.

        Thanks in advance...

        Jean

----------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir260_donau_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Christian Gennerat>
	o [CORRECT] Disable chip probing that fail too often
	o [FEATURE] Cleanup STATIC

ir260_lap_retry_count.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] add interoperability workaround for 2.4.X IrDA stacks

ir260_usb_probe-4.diff :
~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Oliver Neukum and Daniele Bellucci>
	o [CORRECT] minor fix to the probe failure path of irda-usb.

ir260_via_ircc-4.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Frank Liu/VIA and Oliver Neukum>
	o [FEATURE] driver for IrDA integrated in VIA chipsets
	o [CORRECT] Use PCI table for probing
	o [FEATURE] Beautify source code

ir260_vlsi-05.diff :
~~~~~~~~~~~~~~~~~~
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

ir260_tekram-sir.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [CORRECT] Update tekram-sir dongle driver to common power-settling

ir260_ircomm_owner.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Andrey Borzenkov>
	o [CORRECT] Update module refcount in IrCOMM module

ir260_nsc_39x_fixes.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Jan Frey>
	o [CORRECT] Make NSC 3839x probe and init *really* work


