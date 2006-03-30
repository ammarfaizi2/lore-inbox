Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWC3S2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWC3S2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWC3S2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:28:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32897 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751363AbWC3S2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:28:09 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioremap_cached()
References: <20060330164120.GJ13590@parisc-linux.org>
From: Andi Kleen <ak@suse.de>
Date: 30 Mar 2006 20:27:53 +0200
In-Reply-To: <20060330164120.GJ13590@parisc-linux.org>
Message-ID: <p73zmj7949i.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> We currently have three ways for getting access to device memory --
> ioremap(), ioremap_nocache() and pci_iomap().  99% of the callers of
> ioremap() are doing it to access device registers, and really, really
> want to use ioremap_nocache() instead.  I presume nobody notices on PCs
> because they have write-through caches, but it ought to trip up people
> trying to flush writes.

Actually MTRRs take care of that on x86.
So essentially on x86 ioremap() for devices is already ioremap_uncached()
And ioremap on memory is cached.

That's nice and simple semantics that other platforms can emulate too.
Doing things differently will just cause pain for the other platforms
when they have to fix up drivers all the time.

It all works fine until someone wants WC too. I would rather add a 
ioremap_wc(), that would be more useful.

-Andi
