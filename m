Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbTIPLzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbTIPLzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:55:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16020 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261833AbTIPLzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:55:15 -0400
Date: Tue, 16 Sep 2003 12:54:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916115457.GH26576@mail.jlokier.co.uk>
References: <200309151228.h8FCSQ2B022357@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309151228.h8FCSQ2B022357@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> extern inline void prefetch(const void *x)
> {
>         if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
>                 return;         /* Some athlons fault if the address is bad */
>         alternative_input(ASM_NOP4,
>                           "prefetchnta (%1)",
>                           X86_FEATURE_XMM,
>                           "r" (x));
> }
> 
> A dynamic test at each occurrence. That's truly horrible.

Is there any reason why alternative_input() cannot be used by itself?
Another synthetic feature bit would sort this out, making a kernel
that always works on AMD, and is optimised for AMD if the fixup is
configured in: X86_FEATURE_XMM_PREFETCH.

-- Jamie
