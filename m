Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277279AbRJEAIM>; Thu, 4 Oct 2001 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277274AbRJEAID>; Thu, 4 Oct 2001 20:08:03 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:61394 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277279AbRJEAHu>;
	Thu, 4 Oct 2001 20:07:50 -0400
Date: Thu, 4 Oct 2001 17:08:04 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: New batch of IrDA patches for 2.4.11-pre3
Message-ID: <20011004170804.A3290@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This is the new batch of IrDA patches that have been tested on
the IrDA mailing list in the last 2 weeks. I've just recreated them
for 2.4.11-pre3, so they are ready to go in the kernel..
	Changelog below, patch to follow...

	Jean

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir240_vlsi_v0.3.diff :
--------------------
<From Martin Diehl, his changelog :>
v0.3:
        * improve chip initialization which was insufficient in some rare
          cases without cold reboot
        * resync with v2.4.10 (irlap-hwname e.g.)
        * add MODULE_LICENSE
        * drop MOD_{INC|DEC}_USE_COUNT in favour of SET_MODULE_OWNER
        * rename mtt_bits to qos_mtt_bits parameter like other irda
          drivers use
v0.2:
        * add Documentation/Configure.help entry
        * datasize=2048 issues fixed
        * major ring operation improvement and cleanup
        * improved mtt handling
        * few minor fixes
<Note : I think this patch also enable MIR/FIR operation, i.e. higher speeds>

ir240_usb_async-2.diff :
----------------------
	o [CRITICA] Set the USB_ASYNC_UNLINK flag on Tx URB
		- now usb_unlink_urb() in net watchdog does no longer crash
	o [CORRECT] Document behaviour with respect to USB low level drivers
	o [CORRECT] Document that SigmaTel chipset won't work
	o [CORRECT] Handle properly unknown USB error code
	o [FEATURE] Remove the KICK_TX code (now that USB_ZERO_PACKET works)
	o [FEATURE] Optimise timing by taking into account USB RTT
	o [FEATURE] Increase USB and Watchdog timeout (for 9600bps operation)
	o [FEATURE] Document the use of the interrupt pipe

ir240_discovery_on_demand-2.diff :
--------------------------------
	o [FEATURE] Enable IrDA discovery on demand while in passive mode
		- Apply only to IrSock and IrNET
		- Was accidentally removed in discovery rework one year ago

ir240_various_cleanup-2.diff :
----------------------------
	o [CORRECT] Remove a comment that Dag found offensive
	o [CORRECT] Remove unused variable (spurious warning)
	o [CORRECT] Typo in nsc-ircc.c
	o [FEATURE] Enable alternate IO address in smc-ircc.c
