Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTIIVKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTIIVKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:10:17 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:24725 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264531AbTIIVKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:10:09 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309091354471.695-100000@cherise>
References: <Pine.LNX.4.44.0309091354471.695-100000@cherise>
Message-Id: <1063141771.639.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 23:09:32 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] Power: call save_state on PCI devices along with
	suspend
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 23:04, Patrick Mochel wrote:
> > Don't we want that ? It will help if any driver currently relies on
> > the save_state callback to be called...
> 
> Bah, this patch slipped my mind. How many drivers actually use 
> ->save_state()? From a quick look, it looks like: 
> 
> 1. drivers/ide/pci/sc1200.c
> 2. drivers/net/irda/vlsi_ir.c
> 3. drivers/scsi/nsp32.c
> 4. drivers/serial/8250_pci.c
> 
> Of those, only (1) actually does anything interesting. (2) and (3) only 
> print a message, and (4) appears to be trivial to fold into ->suspend(). 
> 
> What do you think about just fixing those up? 

Well... that wouldn't help with off-tree drivers...

What I mean here is that our PCI driver API defines save_state, we shall
either "support" it some way, or get rid of it completely... but then we
lose the ability to move a PCI driver back & forth with 2.4 ... (do we
care ?)

If you prefer just fixing those 4 ones, then let's get rid of the
save_state field in pci_driver completely...

Ben.


