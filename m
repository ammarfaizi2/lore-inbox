Return-Path: <linux-kernel-owner+w=401wt.eu-S965161AbXASOhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbXASOhV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbXASOhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:37:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2236 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965098AbXASOhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:37:19 -0500
Date: Fri, 19 Jan 2007 15:37:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Walrond <andrew@walrond.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers - linux-atm userspace build broken by recent change; __be16 undefined
Message-ID: <20070119143724.GN9093@stusta.de>
References: <45AFE52C.30308@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AFE52C.30308@walrond.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 09:22:52PM +0000, Andrew Walrond wrote:
> Don't know exactly when this change went in, but it's not in 2.6.18.3 
> and is in 2.6.19.2+
> 
>  $ diff linux/include/linux/if_arp.h linux-2.6/include/linux/if_arp.h
> 133,134c133,134
> <       unsigned short  ar_hrd;         /* format of hardware address   */
> <       unsigned short  ar_pro;         /* format of protocol address   */
> ---
> >       __be16          ar_hrd;         /* format of hardware address   */
> >       __be16          ar_pro;         /* format of protocol address   */
> 137c137
> <       unsigned short  ar_op;          /* ARP opcode (command)         */
> ---
> >       __be16          ar_op;          /* ARP opcode (command)         */
> 
> 
> This causes the linux-atm userspace compile to fail like this:
> 
> In file included from arp.c:19:
> /usr/include/linux/if_arp.h:133: error: expected 
> specifier-qualifier-list before '__be16'
> 
> I guess if_arp.h needs to include include/linux/byteorder/big_endian.h?

No, linux/types.h

But what bothers me more about if_arp.h is that it is one of the
headers using "struct sockaddr" in userspace, but as far as I can see we 
aren't exporting it in any header.

This seems to work since glibc is providing the struct, but this looks 
a bit fishy.

> Andrew Walrond

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

