Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUA1QPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUA1QPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:15:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:43668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266033AbUA1QPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:15:43 -0500
Date: Wed, 28 Jan 2004 08:15:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <20040128085825.A3591@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0401280811540.19358@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org> <20040128085825.A3591@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Russell King wrote:
> 
> What if the failing PCI access happened in an interrupt routine?
> (I'm thinking of the situation where you may need to read the PCI
> status registers to find out whether an error occurred.)
> 
> Also, for that matter, what if a network device receives an abort
> while performing BM-DMA?
> 
> Do we even care about either of these two scenarios?

We do, and the people who care about readX_check() had better be careful.
Quite possibly the "clear_pcix_error()" has to get a lock and disable
interrupts, and the "read_pcix_error()" routine would release the lock.
But that depends on the hardware - details like whether hardware can track
individual errors on multiple CPU's or not.

And keep in mind, 99% of all people won't ever care.

		Linus
