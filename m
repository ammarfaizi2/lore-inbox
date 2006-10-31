Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423763AbWJaWa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423763AbWJaWa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423762AbWJaWa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:30:28 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:63559 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1423724AbWJaWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:30:27 -0500
To: Matthew Wilcox <matthew@wil.cx>, John Partridge <johnip@sgi.com>
Cc: "Richard B. Johnson" <jmodem@AbominableFirebug.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <20061024214724.GS25210@parisc-linux.org>
	<adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org>
	<20061024.154347.77057163.davem@davemloft.net>
	<aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com>
	<20061031195312.GD5950@mellanox.co.il>
	<019301c6fd2c$044d7010$0732700a@djlaptop>
	<20061031204717.GG26964@parisc-linux.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 31 Oct 2006 14:30:13 -0800
In-Reply-To: <20061031204717.GG26964@parisc-linux.org> (Matthew Wilcox's message of "Tue, 31 Oct 2006 13:47:17 -0700")
Message-ID: <ada4ptkt8y2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Oct 2006 22:30:15.0077 (UTC) FILETIME=[22D33550:01C6FD3C]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm beginning to think Michael Tsirkin has the only solution to this
 > -- architectures need to check that their hardware blocks until the
 > config write completion has occurred (and if not, simulate that it has
 > in software).

OK, I guess I'm convinced.  The vague language in the base PCI 3.0
spec about "dependencies" made me think that a read of a config
register had to wait until all previous writes to the same register
are done.  So I'll drop this patch for now.

John, you'll need to try and come up with a way to solve this in the
Altix implementation of pci_write_config_xxx().

 - R.
