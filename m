Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317979AbSGPUvB>; Tue, 16 Jul 2002 16:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSGPUvA>; Tue, 16 Jul 2002 16:51:00 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:46036 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317979AbSGPUu7>;
	Tue, 16 Jul 2002 16:50:59 -0400
Date: Tue, 16 Jul 2002 13:53:49 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches on the way...
Message-ID: <20020716135349.A28412@bougret.hpl.hp.com>
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

	Hi Jeff,

	I was fortunate enough to receive some very important driver
updates that I had been waiting for a while, so I'm sending you the
current content of my patch queue.
	Also included is patch for bugs found by the Stanford checker
and an update of MAINTAINERS to point to to proper mailing list. Also,
now the non-modular init is 100% proper.
	Patches tested on 2.5.25.

	Have fun...

	Jean

-----------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir255_hashbin_fixes-2.diff :
--------------------------
	o [CRITICA] Remove correct IAS Attribute/Object even if name is dup'ed
	o [CORRECT] Make irqueue 64 bit compliant (__u32 -> long)
	o [FEATURE] Don't use random handle for IrLMP handle, use self
		Remove dependancy on random generator in stack init

vlsi_ir-2.5.24-v0.4-patch :
-------------------------
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

ir255_donauboe.diff :
-------------------
	        <Following patch from Martin Lucina & Christian Gennerat>
	o [FEATURE] Rewrite of the toshoboe driver using documentation
	o [FEATURE] Support Donau oboe chipsets.
	o [FEATURE] FIR support
	o [CORRECT] Probe chip before opening
	o [FEATURE] suspend/resume support
	o [FEATURE] Numerous other improvements/cleanups
		<Currently, we keep the old toshoboe driver around>
	o [FEATURE] Config.help for ma600 driver (unrelated ;-)

ir255_checker.diff-2 :
--------------------
	o [CORRECT] Fix two bugs found by the Stanford checker

ir255_nsc_speed-4.diff :
----------------------
	o [FEATURE] Cleanly change speed back to 9600bps
	o [CORRECT] Change speed under spinlock/irq disabled

ir255_comments.diff :
-------------------
	o [FEATURE] Update MAINTAINERS file
	o [FEATURE] Update OHCI comment in irda-usb
