Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946776AbWJTBCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946776AbWJTBCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946774AbWJTBCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:02:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:965 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1946769AbWJTBCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:02:03 -0400
Date: Fri, 20 Oct 2006 02:02:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061020010201.GZ29920@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org> <20061020005337.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020005337.GV29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And one more preliminary: skbuff -> mm.  New stats on
ftp.linux.org.uk/pub/people/viro/counts-after3; note reductions for
sched.h, fs.h and mm.h clusters.

---
 drivers/isdn/divert/isdn_divert.c           |    2 ++
 drivers/net/ehea/ehea_qmr.c                 |    1 +
 drivers/net/lance.c                         |    1 +
 drivers/net/ne3210.c                        |    1 +
 drivers/net/sk98lin/skge.c                  |    2 ++
 drivers/net/starfire.c                      |    1 +
 drivers/net/sungem.c                        |    1 +
 drivers/net/sunhme.c                        |    1 +
 drivers/net/typhoon.c                       |    1 +
 include/linux/igmp.h                        |    1 +
 include/linux/kernelcapi.h                  |    1 +
 include/linux/netdevice.h                   |    1 +
 include/linux/netfilter_ipv4/ip_conntrack.h |    1 +
 include/linux/skbuff.h                      |    1 -
 include/net/irda/timer.h                    |    1 +
 include/net/netlink.h                       |    1 +
 include/net/sock.h                          |    1 +
 net/ieee80211/ieee80211_crypt_tkip.c        |    1 +
 net/ieee80211/ieee80211_crypt_wep.c         |    1 +
 net/ipv4/ipvs/ip_vs_lblc.c                  |    1 +
 net/ipv4/ipvs/ip_vs_lblcr.c                 |    1 +
 net/ipv4/netfilter/ipt_hashlimit.c          |    1 +
 net/irda/discovery.c                        |    1 +
 net/irda/iriap.c                            |    1 +
 net/irda/irttp.c                            |    1 +
 net/netfilter/x_tables.c                    |    1 +
 26 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/isdn/divert/isdn_divert.c b/drivers/isdn/divert/isdn_divert.c
index 1f5ebe9..03319ea 100644
--- a/drivers/isdn/divert/isdn_divert.c
+++ b/drivers/isdn/divert/isdn_divert.c
@@ -10,6 +10,8 @@
  */
 
 #include <linux/proc_fs.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
 
 #include "isdn_divert.h"
 
diff --git a/drivers/net/ehea/ehea_qmr.c b/drivers/net/ehea/ehea_qmr.c
index 3e18623..01c21b7 100644
--- a/drivers/net/ehea/ehea_qmr.c
+++ b/drivers/net/ehea/ehea_qmr.c
@@ -26,6 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/mm.h>
 #include "ehea.h"
 #include "ehea_phyp.h"
 #include "ehea_qmr.h"
diff --git a/drivers/net/lance.c b/drivers/net/lance.c
index 947b20b..a384332 100644
--- a/drivers/net/lance.c
+++ b/drivers/net/lance.c
@@ -57,6 +57,7 @@ #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/mm.h>
 #include <linux/bitops.h>
 
 #include <asm/io.h>
diff --git a/drivers/net/ne3210.c b/drivers/net/ne3210.c
index d663289..1a6fed7 100644
--- a/drivers/net/ne3210.c
+++ b/drivers/net/ne3210.c
@@ -36,6 +36,7 @@ #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/mm.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index d4913c3..96bdbb7 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -113,6 +113,8 @@ #include	<linux/moduleparam.h>
 #include	<linux/init.h>
 #include	<linux/dma-mapping.h>
 #include	<linux/ip.h>
+#include	<linux/mm_types.h>
+#include	<asm/page.h>
 
 #include	"h/skdrv1st.h"
 #include	"h/skdrv2nd.h"
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index 7a0aee6..bf873ea 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -41,6 +41,7 @@ #include <linux/crc32.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/if_vlan.h>
+#include <linux/mm.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/uaccess.h>
 #include <asm/io.h>
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
index 253e96e..d1c07ea 100644
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -56,6 +56,7 @@ #include <linux/workqueue.h>
 #include <linux/if_vlan.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 9d7cd13..204b94e 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -32,6 +32,7 @@ #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/mm.h>
 #include <linux/bitops.h>
 
 #include <asm/system.h>
diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
index 3bf9e63..467b10f 100644
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -117,6 +117,7 @@ #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/ethtool.h>
diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 03f43e2..014940e 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -127,6 +127,7 @@ #define IGMP_LOCAL_GROUP_MASK	htonl(0xFF
 
 #ifdef __KERNEL__
 #include <linux/skbuff.h>
+#include <linux/timer.h>
 #include <linux/in.h>
 
 extern int sysctl_igmp_max_memberships;
diff --git a/include/linux/kernelcapi.h b/include/linux/kernelcapi.h
index 891bb2c..f8a0ff8 100644
--- a/include/linux/kernelcapi.h
+++ b/include/linux/kernelcapi.h
@@ -47,6 +47,7 @@ #ifdef __KERNEL__
 
 #include <linux/list.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 
 #define	KCI_CONTRUP	0	/* arg: struct capi_profile */
 #define	KCI_CONTRDOWN	1	/* arg: NULL */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9264139..5c55676 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -30,6 +30,7 @@ #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 
 #ifdef __KERNEL__
+#include <linux/timer.h>
 #include <asm/atomic.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>
