Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVAXU1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVAXU1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVAXUZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:25:19 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:17831 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261619AbVAXUYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:24:12 -0500
Date: Mon, 24 Jan 2005 21:24:09 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.11-rc2-mm1 - compile fix
Message-ID: <20050124202409.GG1847@ens-lyon.fr>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> 
> 
> - Lots of updates and fixes all over the place.
> 
> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
> 
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.
> 
> 

The patch below fixes the compilation of the tftp nat module

net/ipv4/netfilter/ip_nat_tftp.o(.bss+0x0):net/ipv4/netfilter/ip_nat_tftp.c:44: multiple definition of `ip_nat_tftp_hook'
net/ipv4/netfilter/ip_conntrack_tftp.o(.bss+0x0):net/ipv4/netfilter/ip_conntrack_tftp.c:49: first defined here
make[3]: *** [net/ipv4/netfilter/built-in.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- linux-clean/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-01-24 12:44:29.000000000 +0100
+++ linux-test/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-01-24 21:11:05.000000000 +0100
@@ -13,8 +13,8 @@ struct tftphdr {
 #define TFTP_OPCODE_ACK		4
 #define TFTP_OPCODE_ERROR	5
 
-unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
-				 enum ip_conntrack_info ctinfo,
-				 struct ip_conntrack_expect *exp);
+extern unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
+					enum ip_conntrack_info ctinfo,
+					struct ip_conntrack_expect *exp);
 
 #endif /* _IP_CT_TFTP */
