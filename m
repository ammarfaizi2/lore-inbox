Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUFMQXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUFMQXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 12:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUFMQXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 12:23:31 -0400
Received: from ozlabs.org ([203.10.76.45]:56483 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265199AbUFMQXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 12:23:30 -0400
Date: Mon, 14 Jun 2004 02:21:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Roland Dreier <roland@topspin.com>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ppc64 out_be64
Message-ID: <20040613162150.GA25389@krispykreme>
References: <521xkk77xh.fsf@topspin.com> <1087141822.8210.176.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087141822.8210.176.camel@gaston>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Ugh ? The syntax of std is std rS, ds(rA), so your fix doesn't look
> good to me, and it definitely builds with the current syntax, though I
> agree the type is indeed wrong. I also spotted another bug where we
> forgot to change an eieio into sync in there though.
> 
> Does this totally untested patch works for you ?

It would be nice to make val unsigned long too :)

Anton

> @@ -358,7 +358,7 @@
>  
>  static inline void out_be64(volatile unsigned long *addr, int val)
>  {
> -	__asm__ __volatile__("std %1,0(%0); sync" : "=m" (*addr) : "r" (val));
> +	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
>  }
>  
>  #ifndef CONFIG_PPC_ISERIES 
