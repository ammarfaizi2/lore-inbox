Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVAHXdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVAHXdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVAHXdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:33:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51465 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262075AbVAHXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:32:37 -0500
Date: Sun, 9 Jan 2005 00:32:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ipv6/: misc cleanups
Message-ID: <20050108233231.GI14108@stusta.de>
References: <20041215005546.GA11972@stusta.de> <20041215.105900.27736391.yoshfuji@linux-ipv6.org> <20050107030017.GF14108@stusta.de> <20050107.121149.102802103.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107.121149.102802103.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 12:11:49PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <20050107030017.GF14108@stusta.de> (at Fri, 7 Jan 2005 04:00:17 +0100), Adrian Bunk <bunk@stusta.de> says:
> 
> > - #if 0 the following unused global variable:
> >   - addrconf.c: in6addr_any
> > - remove the following EXPORT_SYMBOL's:
> >   - ipv6_syms.c: in6addr_any
> >   - ipv6_syms.c: in6addr_loopback
> :
> > --- linux-2.6.10-mm2-full/include/linux/in6.h.old	2005-01-07 02:34:21.000000000 +0100
> > +++ linux-2.6.10-mm2-full/include/linux/in6.h	2005-01-07 02:36:18.000000000 +0100
> > @@ -44,10 +44,10 @@
> >   * NOTE: Be aware the IN6ADDR_* constants and in6addr_* externals are defined
> >   * in network byte order, not in host byte order as are the IPv4 equivalents
> >   */
> > +#if 0
> >  extern const struct in6_addr in6addr_any;
> >  #define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
> > -extern const struct in6_addr in6addr_loopback;
> > -#define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }
> > +#endif
> >  
> 
> I meant:
> 
> #if 0
> extern const struct in6_addr in6addr_any;
> #define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
> #endif
> extern const struct in6_addr in6addr_loopback;
> #define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }
> 
> And,
> 
> > @@ -191,7 +188,11 @@
> >  };
> >  
> >  /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
> > +#if 0
> > +#define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
> >  const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
> > +#endif
> > +#define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }
> >  const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
> >  
> 
> #if 0
> const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
> #endif
> const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
> 
> or something like this.


OK, updated patch below.


> --yoshfuji

cu
Adrian


<--  snip  -->


The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the following unused functions:
  - exthdrs.c: ipv6_build_rthdr
  - exthdrs.c: ipv6_build_exthdr
  - exthdrs.c: ipv6_build_nfrag_opts
  - exthdrs.c: ipv6_build_frag_opts
- remove the following write-only global variables:
  - addrconf.c: inet6_dev_count
  - addrconf.c: inet6_ifa_count
- #if 0 the following unused global variable:
  - addrconf.c: in6addr_any
- remove the following unneeded EXPORT_SYMBOL's:
  - ipv6_syms.c: in6addr_any
  - ipv6_syms.c: in6addr_loopback


diffstat output:
 include/linux/in6.h        |    2 
 include/net/addrconf.h     |    1 
 include/net/ipv6.h         |    2 
 net/ipv6/addrconf.c        |    9 ----
 net/ipv6/anycast.c         |    4 +
 net/ipv6/exthdrs.c         |   77 -------------------------------------
 net/ipv6/icmp.c            |    2 
 net/ipv6/ip6_output.c      |    2 
 net/ipv6/ipv6_syms.c       |    2 
 net/ipv6/mcast.c           |   32 ++++++++-------
 net/ipv6/route.c           |    4 -
 net/ipv6/sysctl_net_ipv6.c |    2 
 12 files changed, 30 insertions(+), 109 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/include/linux/in6.h.old	2005-01-07 02:34:21.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/in6.h	2005-01-08 23:37:31.000000000 +0100
@@ -44,8 +44,10 @@
  * NOTE: Be aware the IN6ADDR_* constants and in6addr_* externals are defined
  * in network byte order, not in host byte order as are the IPv4 equivalents
  */
+#if 0
 extern const struct in6_addr in6addr_any;
 #define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
+#endif
 extern const struct in6_addr in6addr_loopback;
 #define IN6ADDR_LOOPBACK_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } } }
 
--- linux-2.6.10-mm2-full/net/ipv6/addrconf.c.old	2005-01-07 02:34:57.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/addrconf.c	2005-01-08 23:38:34.000000000 +0100
@@ -99,9 +99,6 @@
 static void addrconf_sysctl_unregister(struct ipv6_devconf *p);
 #endif
 
-int inet6_dev_count;
-int inet6_ifa_count;
-
 #ifdef CONFIG_IPV6_PRIVACY
 static int __ipv6_regen_rndid(struct inet6_dev *idev);
 static int __ipv6_try_regen_rndid(struct inet6_dev *idev, struct in6_addr *tmpaddr); 
