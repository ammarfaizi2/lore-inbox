Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUBGEmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266773AbUBGEmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:42:08 -0500
Received: from nevyn.them.org ([66.93.172.17]:55715 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266461AbUBGEmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:42:03 -0500
Date: Fri, 6 Feb 2004 23:42:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Message-ID: <20040207044203.GA10944@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started getting this, every 24 hours or so:

irq 19: nobody cared!
Call Trace:
 [<c010d38a>] __report_bad_irq+0x2a/0x90
 [<c010d480>] note_interrupt+0x70/0xb0
 [<c010d7c0>] do_IRQ+0x160/0x1a0
 [<c0105000>] _stext+0x0/0x60
 [<c010b8d8>] common_interrupt+0x18/0x20
 [<c0108990>] default_idle+0x0/0x40
 [<c0105000>] _stext+0x0/0x60
 [<c01089bc>] default_idle+0x2c/0x40
 [<c0108a4b>] cpu_idle+0x3b/0x50
 [<c04b64a0>] unknown_bootoption+0x0/0x120
 [<c04b6926>] start_kernel+0x1a6/0x1f0
 [<c04b64a0>] unknown_bootoption+0x0/0x120

handlers:
[<f886b290>] (au_isr+0x0/0xb0 [au8830])
Disabling IRQ #19

and then sound doesn't work for a while.

There's a good chance this is my fault.  IRQ 19 is:

 19:   18500001          0   IO-APIC-level  au88xx

and the au88xx driver is an out-of-tree driver that was developed on
2.4/early-2.5, and I ported it to 2.6 myself.  It worked flawlessly on
2.6.0-test7; has something changed in how interrupt handlers are required to
behave?

[Just ask if you actually want the source to this driver... I don't know
enough about the card to actually submit it to Linus's tree and the driver's
original authors aparently didn't care to.]

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
