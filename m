Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSHFUo0>; Tue, 6 Aug 2002 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHFUo0>; Tue, 6 Aug 2002 16:44:26 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:13519 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315634AbSHFUoY>;
	Tue, 6 Aug 2002 16:44:24 -0400
Date: Tue, 6 Aug 2002 13:48:00 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches on the way...
Message-ID: <20020806204800.GA11677@bougret.hpl.hp.com>
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

	Hi Marcelo,

	First, an apology. The changes were not as bad as I though and
I only had to fix a few patches (but I could not verify that
yesterday).
	This is my IrDA update for 2.4.20. Those IrDA patches are
mostly the same collection that went in 2.5.8-pre2. It fixes some
important bug, or are trivally obvious fixes. I also added some new
drivers that were added in 2.5.22. All stuff really safe.
	My remaining patch queue is still pretty full (including
Stanford checker bugs - see my web page), but that will wait for
later.
	Patches tested on 2.4.19 and recompiled on 2.4.20-pre1.

	Have fun...

	Jean

-----------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir240_trivial_fixes-3.diff :
--------------------------
	o [CORRECT] Handle signals while IrSock is blocked on Tx
	o [CORRECT] Fix race condition in LAP when receiving with pf bit
	o [CRITICA] Prevent queuing Tx data before IrComm is ready
	o [FEATURE] Warn user of common misuse of IrLPT

ir240_sys_max_tx-2.diff :
-----------------------
	o [FEATURE] Allow tuning of Max Tx MTU to workaround spec contradiction

ir240_irnet_disc_ind_again.diff :
-------------------------------
	o [CORRECT] Correct fix for IrNET disconnect indication :
	  if socket is not connected, don't hangup, to allow passive operation

ir240_discovery_fixes.diff :
--------------------------
	<Need to apply after ir240_trivial_fixes-3.diff to avoid "offset">
	o [FEATURE] Propagate mode of discovery to higher protocols
	o [CORRECT] Disable passive discovery in ircomm and irlan
	  Prevent client and server to simultaneously connect to each other
	o [CORRECT] Force expiry of discovery log on LAP disconnect

ir240_usb_disconnect-2.diff :
----------------------------------
	o [CRITICA] Fix race condition between disconnect and the rest
	o [CRITICA] Force synchronous unlink of URBs in disconnect
	o [CRITICA] Cleanup instance if disconnect before close

ir240_nsc_ob6100.diff :
---------------------
        <Following patch from Kevin Thayer>
	o [FEATURE] Handle what is probably a new variant of NSC chip

ir240_irtty_stats.diff :
----------------------
        <Following patch from Frank Becker>
	o [FEATURE] Update dev tx stats at the right time

ir240_expiry_fix.diff :
---------------------
	o [CORRECT] Make discovery expiry work properly for non default
		discovery period/timeout

ir240_mcp2120_act200l_ma600_drivers-2.diff :
------------------------------------------
	        <Following patch from Felix Tang>
	o [FEATURE] Dongle driver for mcp2120/crystal hardware
	        <Following patch from Shimizu Takuja/Gerhard Bertelsmann>
	o [FEATURE] Dongle driver for ActiSys 200L hardware
	        <Following patch from Leung/me>
	o [FEATURE] Dongle driver for Mobile Action MA600 hardware
