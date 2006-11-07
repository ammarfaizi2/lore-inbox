Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753048AbWKGMt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbWKGMt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWKGMt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:49:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32227 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1753048AbWKGMt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:49:27 -0500
Date: Tue, 7 Nov 2006 13:49:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 12/14] KVM: x86 emulator
Message-ID: <20061107124912.GA23118@elf.ucw.cz>
References: <454E4941.7000108@qumranet.com> <20061105204035.DF0F62500A7@cleopatra.q>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105204035.DF0F62500A7@cleopatra.q>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> Add an x86 instruction emulator for kvm.
> 
> We need an x86 emulator for the following reasons:
> 
> - mmio instructions are intercepted as page faults, with no information about
>   the operation to be performed other than the virtual address
> - real-mode is emulated using the old-fashined vm86 mode, with no special
>   intercepts for the privileged instructions, so we need to emulate mov cr,
>   lgdt, and lidt
> - we plan to cache shadow page tables in the future, so that a guest context
>   switch will not throw away all the mappings we worked so hard to build.  but
>   cachine page tables means write-protecting the guest page tables to keep
>   them in sync, so any writes to the guest page tables need to be emulated
> 
> The emulator was lifted from the Xen hypervisor.
> 
> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
> Signed-off-by: Avi Kivity <avi@qumranet.com>
> 
> Index: linux-2.6/drivers/kvm/x86_emulate.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/kvm/x86_emulate.c
> @@ -0,0 +1,1370 @@
> +/******************************************************************************
> + * x86_emulate.c
> + *
> + * Generic x86 (32-bit and 64-bit) instruction decoder and emulator.
> + *
> + * Copyright (c) 2005 Keir Fraser
> + *
> + * Linux coding style, mod r/m decoder, segment base fixes, real-mode
> + * privieged instructions:
> + *
> + * Copyright (C) 2006 Qumranet
> + *
> + *   Avi Kivity <avi@qumranet.com>
> + *   Yaniv Kamay <yaniv@qumranet.com>
> + *
> + * From: xen-unstable 10676:af9809f51f81a3c43f276f00c81a52ef558afda4
> + */

This needs GPL, I'd say.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
