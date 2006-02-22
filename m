Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWBVUpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWBVUpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWBVUpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:45:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:46748 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751404AbWBVUpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:45:35 -0500
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with NETIF_F_HIGHDMA
References: <43FCB1B3.8090101@acm.org>
From: Andi Kleen <ak@suse.de>
Date: 22 Feb 2006 21:45:30 +0100
In-Reply-To: <43FCB1B3.8090101@acm.org>
Message-ID: <p73lkw32kd1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> writes:

> I was looking at a problem with a new system we are trying to get up and
> running.  It has a 32-bit only PCI network device, but is a 64-bit
> (x86_64) system.  Looking at the code for NETIF_F_HIGHDMA (which, when
> not set on a PCI network device, means that it cannot do 64-bit
> accesses) in net/core/dev.c, it seems wrong to me.

> It is dependent on HIGHMEM, but HIGHMEM has nothing to do with 32/64 bit
> accesses.  On 64-bit systems, HIGHMEM is not set, thus the network code
> will pass any address (including those >32bits) to the driver.  Plus,
> highmem on 32-bit systems may very well be 32-bit accessible, possibly
> resulting in unecessary copies.  AFAICT, the current code will only work
> with i386 and PAE and is sub-optimal.

x86-64 uses the PCI DMA API to handle this. NETIF_F_HIGHDMA is only
a i386 specific hack, mostly to work around the fact that not all
memory might be accessible from the CPU and thus break PIO drivers.
This problem doesn't exist on 64bit.

-Andi