@@ -191,7 +188,9 @@
 };
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
+#if 0
 const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+#endif
 const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
 
 int ipv6_addr_type(const struct in6_addr *addr)
@@ -310,7 +309,6 @@
 		return;
 	}
 	snmp6_unregister_dev(idev);
-	inet6_dev_count--;
 	kfree(idev);
 }
 
@@ -338,7 +336,6 @@
 			kfree(ndev);
 			return NULL;
 		}
-		inet6_dev_count++;
 		/* We refer to the device */
 		dev_hold(dev);
 
@@ -475,7 +472,6 @@
 	}
 	dst_release(&ifp->rt->u.dst);
 
-	inet6_ifa_count--;
 	kfree(ifp);
 }
 
@@ -530,7 +526,6 @@
 	ifa->flags = flags | IFA_F_TENTATIVE;
 	ifa->cstamp = ifa->tstamp = jiffies;
 
-	inet6_ifa_count++;
 	ifa->idev = idev;
 	in6_dev_hold(idev);
 	/* For caller */
--- linux-2.6.10-mm2-full/net/ipv6/ipv6_syms.c.old	2005-01-07 02:35:19.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/ipv6_syms.c	2005-01-07 02:36:35.000000000 +0100
@@ -32,8 +32,6 @@
 EXPORT_SYMBOL(inet6_ioctl);
 EXPORT_SYMBOL(ipv6_get_saddr);
 EXPORT_SYMBOL(ipv6_chk_addr);
-EXPORT_SYMBOL(in6addr_any);
-EXPORT_SYMBOL(in6addr_loopback);
 EXPORT_SYMBOL(in6_dev_finish_destroy);
 #ifdef CONFIG_XFRM
 EXPORT_SYMBOL(xfrm6_rcv);
--- linux-2.6.10-mm2-full/include/net/addrconf.h.old	2005-01-07 02:38:03.000000000 +0100
+++ linux-2.6.10-mm2-full/include/net/addrconf.h	2005-01-07 02:38:10.000000000 +0100
@@ -112,7 +112,6 @@
 
 extern int ipv6_dev_ac_inc(struct net_device *dev, struct in6_addr *addr);
 extern int __ipv6_dev_ac_dec(struct inet6_dev *idev, struct in6_addr *addr);
-extern int ipv6_dev_ac_dec(struct net_device *dev, struct in6_addr *addr);
 extern int ipv6_chk_acast_addr(struct net_device *dev, struct in6_addr *addr);
 
 
--- linux-2.6.10-mm2-full/net/ipv6/anycast.c.old	2005-01-07 02:38:21.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/anycast.c	2005-01-07 02:38:44.000000000 +0100
@@ -43,6 +43,8 @@
 
 #include <net/checksum.h>
 
+static int ipv6_dev_ac_dec(struct net_device *dev, struct in6_addr *addr);
+
 /* Big ac list lock for all the sockets */
 static rwlock_t ipv6_sk_ac_lock = RW_LOCK_UNLOCKED;
 
@@ -413,7 +415,7 @@
 	return 0;
 }
 
