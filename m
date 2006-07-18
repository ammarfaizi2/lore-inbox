Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWGRKeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWGRKeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWGRKeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:34:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28179 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750770AbWGRKeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:34:06 -0400
Date: Tue, 18 Jul 2006 12:34:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC PATCH 02/33] Add sync bitops
Message-ID: <20060718103404.GC3748@stusta.de>
References: <20060718091807.467468000@sous-sol.org> <20060718091948.747619000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718091948.747619000@sous-sol.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 12:00:02AM -0700, Chris Wright wrote:

> Add "always lock'd" implementations of set_bit, clear_bit and
> change_bit and the corresponding test_and_ functions.  Also add
> "always lock'd" implementation of cmpxchg.  These give guaranteed
> strong synchronisation and are required for non-SMP kernels running on
> an SMP hypervisor.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Cc: Christoph Lameter <clameter@sgi.com>
> ---
>  include/asm-i386/synch_bitops.h |  166 ++++++++++++++++++++++++++++++++++++++++
>  include/asm-i386/system.h       |   33 +++++++
>  2 files changed, 199 insertions(+)
> 
> diff -r 935903fb1136 include/asm-i386/system.h
> --- a/include/asm-i386/system.h	Mon May 08 19:20:42 2006 -0400
> +++ b/include/asm-i386/system.h	Mon May 08 19:27:04 2006 -0400
> @@ -263,6 +263,9 @@ static inline unsigned long __xchg(unsig
>  #define cmpxchg(ptr,o,n)\
>  	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>  					(unsigned long)(n),sizeof(*(ptr))))
> +#define synch_cmpxchg(ptr,o,n)\
> +	((__typeof__(*(ptr)))__synch_cmpxchg((ptr),(unsigned long)(o),\
> +					(unsigned long)(n),sizeof(*(ptr))))
>  #endif
>...

Do I miss anything, or is CONFIG_X86_XEN=y, CONFIG_M386=y an allowed 
configuration that will result in a compile error?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

