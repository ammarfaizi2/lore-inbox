Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267944AbUGaMTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267944AbUGaMTq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 08:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUGaMTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 08:19:46 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:45829 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S267944AbUGaMTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 08:19:45 -0400
Date: Sat, 31 Jul 2004 14:19:44 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: EHCI / pci power state / suspend annoying interactions
Message-ID: <20040731121944.GA47191@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EHCI on the latitude x300 does not have D2 capability:

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Dell Computer Corporation: Unknown device 014f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at e0100000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
   

That fails suspend-to-ram because dev->suspend which is
usb_hcd_pci_suspend calls pci_set_power_state to request level D2,
which fails with -EIO.  The error is propagated back and the suspend
aborts.  What should actually happen in that case?

  OG.
