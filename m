Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTLDNgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTLDNgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:36:51 -0500
Received: from rat-5.inet.it ([213.92.5.95]:8597 "EHLO rat-5.inet.it")
	by vger.kernel.org with ESMTP id S261957AbTLDNgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:36:48 -0500
From: Paolo Ornati <ornati@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: ISDN in 2.6.0-testX
Date: Thu, 4 Dec 2003 14:32:46 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041432.46678.ornati@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone working to get ISDN (hisax driver ;) work in 2.6.0-textX kernels?

My problem is a "totally kernel freeze" trying to load hisax module... this 
happens in all 2.6.0-testX kernels.

My ISDN card: "Hamlet PCI ISDN CARD":

00:0d.0 Network controller: Cologne Chip Designs GmbH ISDN network 
controller [HFC-PCI] (rev 02)
        Subsystem: Cologne Chip Designs GmbH ISDN Board
        Flags: bus master, medium devsel, latency 16, IRQ 5
        I/O ports at 8400 [disabled] [size=8]
        Memory at df000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 1


My CONFIG: (2.6.0-testX)

# ISDN subsystem
#
CONFIG_ISDN_BOOL=y
 
#
# Old ISDN4Linux
#
CONFIG_ISDN=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y

#
# ISDN4Linux hardware drivers
#
 
#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m
 
#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_HISAX_MAX_CARDS=1
                                                                                                                               
#
# HiSax supported cards
#
CONFIG_HISAX_HFC_PCI=y


PROBLEM DESCRIPTION:
when I try to load the "hisax" module the kernel freezes, I can only push 
the reset button.
The last line printed is "HFC_PCI: resetting card".

Using some "printk" I found the point where the freeze happens:

drivers/isdn/hisax/hfc_pci.c  -->  hfcpci_reset(struct IsdnCardState *cs)
...
        /* Finally enable IRQ output */
        cs->hw.hfcpci.int_m2 = HFCPCI_IRQ_ENABLE;
        Write_hfc(cs, HFCPCI_INT_M2, cs->hw.hfcpci.int_m2);        <-- HERE!
        if (Read_hfc(cs, HFCPCI_INT_S2));
...

So the problem happens trying to enable IRQ on the ISDN Card....
Has anyone an idea of what can be wrong?
(The problem isn't about CONFIG_PREEMPT because I try with and without it).

Bye

-- 
	Paolo Ornati
	Linux v2.4.23

