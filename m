Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVCWDfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVCWDfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVCWDfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:35:40 -0500
Received: from ozlabs.org ([203.10.76.45]:44950 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262616AbVCWDen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:34:43 -0500
Date: Wed, 23 Mar 2005 14:34:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm1 3/3] perfctr: 64-bit values in register descriptors
Message-ID: <20050323033430.GJ29765@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200503230300.j2N303Qo023641@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503230300.j2N303Qo023641@harpo.it.uu.se>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 04:00:03AM +0100, Mikael Pettersson wrote:
> - <linux/perfctr.h>: Change value fields in register descriptors
>   to 64 bits. This will be needed for ppc64, and ppc32 user-space
>   on ppc64 kernels, and may eventually also be needed on x86.
>   We could have different descriptor types for 32 and 64-bit
>   registers, but that just complicates things for no real benefit.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

Erm.. won't this stop i386 binaries working on an x86_64 kernel, since
kernel and user will have different ideas of the alignment...?

>  include/linux/perfctr.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -rupN linux-2.6.12-rc1-mm1/include/linux/perfctr.h linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h
> +++ linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h	2005-03-23 02:19:45.000000000 +0100
> @@ -27,10 +27,10 @@ struct vperfctr_control {
>  #define VPERFCTR_CONTROL_RESUME		0x03
>  #define VPERFCTR_CONTROL_CLEAR		0x04
>  
> -/* common description of an arch-specific 32-bit control register */
> +/* common description of an arch-specific control register */
>  struct perfctr_cpu_reg {
>  	__u32 nr;
> -	__u32 value;
> +	__u64 value;
>  };
>  
>  /* state and control domain numbers

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
