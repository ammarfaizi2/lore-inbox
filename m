Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWJ2Qmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWJ2Qmv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWJ2Qm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:42:29 -0500
Received: from cantor2.suse.de ([195.135.220.15]:40929 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965289AbWJ2Qm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:42:27 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/7] header and stubs for paravirtualizing critical operations
Date: Sun, 29 Oct 2006 08:40:07 -0800
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de,
       linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <20061029024603.317829000@sous-sol.org>
In-Reply-To: <20061029024603.317829000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610290840.08231.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you add a high level comment to entry.S what paravirt mode
is all about and perhaps a quick cheat sheet on the macros?

> +/* SMP boot always wants to use real time delay to allow sufficient time
> for + * the APs to come online */
> +#define USE_REAL_TIME_DELAY

That's ugly. Can't you call different wait functions for that case instead?

> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#else
> +static inline void init_IRQ(void)
> +{
> +	native_init_IRQ();
> +}
> +#endif /* CONFIG_PARAVIRT */

You could probably avoid a lot of ifdefs by strategic use of 
__attribute__((weak))

> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#else

This is probably a good candidate for rename to native + wrapper
macros too. Otherwise we'll always have to hack two different
places later.

-Andi
