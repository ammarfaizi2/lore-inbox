Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFKFdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFKFdg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 01:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFKFdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 01:33:36 -0400
Received: from science.horizon.com ([192.35.100.1]:23343 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261293AbVFKFdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 01:33:32 -0400
Date: 11 Jun 2005 05:33:31 -0000
Message-ID: <20050611053331.9203.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> It would be pretty strange, since the PCI spec (afaik, and for pretty
> obvious reasons) disallows two negative bridges on the same bus (and you
> already have the other mobile bridge there), but it's technically possible
> if they just have different priorities for how fast they react to a PCI
> address cycle and claim it.

Actually, that's not possible, because no difference is permitted.

When the initiator drives an address, there are 4 cycles during which
a targer can assert DEVSEL# to indicate that it will claim the bus
cycle.  The first three are known as "fast", "medium", and "slow", and
are for normal devices.

The fourth cycle us reserved for subtractive decode.  A subtractive decode
devices must assert DEVSEL# on this cycle and no other.  (If and only if
no other device has claimed it by asserting DEVSEL# already.)

On the fifth cycle, the initiator is permitted to perform a master abort
and fail the operation.  Because the initator could be any random bus master
card, cards are going to be installed in a system, you can't rely on it
giving a bridge any longer to assert DEVSEL#.
