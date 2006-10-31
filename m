Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423610AbWJaU2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423610AbWJaU2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423608AbWJaU2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:28:44 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:42642 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1423607AbWJaU2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:28:42 -0500
Date: Tue, 31 Oct 2006 22:28:00 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, jeff@garzik.org,
       matthew@wil.cx, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061031202800.GA6866@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <ada8xiwtg81.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada8xiwtg81.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Subject: Re: Ordering between PCI config space writes and MMIO reads?
> 
>  > Here's what I don't understand: according to PCI rules, pci config read
>  > can bypass pci config write (both are non-posted).
>  > So why does doing it help flush the writes as the comment claims?
> 
> No, I don't believe a read of a config register can pass a write of
> the same register.  (Someone correct me if I'm wrong)

It can if PCI-X/PCI-Ex spec is anything to go by.

For example, see table 2-23, transaction ordering rules, in the PCI-express
spec: it is marked as "Y/N: there are no requirements.  The second transaction
may optionally pass the first transaction or be blocked by it."

In typical systems the OS should take care not to start a new
non-posted transaction before the previous one completed.
In particular, all intel and ppc systems I've seen simply block the CPU
unti the split completion arrives.

I find it hard to believe that Altix des not supply a way to check
that completion for config write transaction has arrived.


-- 
MST
