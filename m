Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751959AbWJMWuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWJMWuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWJMWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:50:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44165 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751959AbWJMWuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:50:18 -0400
Subject: Re: [PATCH] serial: handle pci_enable_device() failure upon resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>,
       linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061013131516.227e99ee.akpm@osdl.org>
References: <20061012014720.GA12935@havoc.gtf.org>
	 <20061013075953.GC28654@flint.arm.linux.org.uk>
	 <20061013131516.227e99ee.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 00:15:43 +0100
Message-Id: <1160781343.25218.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 13:15 -0700, ysgrifennodd Andrew Morton:
> Right now, we get silent failure *and* a compile-time warning.  It's hard
> to see how that situation could be made worse.

I support Russells NAK but for another reason. You can't use printk in
the paths of a serial driver that may be the console. There is already a
whole ordering issue here and I'm not convinced it is handled correctly
reviewing the diff. Printks will make it worse in any driver (and waste
memory on handling impossible untestable situations that don't appen)

The printk case and serial first ordering want fixing correctly because
serial console is about the only sane way to debug resume in the first
place.

Alan
