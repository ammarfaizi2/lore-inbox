Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262223AbSJKAIU>; Thu, 10 Oct 2002 20:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262222AbSJKAIU>; Thu, 10 Oct 2002 20:08:20 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:14807 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262223AbSJKAIT>;
	Thu, 10 Oct 2002 20:08:19 -0400
Date: Thu, 10 Oct 2002 17:14:03 -0700
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches for 2.5.X on the way...
Message-ID: <20021011001403.GA6645@bougret.hpl.hp.com>
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

	A more "normal" IrDA update this time (drivers, bug fixes) to
flush my patch queue. Some of those patches have been on my web page
for far too long, rediffed on 2.5.41.
	Martin is working on the new irtty driver that should fix the
last remaining big problem with IrDA in 2.5.X. Hopefully you will see
that soon.
	Have fun...

	Jean

----------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir251_vlsi_v4-2.diff :
--------------------
	        <Following patch from Martin Diehl>
        * merge+sync with changes from recent kernels: pci_[sg]et_drvdata,
          __devexit_p, netdev->last_rx, irda header cleanup
        * add netdev tx_timeout which re-initializes the whole thing
        * add power management support consistent with pci driver api
        * major rework of the ring descriptor operations
        * make correct usage of consistent and streaming pci dma api
        * nuke last virt_to_bus() and friends
        * support MIR/FIR highspeed interaction pulse (SIP)
        * review all paths for packet-size issues (rx and tx)
        * fix an old issue requiring hw powercycle caused by a race
          between IrLAP and hardware when switching _back_ to default
          speed at LAP disconnect. This was opened by the complete async
          behaviour of netdev->xmit but didn't happen before your latency
          improvements went into the stack.
        * add driver status readout under /proc/driver/vlsi_ir/irda%
          For 2.5, this will probably go into driverfs once things have
          stabilized.
        * fix potential deadlock in speed changing code
        * make identical driver working for both 2.4 and 2.5
        * add __attribute__((packed)) to hardware-exposed struct
        * add suggested pci_dma_prep_single() to flush cpu cache before
          streaming dma buffer gets reused for busmastering

ir254_donauboe-2.diff :
---------------------
	        <Following patch from Martin Lucina & Christian Gennerat>
	o [FEATURE] Rewrite of the toshoboe driver using documentation
	o [FEATURE] Support Donau oboe chipsets.
	o [FEATURE] FIR support
	o [CORRECT] Probe chip before opening
	o [FEATURE] suspend/resume support
	o [FEATURE] Numerous other improvements/cleanups
	o [CORRECT] (me) Remove save_flags()/cli() for spinlock
		<Currently, we keep the old toshoboe driver around>
	o [FEATURE] Config.help for ma600 driver (unrelated ;-)

ir251_export_crc-2.diff :
-----------------------
	o [FEATURE] Export CRC16 helper so that drivers can use it

ir251_ircomm_uninit_fix-6.diff :
------------------------------
	o [FEATURE] Fix spelling UNITIALISED => UNINITIALISED
	o [CORRECT] Accept data from TTY before link initialisation
		This seems necessary to avoid chat (via pppd) dropping chars
	o [CRITICA] Remember allocated skb size to avoid to over-write it
	o [FEATURE] Remove  LM-IAS object once connected
	o [CORRECT] Avoid declaring link ready when it's not true

ir251_qos_param-2.diff :
----------------------
	o [FEATURE] Fix some comments
	o [FEATURE] printk warning when we detect buggy QoS from peer
	o [CORRECT] Workaround NULL QoS bitfields
	o [CORRECT] Workaround oversized QoS bitfields
	o [FEATURE] Add sysctl "max_tx_window" to limit IrLAP Tx Window

ir251_lmp_timer_race-2.diff :
---------------------------
	o [CORRECT] Start timer before sending event to fix race condition
	o [FEATURE] Improve the IrLMP event debugging messages.
