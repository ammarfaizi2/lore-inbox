Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVINQ1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVINQ1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVINQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:27:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2486
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030240AbVINQ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:27:22 -0400
Date: Wed, 14 Sep 2005 09:26:50 -0700 (PDT)
Message-Id: <20050914.092650.99910742.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       torvalds@osdl.org, akpm@osdl.org, ink@jurassic.park.msu.ru,
       kaos@sgi.com, greg@kroah.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.14-rc1] pci: only call pci_restore_bars at boot
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43283CDC.3070603@pobox.com>
References: <09142005095242.32027@bilbo.tuxdriver.com>
	<43283CDC.3070603@pobox.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Wed, 14 Sep 2005 11:08:12 -0400

> This seems like it will break a lot of stuff that -does- need the BARs 
> restored when resuming from D3.

I wasn't going to say anything about this ia64 workaround,
but yes I have to agree with Jeff, this change starts to
lose the whole point of the original change.

Why in the world can a PCI device not handle it's BARs being
rewritten, especially if we're just rewriting the same exact
values it had when we probed it beforehand?

IA64 could handle the necessary cases in it's PCI config space
access methods.  Ugly, but keeps the core clean and limits the
avoidance to the cases that really truly cannot handle the BAR
rewrites.
