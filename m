Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbULBHGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbULBHGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbULBHGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:06:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:64169 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261566AbULBHGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:06:21 -0500
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
	performance tests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <41AEBD95.7030804@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	 <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
	 <41AEBD95.7030804@pobox.com>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 18:05:48 +1100
Message-Id: <1101971149.5593.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 02:00 -0500, Jeff Garzik wrote:

> 
> 2.6.9:
> 	bitbang ATA taskfile registers
> 	queue_work()
> 	workqueue thread bitbangs ATA data register (read id page)
> 
> So I wonder if <something> doesn't like CPU 0 sending I/O traffic to the 
> on-board SATA PCI device, then immediately after that, CPU 1 sending I/O 
> traffic.
> 
> Anyway, back to debugging...  :)

They may not end up in order if they are stores (the stores to the
taskfile may be out of order vs; the loads/stores to/from the data
register) unless you have a spinlock protecting both or a full sync (on
ppc), but then, I don't know the ordering things on x86_64. This could
certainly be a problem on ppc & ppc64 too.

Ben.