-int ipv6_dev_ac_dec(struct net_device *dev, struct in6_addr *addr)
+static int ipv6_dev_ac_dec(struct net_device *dev, struct in6_addr *addr)
 {
 	int ret;
 	struct inet6_dev *idev = in6_dev_get(dev);
--- linux-2.6.10-mm2-full/net/ipv6/exthdrs.c.old	2005-01-07 02:39:33.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/exthdrs.c	2005-01-07 02:50:24.000000000 +0100
@@ -501,83 +501,6 @@
  *	for headers.
  */
 
-static u8 *ipv6_build_rthdr(struct sk_buff *skb, u8 *prev_hdr,
-		     struct ipv6_rt_hdr *opt, struct in6_addr *addr)
-{
-	struct rt0_hdr *phdr, *ihdr;
-	int hops;
-
-	ihdr = (struct rt0_hdr *) opt;
-	
-	phdr = (struct rt0_hdr *) skb_put(skb, (ihdr->rt_hdr.hdrlen + 1) << 3);
-	memcpy(phdr, ihdr, sizeof(struct rt0_hdr));
-
-	hops = ihdr->rt_hdr.hdrlen >> 1;
-
-	if (hops > 1)
-		memcpy(phdr->addr, ihdr->addr + 1,
-		       (hops - 1) * sizeof(struct in6_addr));
-
-	ipv6_addr_copy(phdr->addr + (hops - 1), addr);
-
-	phdr->rt_hdr.nexthdr = *prev_hdr;
-	*prev_hdr = NEXTHDR_ROUTING;
-	return &phdr->rt_hdr.nexthdr;
-}
-
-static u8 *ipv6_build_exthdr(struct sk_buff *skb, u8 *prev_hdr, u8 type, struct ipv6_opt_hdr *opt)
-{
-	struct ipv6_opt_hdr *h = (struct ipv6_opt_hdr *)skb_put(skb, ipv6_optlen(opt));
-
-	memcpy(h, opt, ipv6_optlen(opt));
-	h->nexthdr = *prev_hdr;
-	*prev_hdr = type;
-	return &h->nexthdr;
-}
-
-u8 *ipv6_build_nfrag_opts(struct sk_buff *skb, u8 *prev_hdr, struct ipv6_txoptions *opt,
-			  struct in6_addr *daddr, u32 jumbolen)
-{
-	struct ipv6_opt_hdr *h = (struct ipv6_opt_hdr *)skb->data;
-
-	if (opt && opt->hopopt)
-		prev_hdr = ipv6_build_exthdr(skb, prev_hdr, NEXTHDR_HOP, opt->hopopt);
-
-	if (jumbolen) {
-		u8 *jumboopt = (u8 *)skb_put(skb, 8);
-
-		if (opt && opt->hopopt) {
-			*jumboopt++ = IPV6_TLV_PADN;
-			*jumboopt++ = 0;
-			h->hdrlen++;
-		} else {
-			h = (struct ipv6_opt_hdr *)jumboopt;
-			h->nexthdr = *prev_hdr;
-			h->hdrlen = 0;
-			jumboopt += 2;
-			*prev_hdr = NEXTHDR_HOP;
-			prev_hdr = &h->nexthdr;
-		}
-		jumboopt[0] = IPV6_TLV_JUMBO;
-		jumboopt[1] = 4;
-		*(u32*)(jumboopt+2) = htonl(jumbolen);
-	}
-	if (opt) {
-		if (opt->dst0opt)
-			prev_hdr = ipv6_build_exthdr(skb, prev_hdr, NEXTHDR_DEST, opt->dst0opt);
-		if (opt->srcrt)
-			prev_hdr = ipv6_build_rthdr(skb, prev_hdr, opt->srcrt, daddr);
-	}
-	return prev_hdr;
-}
-
-u8 *ipv6_build_frag_opts(struct sk_buff *skb, u8 *prev_hdr, struct ipv6_txoptions *opt)
-{
-	if (opt->dst1opt)
-		prev_hdr = ipv6_build_exthdr(skb, prev_hdr, NEXTHDR_DEST, opt->dst1opt);
-	return prev_hdr;
-}
-
 static void ipv6_push_rthdr(struct sk_buff *skb, u8 *proto,
 			    struct ipv6_rt_hdr *opt,
 			    struct in6_addr **addr_p)
--- linux-2.6.10-mm2-full/net/ipv6/icmp.c.old	2005-01-07 02:40:12.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/icmp.c	2005-01-07 02:40:20.000000000 +0100
@@ -211,7 +211,7 @@
 	return (*op & 0xC0) == 0x80;
 }
 
-int icmpv6_push_pending_frames(struct sock *sk, struct flowi *fl, struct icmp6hdr *thdr, int len)
+static int icmpv6_push_pending_frames(struct sock *sk, struct flowi *fl, struct icmp6hdr *thdr, int len)
 {
 	struct sk_buff *skb;
 	struct icmp6hdr *icmp6h;
--- linux-2.6.10-mm2-full/include/net/ipv6.h.old	2005-01-07 02:40:56.000000000 +0100
+++ linux-2.6.10-mm2-full/include/net/ipv6.h	2005-01-07 02:41:03.000000000 +0100
@@ -229,8 +229,6 @@
 					       void (*destructor)(struct sock *));
 
 
-extern int			ip6_call_ra_chain(struct sk_buff *skb, int sel);
-
 extern int			ipv6_parse_hopopts(struct sk_buff *skb, int);
 
 extern struct ipv6_txoptions *  ipv6_dup_options(struct sock *sk, struct ipv6_txoptions *opt);
--- linux-2.6.10-mm2-full/net/ipv6/ip6_output.c.old	2005-01-07 02:41:10.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/ip6_output.c	2005-01-07 02:41:15.000000000 +0100
@@ -311,7 +311,7 @@
 	return 0;
 }
 
-int ip6_call_ra_chain(struct sk_buff *skb, int sel)
+static int ip6_call_ra_chain(struct sk_buff *skb, int sel)
 {
 	struct ip6_ra_chain *ra;
 	struct sock *last = NULL;
--- linux-2.6.10-mm2-full/net/ipv6/mcast.c.old	2005-01-07 02:41:35.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/mcast.c	2005-01-07 02:44:44.000000000 +0100
@@ -121,7 +121,7 @@
 	struct in6_addr srcs[0];
 };
 
