Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbSJRBBT>; Thu, 17 Oct 2002 21:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSJRBBT>; Thu, 17 Oct 2002 21:01:19 -0400
Received: from zero.aec.at ([193.170.194.10]:8463 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262641AbSJRBBS>;
	Thu, 17 Oct 2002 21:01:18 -0400
To: Christoph Hellwig <hch@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
References: <20021017102146.A17642@sgi.com> <20021017224410.A25801@sgi.com>
From: Andi Kleen <ak@muc.de>
Date: 18 Oct 2002 03:07:08 +0200
In-Reply-To: <20021017224410.A25801@sgi.com>
Message-ID: <m37kggpnb7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@sgi.com> writes:

> 
> +#if defined __ia64__
> +#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%lx.\n"
> +#define JID_ERR2 "csa user job accounting write error %d, jid 0x%lx\n"
> +#define JID_ERR3 "Can't disable csa user job accounting jid 0x%lx\n"
> +#define JID_ERR4 "csa user job accounting disabled, jid 0x%lx\n"
> +#else
> +#define JID_ERR1 "do_csa_acct:  No job table entry for jid 0x%llx.\n"
> +#define JID_ERR2 "csa user job accounting write error %d, jid 0x%llx\n"
> +#define JID_ERR3 "Can't disable csa user job accounting jid 0x%llx\n"
> +#define JID_ERR4 "csa user job accounting disabled, jid 0x%llx\n"
> +#endif
> 
> Umm, this would be #if __LP64__.  But please just always cast
> to long long instead.

__LP64__ is a HP/IA64ism, which is not necessarily defined on other
64bit platforms. The proper way to test for 64bit in the kernel is

#include <linux/types.h>

...

#if BITS_PER_LONG==64

#endif

-Andi
