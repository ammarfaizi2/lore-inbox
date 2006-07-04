Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWGDIOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWGDIOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWGDIOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:14:37 -0400
Received: from ns.suse.de ([195.135.220.2]:8130 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751189AbWGDIOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:14:37 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Date: Tue, 4 Jul 2006 10:14:30 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060704072832.GB5902@frankl.hpl.hp.com>
In-Reply-To: <20060704072832.GB5902@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041014.30162.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -urNp linux-2.6.17.2.orig/arch/x86_64/ia32/ptrace32.c linux-2.6.17.2-tif/arch/x86_64/ia32/ptrace32.c
> --- linux-2.6.17.2.orig/arch/x86_64/ia32/ptrace32.c	2006-06-17 18:49:35.000000000 -0700
> +++ linux-2.6.17.2-tif/arch/x86_64/ia32/ptrace32.c	2006-06-30 09:02:16.000000000 -0700

Added thanks. But I had to fix it up by hand because of conflicts. 
Please submit patches against mainline, not stable.

>        if (t->flags & _TIF_ABI_PENDING)
>-               t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32);
>+               t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32 | _TIF_DEBUG);

This xor must be obviously outside the if(). I fixed that up too
by changing it to an unconditional clear.

-Andi