diff --git a/include/linux/netfilter_ipv4/ip_conntrack.h b/include/linux/netfilter_ipv4/ip_conntrack.h
index 64e8680..9657019 100644
--- a/include/linux/netfilter_ipv4/ip_conntrack.h
+++ b/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -9,6 +9,7 @@ #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <asm/atomic.h>
 
+#include <linux/timer.h>
 #include <linux/netfilter_ipv4/ip_conntrack_tcp.h>
 #include <linux/netfilter_ipv4/ip_conntrack_icmp.h>
 #include <linux/netfilter_ipv4/ip_conntrack_proto_gre.h>
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6aa8b11..60be90a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -22,7 +22,6 @@ #include <linux/cache.h>
 #include <asm/atomic.h>
 #include <asm/types.h>
 #include <linux/spinlock.h>
-#include <linux/mm.h>
 #include <linux/net.h>
 #include <linux/textsearch.h>
 #include <net/checksum.h>
diff --git a/include/net/irda/timer.h b/include/net/irda/timer.h
index 2c5d886..cb61568 100644
--- a/include/net/irda/timer.h
+++ b/include/net/irda/timer.h
@@ -28,6 +28,7 @@ #ifndef TIMER_H
 #define TIMER_H
 
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 
 #include <asm/param.h>  /* for HZ */
 
diff --git a/include/net/netlink.h b/include/net/netlink.h
index ce5cba1..6798847 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -3,6 +3,7 @@ #define __NET_NETLINK_H
 
 #include <linux/types.h>
 #include <linux/netlink.h>
+#include <linux/jiffies.h>
 
 /* ========================================================================
  *         Netlink Messages and Attributes Interface (As Seen On TV)
diff --git a/include/net/sock.h b/include/net/sock.h
index 40bb90e..fb5fb0c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -47,6 +47,7 @@ #include <linux/module.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
+#include <linux/mm.h>
 #include <linux/security.h>
 
 #include <linux/filter.h>
diff --git a/net/ieee80211/ieee80211_crypt_tkip.c b/net/ieee80211/ieee80211_crypt_tkip.c
index 4200ec5..fc1f99a 100644
--- a/net/ieee80211/ieee80211_crypt_tkip.c
+++ b/net/ieee80211/ieee80211_crypt_tkip.c
@@ -16,6 +16,7 @@ #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/mm.h>
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <asm/string.h>
diff --git a/net/ieee80211/ieee80211_crypt_wep.c b/net/ieee80211/ieee80211_crypt_wep.c
index 1b2efff..7a95c3d 100644
--- a/net/ieee80211/ieee80211_crypt_wep.c
+++ b/net/ieee80211/ieee80211_crypt_wep.c
@@ -15,6 +15,7 @@ #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/skbuff.h>
+#include <linux/mm.h>
 #include <asm/string.h>
 
 #include <net/ieee80211.h>
diff --git a/net/ipv4/ipvs/ip_vs_lblc.c b/net/ipv4/ipvs/ip_vs_lblc.c
index 524751e..a4385a2 100644
--- a/net/ipv4/ipvs/ip_vs_lblc.c
+++ b/net/ipv4/ipvs/ip_vs_lblc.c
@@ -45,6 +45,7 @@ #include <linux/ip.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
+#include <linux/jiffies.h>
 
 /* for sysctl */
 #include <linux/fs.h>
diff --git a/net/ipv4/ipvs/ip_vs_lblcr.c b/net/ipv4/ipvs/ip_vs_lblcr.c
index 0899019..fe1af5d 100644
--- a/net/ipv4/ipvs/ip_vs_lblcr.c
+++ b/net/ipv4/ipvs/ip_vs_lblcr.c
@@ -43,6 +43,7 @@ #include <linux/ip.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
+#include <linux/jiffies.h>
 
 /* for sysctl */
 #include <linux/fs.h>
diff --git a/net/ipv4/netfilter/ipt_hashlimit.c b/net/ipv4/netfilter/ipt_hashlimit.c
index 33ccdbf..906eda8 100644
--- a/net/ipv4/netfilter/ipt_hashlimit.c
+++ b/net/ipv4/netfilter/ipt_hashlimit.c
@@ -31,6 +31,7 @@ #include <linux/vmalloc.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/list.h>
+#include <linux/mm.h>
 
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_hashlimit.h>
diff --git a/net/irda/discovery.c b/net/irda/discovery.c
index 3fefc82..89fd2a2 100644
--- a/net/irda/discovery.c
+++ b/net/irda/discovery.c
@@ -32,6 +32,7 @@
 
 #include <linux/string.h>
 #include <linux/socket.h>
+#include <linux/fs.h>
 #include <linux/seq_file.h>
 
 #include <net/irda/irda.h>
diff --git a/net/irda/iriap.c b/net/irda/iriap.c
index 415cf4e..d640889 100644
--- a/net/irda/iriap.c
+++ b/net/irda/iriap.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/skbuff.h>
+#include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
diff --git a/net/irda/irttp.c b/net/irda/irttp.c
index 3c2e70b..6a56165 100644
--- a/net/irda/irttp.c
+++ b/net/irda/irttp.c
@@ -26,6 +26,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/seq_file.h>
 
 #include <asm/byteorder.h>
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 58522fc..8996584 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -21,6 +21,7 @@ #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
 
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_arp.h>
-- 
1.4.2.GIT

