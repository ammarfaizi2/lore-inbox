Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUDNWPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUDNWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:15:24 -0400
Received: from palrel12.hp.com ([156.153.255.237]:34465 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261798AbUDNWPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:15:20 -0400
Date: Wed, 14 Apr 2004 15:15:18 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.6
Message-ID: <20040414221518.GA5434@bougret.hpl.hp.com>
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

	Hi David,

	This is the latest batch of IrDA patches from Stephen. It
seems to me that he is running out of things to clean up in the IrDA
stack ;-) I added a few other patches from Martin and me for good
measure.
	Please send that through the channels...

	Jean

-------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir265_vlsi_proc.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Convert vlsi_ir /proc/driver to single seq_file method.

ir265_rd_rsp_retry.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [CORRECT] Fix handling of RD:RSP to be spec compliant

ir265_donauboe_crc.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Get rid of local CRC table, use standard one

irXXX_irlan_print_ret.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Move print_ret_code from a global to local to avoid
		namespace pollution.

irXXX_irlan_handle_filter.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Change name of handle_filter_request to
		irlan_filter_request to avoid namespace pollution.

irXXX_irlan_common_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Minor type changes in irlan_common for clarity:
        - use const
        - init and exit can be static
        - use skb_queue_purge to flush queue
        - get rid of noisy old comment

ir265_irlan_eth_cleanup-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Use IrTTP flow control to stop/wake netif
		<Patch from Stephen Hemminger>
	o [CORRECT] Change irlan_eth device initialization:
        *bug* address never set in DIRECT mode because access not set
              in alloc_netdev -> irlan_eth_setup path
        + make eth_XXX handles static and provide alloc_irlandev hook
        + use netdev_priv (and get rid of truly impossible ASSERT's)
        + use skb_queue_purge

irXXX_irlan_sleep.diff :
~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] gets rid of interruptible_sleep_on.

