Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbULIBvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbULIBvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbULIBvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:51:06 -0500
Received: from palrel10.hp.com ([156.153.255.245]:21180 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261433AbULIBuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:50:55 -0500
Date: Wed, 8 Dec 2004 17:50:54 -0800
To: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.10-rc3
Message-ID: <20041209015054.GA2298@bougret.hpl.hp.com>
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

	There is some trivial fixes for some serious driver bug that
did show up in my mailbox. Because the fixes are trivial and the bug
serious, I would like to push that into 2.6.10 final.
	I tested the irda-usb patch, and Stephen tested the stir4200
patch. The VIA driver case is messy : I did the minimal fix that I
could get away with, because I don't have the hardware to test and the
proper fix will require much more work.
	Just push that up ;-)

	Jean

-------------------------------------------------------------

ir260_via_pci_hack.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Bugfix suggested by Arkadiusz Miskiewicz>
	o [CORRECT] Try to fix the worse abuse of the pci init code in via_ircc

Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_stir4200-kill-1.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
USB changed behaviour of unlink_urb so that it gives warning and backtrace when
being used synchronously. The correct current behaviour is to us kill_urb
in that case.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir260_irda-usb-kill-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
Updates for irda-usb.
        * change comment about Sigmatel now that there is a driver
        * convert to new module_param
        * places where urb is unlinked synchronously, use usb_kill_urb
          because that is now a runtime warning.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
