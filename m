Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVAXRzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVAXRzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVAXRye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:54:34 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:6567 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261547AbVAXRxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:53:34 -0500
Date: Mon, 24 Jan 2005 15:58:40 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124145840.GA10211@ens-lyon.fr>
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
> 
> Changes since 2.6.11-rc1-mm2:
> 
> 
>  bk-netdev.patch

Without the following patch, it doesn't compile with ip_conntrack and
without ip_nat.

In file included from net/ipv4/netfilter/ip_conntrack_standalone.c:34:
include/linux/netfilter_ipv4/ip_conntrack.h:306: error: parameter `manip' has incomplete type
include/linux/netfilter_ipv4/ip_conntrack.h: In function `ip_nat_initialized':
include/linux/netfilter_ipv4/ip_conntrack.h:307: error: `IP_NAT_MANIP_SRC' undeclared (first use in this function)

regards,

Benoit

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- linux-clean/include/linux/netfilter_ipv4/ip_conntrack.h	2005-01-24 12:44:29.000000000 +0100
+++ linux/include/linux/netfilter_ipv4/ip_conntrack.h	2005-01-24 13:05:44.000000000 +0100
@@ -301,6 +301,7 @@ struct ip_conntrack_stat
 
 #define CONNTRACK_STAT_INC(count) (__get_cpu_var(ip_conntrack_stat).count++)
 
+#ifdef CONFIG_IP_NF_NAT_NEEDED
 static inline int ip_nat_initialized(struct ip_conntrack *conntrack,
 				     enum ip_nat_manip_type manip)
 {
@@ -308,5 +309,6 @@ static inline int ip_nat_initialized(str
 		return test_bit(IPS_SRC_NAT_DONE_BIT, &conntrack->status);
 	return test_bit(IPS_DST_NAT_DONE_BIT, &conntrack->status);
 }
+#endif /* CONFIG_IP_NF_NAT_NEEDED */
 #endif /* __KERNEL__ */
 #endif /* _IP_CONNTRACK_H */

