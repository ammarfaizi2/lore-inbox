Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161696AbWKHTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161696AbWKHTHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161695AbWKHTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:07:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161692AbWKHTG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:06:59 -0500
Date: Wed, 8 Nov 2006 11:06:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: e1000: include <net/ip6_checksum.h> for IA64
Message-Id: <20061108110601.01d9a4f4.akpm@osdl.org>
In-Reply-To: <45521873.20402@intel.com>
References: <45521873.20402@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 09:48:35 -0800
Auke Kok <auke-jan.h.kok@intel.com> wrote:

> Here's a slightly better patch to fix ia64 not building atm.

fsvo "better".

> Jeff, please apply this to netdev-2.6#upstream instead of akpm's patch that I acked earlier.
> 
> Of course, someone really should come up with an asm version for ia64 of the missing 
> function ;)
> 
> Cheers,
> 
> Auke
> 
> ---
> 
> e1000: include <net/ip6_checksum.h> for IA64
> 
> IA64 does not have an optimized asm version for ipv6 csum magic. Fall
> back to generic implementation.
> 
> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
> 
> diff --git a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
> index f091042..26e7506 100644
> --- a/drivers/net/e1000/e1000.h
> +++ b/drivers/net/e1000/e1000.h
> @@ -61,6 +61,7 @@
>   #include <linux/ip.h>
>   #ifdef NETIF_F_TSO6
>   #include <linux/ipv6.h>
> +#include <net/ip6_checksum.h>
>   #endif
>   #include <linux/tcp.h>
>   #include <linux/udp.h>

It is noxious of e1000 to do a #include <everything.h> from its driver-wide
header file and I refused to be a party to such a thing!

Jeff probably won't be able to apply this because, like your other patches,
it is space-stuffed.  Then again, maybe git understands format=flowed, dunno.
