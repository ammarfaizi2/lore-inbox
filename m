Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVGHDL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVGHDL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 23:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVGHDLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 23:11:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7077
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262479AbVGHDLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 23:11:49 -0400
Date: Thu, 07 Jul 2005 20:11:03 -0700 (PDT)
Message-Id: <20050707.201103.41635951.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: ink@jurassic.park.msu.ru, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR
 values in pci_enable_device_bars
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708005701.GA13384@tuxdriver.com>
References: <20050705224620.B15292@flint.arm.linux.org.uk>
	<20050706033454.A706@den.park.msu.ru>
	<20050708005701.GA13384@tuxdriver.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Thu, 7 Jul 2005 20:57:04 -0400

> Problem: pci_update_resource doesn't exist for sparc64.

Yes, the drivers/pci/setup-res.c code isn't compiled in on
sparc64 because it assumes a totally different model of
PCI bus probing than we use on sparc64.

On sparc64, we check out if the boot firmware has assigned
the PCI resources for the device, and if so we just leave
things alone.  We also make sure that the firmware device
tree properties mostly match what the PCI config space registers
say and we spit out a warning message if not.
