Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137087AbREKKXk>; Fri, 11 May 2001 06:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137096AbREKKXa>; Fri, 11 May 2001 06:23:30 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:32014 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S137087AbREKKXV>;
	Fri, 11 May 2001 06:23:21 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andi Kleen <ak@suse.de>
Date: Fri, 11 May 2001 12:21:59 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Source code compatibility in Stable series????
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
        davem@redhat.com
X-mailer: Pegasus Mail v3.40
Message-ID: <2983F527D00@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 01 at 12:03, Andi Kleen wrote:
> On Fri, May 11, 2001 at 02:56:35AM -0700, David S. Miller wrote:
> I guess it would be possible to add a HAVE_ZEROCOPY to skbuff.h to make
> it a bit easier for single source drivers.
> 
> --- include/linux/skbuff.h-o    Wed May  9 12:36:44 2001
> +++ include/linux/skbuff.h  Fri May 11 12:12:43 2001
> @@ -29,6 +29,7 @@
>  #define HAVE_ALLOC_SKB     /* For the drivers to know */
>  #define HAVE_ALIGNABLE_SKB /* Ditto 8)        */
>  #define SLAB_SKB       /* Slabified skbuffs       */
> +#define HAVE_ZEROCOPY      /* Zerocopy stack */ 

When I was updating VMware's vmnet, I decided to use

#ifdef skb_shinfo

This gives you maximal backward compatibility, as all public zerocopy
patches contain this macro. Only thing is that Dave has to remember
that when he turns skb_shinfo into inline function, an identity #define have
to be added.

Just my opinion - as you cannot add HAVE_ZEROCOPY to all already existing
and installed kernels.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz


