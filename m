Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSHCSMz>; Sat, 3 Aug 2002 14:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSHCSMz>; Sat, 3 Aug 2002 14:12:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6416 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317637AbSHCSMv>; Sat, 3 Aug 2002 14:12:51 -0400
To: David Miller <davem@redhat.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2: 2.5.29-ether
Message-Id: <E17b3Rn-0006wB-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

Some compilers may add extra padding at the end of struct ethhdr.
This patch ensures that sizeof(struct ethhdr) always packed, and
returns the expected size of 14 bytes.

This is particularly important when struct ethhdr is embedded into
a structure, thusly:

struct arc_eth_encap
{
    uint8_t proto;              /* Always ARC_P_ETHER                   */
    struct ethhdr eth;          /* standard ethernet header (yuck!)     */
    uint8_t payload[0];         /* 493 bytes                            */
};
#define ETH_ENCAP_HDR_SIZE 14

or this:

                char *the_ip = (((char *)skb->data))
                                + sizeof(struct ethhdr)
                                + sizeof(struct arphdr) +
                                ETH_ALEN;


 include/linux/if_ether.h |    2 +-
 1 files changed, 1 insertion, 1 deletion

diff -urN orig/include/linux/if_ether.h linux/include/linux/if_ether.h
--- orig/include/linux/if_ether.h	Mon Mar 11 11:56:23 2002
+++ linux/include/linux/if_ether.h	Mon Mar 11 11:45:30 2002
@@ -96,6 +96,6 @@
 	unsigned char	h_dest[ETH_ALEN];	/* destination eth addr	*/
 	unsigned char	h_source[ETH_ALEN];	/* source ether addr	*/
 	unsigned short	h_proto;		/* packet type ID field	*/
-};
+} __attribute__((packed));
 
 #endif	/* _LINUX_IF_ETHER_H */

