Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVEQUYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVEQUYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVEQUYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:24:35 -0400
Received: from mail.suse.de ([195.135.220.2]:51143 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261922AbVEQUY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:24:29 -0400
Date: Tue, 17 May 2005 22:24:28 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, "Yu, Luming" <luming.yu@intel.com>,
       "Guo, Racing" <racing.guo@intel.com>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] x86 port lockless MCE quirky bank0
Message-ID: <20050517202428.GD307@wotan.suse.de>
References: <Pine.LNX.4.61.0505172107490.5585@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505172107490.5585@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if ((c->x86_vendor == X86_VENDOR_AMD ||
> +	     c->x86_vendor == X86_VENDOR_INTEL) && c->x86 == 6) {
> +		/*
> +		 * Intel P6 cores go bang quickly when bank0 is enabled.
> +	 	 * Some Athlons cause spurious MCEs when bank0 is enabled.
> +		 */
> +		quirky_bank0 = 1;
> +	}

That's wrong on K8 AMD machines at least. You need to check c->x86
there too.

And better would be to just do bank[0] = 0 instead of
adding the new variable.

-Andi

P.S.: Also Yu Luming can you please submit an updated patch that keeps mce.c
in arch/x86_64 like we discussed earlier?

