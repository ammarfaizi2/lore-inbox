Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312871AbSDCCSM>; Tue, 2 Apr 2002 21:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312989AbSDCCSD>; Tue, 2 Apr 2002 21:18:03 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:19965 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S312871AbSDCCRr>;
	Tue, 2 Apr 2002 21:17:47 -0500
Date: Tue, 2 Apr 2002 18:17:38 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: IrDA patches on the way...
Message-ID: <20020402181738.A24912@bougret.hpl.hp.com>
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

        Hi Linus,

	Do I need to say more ? A new batch of IrDA patches that have
been waiting on my web page and tested intensively with 2.5.7-SMP
(Marcelo will have to wait for his turn).
	This mostly include some race conditions in LAP and discovery,
correcting my previous IrNET fix and final fixing of the USB driver.
	Not included in this batch is the LSAP scheduler and my
partial rewrite of IrTTP, that will have to wait. Martin also promised
me a new version of the vlsi driver.
        Have fun...

        Jean

-------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir256_w83977af_bus_to_virt.diff :
-------------------------------
	o [CRITICA] Fix w83977af_ir FIR drivers for new DMA API
	<PCI FIR drivers are still broken and need fixing>

ir257_trivial_fixes-3.diff :
--------------------------
	o [CORRECT] Handle signals while IrSock is blocked on Tx
	o [CORRECT] Fix race condition in LAP when receiving with pf bit
	o [CRITICA] Prevent queuing Tx data before IrComm is ready
	o [FEATURE] Warn user of common misuse of IrLPT

ir257_sys_max_tx-2.diff :
-----------------------
	o [FEATURE] Allow tuning of Max Tx MTU to workaround spec contradiction

ir256_irnet_disc_ind_again.diff :
-------------------------------
	o [CORRECT] Correct fix for IrNET disconnect indication :
	  if socket is not connected, don't hangup, to allow passive operation

ir257_discovery_fixes.diff :
--------------------------
	<Need to apply after ir257_trivial_fixes-3.diff to avoid "offset">
	o [FEATURE] Propagate mode of discovery to higher protocols
	o [CORRECT] Disable passive discovery in ircomm and irlan
	  Prevent client and server to simultaneously connect to each other
	o [CORRECT] Force expiry of discovery log on LAP disconnect

ir257_usb_disconnect_atomic-2.diff :
----------------------------------
	o [CRITICA] Fix race condition between disconnect and the rest
	o [CRITICA] Force synchronous unlink of URBs in disconnect
	o [CRITICA] Cleanup instance if disconnect before close
        <Following patch from Martin Diehl>
	o [CRITICA] Call usb_submit_urb() with GPF_ATOMIC

ir257_nsc_ob6100.diff :
---------------------
        <Following patch from Kevin Thayer>
	o [FEATURE] Handle what is probably a new variant of NSC chip

ir257_irtty_stats.diff :
----------------------
        <Following patch from Frank Becker>
	o [FEATURE] Update dev tx stats at the right time
