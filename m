Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270260AbUJTBIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270260AbUJTBIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270259AbUJTBGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:06:19 -0400
Received: from palrel11.hp.com ([156.153.255.246]:15014 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266465AbUJTBAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:00:46 -0400
Date: Tue, 19 Oct 2004 18:00:38 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.9
Message-ID: <20041020010038.GA12932@bougret.hpl.hp.com>
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

        This are all the IrDA patches that were pending, ready for
inclusion in 2.6.9. Tested on my SMP box and laptop with 2.6.9, and by
various IrDA users.
	Most changes will be invisible to users, apart from the via
and stir changes that allow the drivers to work better.
	Linus might be busy under the mountain of patches, but I'm
sure he need my patches ;-)

	Jean

-------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir269_lmp_lsap_inuse-3.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Fix locking in error path in IrLMP (Stanford checker)
	o [CORRECT] Don't reuse unconnected LSAPs (listening sockets)
	o [CORRECT] Make sure the LSAP we are picking has just not been grabed
	o [CORRECT] Wrap around the LSAP space properly back to 0x10
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir269_nsc_dongle-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Maik Broemme>
	o [CRITICA] Don't Oops on invalid dongle-id in nsc-ircc driver
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir269_irnet_alias.diff :
~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Add module alias for IrNET char dev
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir269_ias_safety.diff :
~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Make optional the del of IAS object when del IAS attrib
	o [FEATURE] Clarify when/why it's safe to to the above
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir269_adaptive_query_timer-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Adapt to the rate of the peer discovery (passive discovery)
	o [FEATURE] Add extra safety margin in passive discovery
	Allow to interoperate properly with device performing slow discovery
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir269_ircomm_ias_fix-1.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Restore properly the IAS object when IrCOMM disconnect.
	Allow "pppd passive persist" to work properly.
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir269_via_speed_fixes-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Speed change fixes in via-ircc driver
	o [FEATURE] Add new dongle ID in via-ircc driver
	o [FEATURE] Various code cleanups in via-ircc driver
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_debug_mod_parm.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] irda 2.6 - fix module info
The module parameter info for irda is incorrect.
The debug parameter is named "debug", the variable is irda_debug.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_stir_reset.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] stir4200 - get rid of reset on speed change
The Sigmatel 4200 doesn't accept the address setting which gets done on
USB reset.  The USB core recently changed to resend address (or
something like that), so usb_reset_device is failing.

The device works without doing the USB reset on speed change, it just
will be less robust in recovering when things get wedged (like coming
out of FIR mode).

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_stir_suspend.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] stir4200: don't need suspend/resume if !CONFIG_PM
The suspend/resume code only needs to be compiled in if power management
is enabled.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_stid_netdev_priv.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] stir4200: netdev_priv and message cleanup
Stir4200 driver cleanup's:
        * use netdev_priv
        * make sure messages identify the driver
        * get rid of unneeded message
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


