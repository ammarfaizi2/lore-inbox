Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVJQQlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVJQQlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVJQQlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:41:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:16609 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750797AbVJQQla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:41:30 -0400
From: Andi Kleen <ak@suse.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch] Re: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
Date: Mon, 17 Oct 2005 18:41:39 +0200
User-Agent: KMail/1.8
Cc: nyk <nyk@giantx.co.uk>, lkml <linux-kernel@vger.kernel.org>
References: <20051017144900.GA2942@giantx.co.uk> <Pine.LNX.4.61.0510171828440.5555@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.61.0510171828440.5555@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171841.39868.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 18:33, Tim Schmielau wrote:

>
> [Looks like you are on x86_64, as i386 compiles fine]
>
> Actually, <asm-x86_64/atomic.h> seems to need <asm/types.h> for the
> declaration of u32.
> The patch below makes NTFS compile on x86_64 for me. Andi?
>
> Tim

-mm specific problem caused by the bluesmoke merges.

IMHO the right fix is to put that atomic scrub thingy into another include
file. It seems to cause major additional include dependencies and 
is only used in a single file right now.

-Andi

>
> --- linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h	2005-10-17
> 17:48:12.000000000 +0200 +++
> linux-2.6.14-rc4-mm1-build/include/asm-x86_64/atomic.h	2005-10-17
> 18:20:19.000000000 +0200 @@ -2,6 +2,7 @@
>  #define __ARCH_X86_64_ATOMIC__
>
>  #include <linux/config.h>
> +#include <asm/types.h>
>
>  /* atomic_t should be 32 bit signed type */
