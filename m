Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbULOPbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbULOPbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbULOPbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:31:18 -0500
Received: from [218.244.111.2] ([218.244.111.2]:16141 "EHLO lb1.ctrip.com")
	by vger.kernel.org with ESMTP id S262359AbULOPbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:31:13 -0500
Date: Wed, 15 Dec 2004 23:26:36 +0800 (CST)
From: Wensong Zhang <wensong@linux-vs.org>
To: "David S. Miller" <davem@davemloft.net>
cc: Adrian Bunk <bunk@stusta.de>, Julian Anastasov <ja@ssi.bg>,
       lvs-users@linuxvirtualserver.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipvs/: make some code static
In-Reply-To: <20041215005801.GB11972@stusta.de>
Message-ID: <Pine.LNX.4.61.0412152300200.1048@penguin.linux-vs.org>
References: <20041215005801.GB11972@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Dave,

Please apply Adrian's patch.

Thanks,

Wensong


On Wed, 15 Dec 2004, Adrian Bunk wrote:

> The patch below makes some needlessly global code static.
>
>
> diffstat output:
> net/ipv4/ipvs/ip_vs_app.c        |    2 +-
> net/ipv4/ipvs/ip_vs_conn.c       |    2 +-
> net/ipv4/ipvs/ip_vs_ctl.c        |    2 +-
> net/ipv4/ipvs/ip_vs_proto.c      |    4 ++--
> net/ipv4/ipvs/ip_vs_proto_icmp.c |    4 ++--
> 5 files changed, 7 insertions(+), 7 deletions(-)
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_app.c.old	2004-12-14 05:15:21.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_app.c	2004-12-14 05:15:28.000000000 +0100
> @@ -65,7 +65,7 @@
> /*
>  *	Allocate/initialize app incarnation and register it in proto apps.
>  */
> -int
> +static int
> ip_vs_app_inc_new(struct ip_vs_app *app, __u16 proto, __u16 port)
> {
> 	struct ip_vs_protocol *pp;
> --- linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_conn.c.old	2004-12-14 05:15:44.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_conn.c	2004-12-14 05:15:51.000000000 +0100
> @@ -64,7 +64,7 @@
> } __attribute__((__aligned__(SMP_CACHE_BYTES)));
>
> /* lock array for conn table */
> -struct ip_vs_aligned_lock
> +static struct ip_vs_aligned_lock
> __ip_vs_conntbl_lock_array[CT_LOCKARRAY_SIZE] __cacheline_aligned;
>
> static inline void ct_read_lock(unsigned key)
> --- linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_ctl.c.old	2004-12-14 05:17:03.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_ctl.c	2004-12-14 05:17:14.000000000 +0100
> @@ -62,7 +62,7 @@
> /* 1/rate drop and drop-entry variables */
> int ip_vs_drop_rate = 0;
> int ip_vs_drop_counter = 0;
> -atomic_t ip_vs_dropentry = ATOMIC_INIT(0);
> +static atomic_t ip_vs_dropentry = ATOMIC_INIT(0);
>
> /* number of virtual services */
> static int ip_vs_num_services = 0;
> --- linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_proto.c.old	2004-12-14 05:17:33.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_proto.c	2004-12-14 05:17:47.000000000 +0100
> @@ -45,7 +45,7 @@
> /*
>  *	register an ipvs protocol
>  */
> -int register_ip_vs_protocol(struct ip_vs_protocol *pp)
> +static int register_ip_vs_protocol(struct ip_vs_protocol *pp)
> {
> 	unsigned hash = IP_VS_PROTO_HASH(pp->protocol);
>
> @@ -62,7 +62,7 @@
> /*
>  *	unregister an ipvs protocol
>  */
> -int unregister_ip_vs_protocol(struct ip_vs_protocol *pp)
> +static int unregister_ip_vs_protocol(struct ip_vs_protocol *pp)
> {
> 	struct ip_vs_protocol **pp_p;
> 	unsigned hash = IP_VS_PROTO_HASH(pp->protocol);
> --- linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_proto_icmp.c.old	2004-12-14 05:18:02.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipv4/ipvs/ip_vs_proto_icmp.c	2004-12-14 05:18:37.000000000 +0100
> @@ -22,7 +22,7 @@
>
> static char * icmp_state_name_table[1] = { "ICMP" };
>
> -struct ip_vs_conn *
> +static struct ip_vs_conn *
> icmp_conn_in_get(const struct sk_buff *skb,
> 		 struct ip_vs_protocol *pp,
> 		 const struct iphdr *iph,
> @@ -49,7 +49,7 @@
> #endif
> }
>
> -struct ip_vs_conn *
> +static struct ip_vs_conn *
> icmp_conn_out_get(const struct sk_buff *skb,
> 		  struct ip_vs_protocol *pp,
> 		  const struct iphdr *iph,
>
