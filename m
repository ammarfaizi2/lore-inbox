Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVLNTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVLNTIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVLNTIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:08:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28123 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964890AbVLNTIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:08:16 -0500
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051214165549.GE7124@flint.arm.linux.org.uk>
References: <1134573803.25663.35.camel@localhost.localdomain>
	 <20051214165549.GE7124@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 19:08:08 +0000
Message-Id: <1134587288.25663.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 16:55 +0000, Russell King wrote:
> If we trigger this, we can assume that the port is dead anyway, or
> we're in a situation where the host CPU can not keep up with the
> data stream.

Not actually true in some cases.

- When your UART has a large FIFO and pretends to be an 8250 you can get
a 256 byte burst triggered by the box sleeping for a moment or the BIOS
SMI crap going to chat to the battery

- On a virtualised system this trap can trigger because the emulations
don't emulate the bit arrival and baud rate.

In both of those cases recovery is viable. For that matter so is
recovery when the user responds to the complaint message by unplugging
the cable, or where a long burst of framing errors hits you from a
misconfiguration.

Possibly the first two just argue for a larger limit ?

Alan

