Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWCMNTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWCMNTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWCMNTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:19:55 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:49547 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751751AbWCMNTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:19:54 -0500
Message-ID: <44157178.90507@drzeus.cx>
Date: Mon, 13 Mar 2006 14:19:52 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, cramerj@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: e1000 with serdes only shows a fiber port
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having problems with the e1000 card in a Dell Poweredge 1855. This
model has support for both copper and fiber and has two cards on the PCI
bus (might supposed to be one for each type).

The problem is that both of these cards show only FIBER as a supported
port type, but I only have plain copper connectors attached to the
machine. There is no link detected at either end, except for a small
flicker just when the e1000 module is loaded.

The hardware doesn't seem to be the problem since it works nicely in
Windows on the same machine.

The device id of both controllers is 8086:107b, meaning SERDES. However,
if I look into e1000_ethtool.c:e1000_get_settings() I can see a test for
copper media, then and else assuming that the card is a fiber card.
Since this card can do both I'm guessing this code is broken.

I'm in rather desperate here since this is a blade server (i.e. no
chance of putting in another network card). :/

Rgds
Pierre

lspci:

05:04.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet
Controller (rev 03)
        Subsystem: Dell: Unknown device 018a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 185
        Memory at fe7e0000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at dcc0 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-

05:04.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet
Controller (rev 03)
        Subsystem: Dell: Unknown device 018a
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 193
        Memory at fe7c0000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at dc80 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-

ethtool: (eth1 is identical)

Settings for eth0:
        Supported ports: [ FIBRE ]
        Supported link modes:   1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: Unknown! (65535)
        Duplex: Unknown! (255)
        Port: FIBRE
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Supports Wake-on: umbg
        Wake-on: d
        Current message level: 0x00000007 (7)
        Link detected: no

