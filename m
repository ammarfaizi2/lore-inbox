Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTHCUPz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271293AbTHCUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:15:55 -0400
Received: from mail1.scram.de ([195.226.127.111]:59908 "EHLO mail1.scram.de")
	by vger.kernel.org with ESMTP id S270234AbTHCUPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:15:51 -0400
Date: Sun, 3 Aug 2003 22:15:09 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: dahinds@users.sourceforge.net
Subject: PCI1410 Interrupt Problems
Message-ID: <Pine.LNX.4.44.0308032205210.25885-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: ---- Start SpamAssassin results
  0.90 points, 5 required;
  *  0.0 -- Message-Id indicates a non-spam MUA (Pine)
  *  0.9 -- RBL: Received via a relay in dnsbl.njabl.org
  [RBL check: found 174.124.226.217.dnsbl.njabl.org., type: 127.0.0.3]
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when using this PCI Cardbus bridge, i got an interrupt assigned to the
card by the BIOS, but no interrupts were ever delivered, at all. So no
insert/remove events have been handled and devices couldn't generate
interrupts, as well:

02:0a.0 Class 0607: 104c:ac50 (rev 01)
02:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 9
        Memory at 14000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 14400000-147ff000 (prefetchable)
        Memory window 1: 14800000-14bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

It looks like the designers of this card "forgot" to put a sane
configuration of the Multifunction Routing Register (0x8C) in their
EEPROM. After setting up the INTA output pin of the PCI1410, the device
started to work like a charm :-)

This i added to yenta_config_init():

config_writew(socket, 0x8C, 0x02);

I'm not sure if this will help with all of these devices of if it even
makes problems on others. But it might be an idea to add a config option
for this hack...

Thanks,
--jochen