-struct in6_addr mld2_all_mcr = MLD2_ALL_MCR_INIT;
+static struct in6_addr mld2_all_mcr = MLD2_ALL_MCR_INIT;
 
 /* Big mc list lock for all the sockets */
 static rwlock_t ipv6_sk_mc_lock = RW_LOCK_UNLOCKED;
@@ -143,12 +143,14 @@
 static int sf_setstate(struct ifmcaddr6 *pmc);
 static void sf_markstate(struct ifmcaddr6 *pmc);
 static void ip6_mc_clear_src(struct ifmcaddr6 *pmc);
-int ip6_mc_del_src(struct inet6_dev *idev, struct in6_addr *pmca, int sfmode,
-	int sfcount, struct in6_addr *psfsrc, int delta);
-int ip6_mc_add_src(struct inet6_dev *idev, struct in6_addr *pmca, int sfmode,
-	int sfcount, struct in6_addr *psfsrc, int delta);
-int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
-	struct inet6_dev *idev);
+static int ip6_mc_del_src(struct inet6_dev *idev, struct in6_addr *pmca,
+			  int sfmode, int sfcount, struct in6_addr *psfsrc,
+			  int delta);
+static int ip6_mc_add_src(struct inet6_dev *idev, struct in6_addr *pmca,
+			  int sfmode, int sfcount, struct in6_addr *psfsrc,
+			  int delta);
+static int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
+			    struct inet6_dev *idev);
 
 
 #define IGMP6_UNSOLICITED_IVAL	(10*HZ)
@@ -272,7 +274,7 @@
 	return -ENOENT;
 }
 
-struct inet6_dev *ip6_mc_find_dev(struct in6_addr *group, int ifindex)
+static struct inet6_dev *ip6_mc_find_dev(struct in6_addr *group, int ifindex)
 {
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev = NULL;
@@ -1723,8 +1725,9 @@
 	return rv;
 }
 
-int ip6_mc_del_src(struct inet6_dev *idev, struct in6_addr *pmca, int sfmode,
-	int sfcount, struct in6_addr *psfsrc, int delta)
+static int ip6_mc_del_src(struct inet6_dev *idev, struct in6_addr *pmca,
+			  int sfmode, int sfcount, struct in6_addr *psfsrc,
+			  int delta)
 {
 	struct ifmcaddr6 *pmc;
 	int	changerec = 0;
@@ -1847,8 +1850,9 @@
 /*
  * Add multicast source filter list to the interface list
  */
-int ip6_mc_add_src(struct inet6_dev *idev, struct in6_addr *pmca, int sfmode,
-	int sfcount, struct in6_addr *psfsrc, int delta)
+static int ip6_mc_add_src(struct inet6_dev *idev, struct in6_addr *pmca,
+			  int sfmode, int sfcount, struct in6_addr *psfsrc,
+			  int delta)
 {
 	struct ifmcaddr6 *pmc;
 	int	isexclude;
@@ -1951,8 +1955,8 @@
 	spin_unlock_bh(&ma->mca_lock);
 }
 
-int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
-	struct inet6_dev *idev)
+static int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
+			    struct inet6_dev *idev)
 {
 	int err;
 
--- linux-2.6.10-mm2-full/net/ipv6/route.c.old	2005-01-07 02:45:00.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/route.c	2005-01-07 02:45:22.000000000 +0100
@@ -208,8 +208,8 @@
 /*
  *	pointer to the last default router chosen. BH is disabled locally.
  */
-struct rt6_info *rt6_dflt_pointer;
-spinlock_t rt6_dflt_lock = SPIN_LOCK_UNLOCKED;
+static struct rt6_info *rt6_dflt_pointer;
+static spinlock_t rt6_dflt_lock = SPIN_LOCK_UNLOCKED;
 
 void rt6_reset_dflt_pointer(struct rt6_info *rt)
 {
--- linux-2.6.10-mm2-full/net/ipv6/sysctl_net_ipv6.c.old	2005-01-07 02:45:38.000000000 +0100
+++ linux-2.6.10-mm2-full/net/ipv6/sysctl_net_ipv6.c	2005-01-07 02:45:46.000000000 +0100
@@ -19,7 +19,7 @@
 
 #ifdef CONFIG_SYSCTL
 
-ctl_table ipv6_table[] = {
+static ctl_table ipv6_table[] = {
 	{
 		.ctl_name	= NET_IPV6_ROUTE,
 		.procname	= "route",
