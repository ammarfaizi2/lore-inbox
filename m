Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVCRBym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVCRBym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVCRBym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:54:42 -0500
Received: from CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com ([69.194.86.29]:64129
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261369AbVCRByI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:54:08 -0500
From: Andrew James Wade 
	<ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
Reply-To: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm3 - redzone mismatch
Date: Thu, 17 Mar 2005 20:50:06 -0500
User-Agent: KMail/1.7.1
References: <200503121839.36970.bero@arklinux.org> <20050314203357.75aacaaf.akpm@osdl.org>
In-Reply-To: <20050314203357.75aacaaf.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503172050.06891.ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My computer crashed twice today. Both times I was unable to use the keyboard,
but was able to shutdown X.

I have had hardware problems related to overheating, but I believe that I have
resolved my overheating problems, and in any event I had not been stressing
the cpu since the first crash.

The following messages appeared in my kernel log before my first crash:

Mar 17 12:51:33 kenichi kernel: slab dentry_cache: redzone mismatch in slabp c2802000, objp c2802ab8, bufctl 0xfffe
Mar 17 12:51:33 kenichi kernel: Redzone: 0x170fc2a5/0x120fc2a5.
Mar 17 12:51:33 kenichi kernel: Last user: [d_alloc+28/464](d_alloc+0x1c/0x1d0)
Mar 17 12:51:33 kenichi kernel: 000: 00 00 00 00 00 00 00 00 a4 7a 32 cb 34 2e 80 c2
Mar 17 12:51:33 kenichi kernel: 010: 1d 47 cc d2 0f 00 00 00 20 2b 80 c2 6c 2b 80 c2
Mar 17 12:51:33 kenichi kernel: slab dentry_cache: redzone mismatch in slabp c2802000, objp c2802b4c, bufctl 0xfffe
Mar 17 12:51:33 kenichi kernel: Redzone: 0x90fc2a5/0x170fc2a5.
Mar 17 12:51:33 kenichi kernel: Last user: [d_alloc+28/464](d_alloc+0x1c/0x1d0)
Mar 17 12:51:33 kenichi kernel: 000: 00 00 00 00 00 00 00 35 8c 7c 32 cb 34 2e 80 12
Mar 17 12:51:33 kenichi kernel: 010: 9a d3 fd f5 15 00 00 09 b4 2b 80 c2 00 2c 80 35
...
repeat every five minutes for a few hours
...
then:

Mar 17 17:56:35 kenichi kernel:  ff ff ff ff ff bf ff
Mar 17 17:56:35 kenichi kernel: 12ff0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13040: ff fb ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13070: ff ff ff ff ff ff f7 ff ff ff df ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13080: ff ff ff ff ff ff ff ff ff ff f7 ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13090: ff ff ff df ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 130a0: ff ff ff ff ff ff ff ff ff ff ff ef ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 130b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 130c0: bf ff ff ff ff ff ff ff ff ff ff ff ff 7f ff ff
Mar 17 17:56:35 kenichi kernel: 130d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 130e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 130f0: ff ff ff ff ff bf ff ff ff f7 ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13100: ff ff ff ff ff ff bf ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13120: ff ff ff ff ff ff ff ff ff ff ff ef ff ff db ff
Mar 17 17:56:35 kenichi kernel: 13130: ff ff ff ff ff ff ff ff fb ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13140: ff ff ff ff ff ff ff ff db ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13150: ff ff ff ff ff ff ff ff f3 ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13160: ff ff 7f ff ff ff ff fb ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13170: ff ff ff ef ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 131a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff fb ff
Mar 17 17:56:35 kenichi kernel: 131b0: ff ff ff ff ff ff ff ff ff ff ff ff ef ff ff ff
Mar 17 17:56:35 kenichi kernel: 131c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 131d0: ff ff fd ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 131e0: ff ff ff ff ff ff ff ff ef ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 131f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ad ff ff
Mar 17 17:56:35 kenichi kernel: 13200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13210: ff ff ff ff ff ff ff ff ff bf df ff ff ff ef ff
Mar 17 17:56:35 kenichi kernel: 13220: ff ff ff ff ff ff ff ff ff ff ef ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13230: ff 7f ff ff ff ff ff ff ff ff ff ff ff ff ff 7f
Mar 17 17:56:35 kenichi kernel: 13240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff df
Mar 17 17:56:35 kenichi kernel: 13250: ff f7 ff ff ff ff fe ff ff ff ff ff ff ff ff fe
Mar 17 17:56:35 kenichi kernel: 13260: ff ff ff ff ff ff ff ff ff bf ff ff ff fe df ff
Mar 17 17:56:35 kenichi kernel: 13270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13280: ef ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13290: ff 7f ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 132a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 132b0: ff ff ff ff ff ff ff ff fb ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 132c0: ff ff ff ff ff ff ef ff ff ff ff ff ff ff 7f f7
Mar 17 17:56:35 kenichi kernel: 132d0: ff fe ff ff ff ff ff ff bf ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 132e0: f7 7f ff ff ff ff df ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 132f0: ff ff fe ff ff ef ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13300: ff ff ff ff ff ff ff ff ff ff 7f ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13310: ff ff ff 7f ff ff ff ff ff ff ff ff df ff ff ff
Mar 17 17:56:35 kenichi kernel: 13320: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13330: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13340: ff ff ff ff ff bf ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13350: ff ff ff ff ff ff ff ff ff ff fb ff ff ff ff df
Mar 17 17:56:35 kenichi kernel: 13360: ff ff ff ff 7f ff ff ff ff ff 7f ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13370: ff ff ff ff ff 7f ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13380: ff ff ef ff ff ff ff ff ff ff ff f7 ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13390: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 133a0: ff ff ff ff ff ff ff ff e7 ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 133b0: ff bf ff ff ff 7f ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 133c0: ff ff df ff ff f7 ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 133d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 133e0: ff ff ff ff ff f7 ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 133f0: ff ff ff ff ff ff ff ff ff ff ff ff ff bf ff ff
Mar 17 17:56:35 kenichi kernel: 13400: ff ff ff ff ff ff ff ff fb bf ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13410: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13420: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13430: ff ff ff ff fb ff ff ff ff ff fe ff ff ff 7f ff
Mar 17 17:56:35 kenichi kernel: 13440: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13450: ff ff ff ff ff ff ff fb ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13460: ff ff ff ff ff ff ff ff f3 ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13470: ff ff ff ff ff ff ff ff ff ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13480: ff ff ff ff ff ff ff ff ff ff ff ff 7f ff ff ff
Mar 17 17:56:35 kenichi kernel: 13490: ff fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 134a0: ff ff ff 7f ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 134b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff
Mar 17 17:56:35 kenichi kernel: 134c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 134d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 134e0: ff ff ff ff ff ff ff f7 ff ff ff fb ff df ff ff
Mar 17 17:56:35 kenichi kernel: 134f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff df
Mar 17 17:56:35 kenichi kernel: 13500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13510: ff ff ff ff ff ff ff ff ff ff ff bf fb ff f7 ff
Mar 17 17:56:35 kenichi kernel: 13520: ff ff ff ff ff ff ff ff ff ff ff 7f ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13530: ff ff ff ff ff ff ff ff ff ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13540: ff df ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13550: ff ff ff ff ff bf ff ff ff bf ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13560: ff ff ff df ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13570: ff ff ff ff ff ff fb ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13590: ff ff ff ff ff ff ff ff fe ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 135a0: ff ff ff fb ff ff ff ff bf ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 135b0: ff ff ff ff 7f ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 135c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 135d0: ff df ff ff ff ff ff ff ff bf ff ff fe ff ff ff
Mar 17 17:56:35 kenichi kernel: 135e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 135f0: ff ff ff ff ff ff ff df ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13610: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13620: ff ff ff ff ff ff ff bf ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13630: ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff ff
Mar 17 17:56:35 kenichi kernel: 13640: ff ff ff f7 ff ff ff ff ff ff df ff ff ff fb ff
Mar 17 17:56:35 kenichi kernel: 13650: fb ff fb ff ff ff ff ff ff ff ff ff fd ff ff ff
Mar 17 17:56:35 kenichi kernel: 13660: df ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13670: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13680: ff ff ff ff ff ff ff ff fb ff ff ff ff ff fb ff
Mar 17 17:56:35 kenichi kernel: 13690: ff ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 136a0: ff ff 7f ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 136b0: ff ff ff f7 ff ff ff ff ff ff ff ff ff ff ff fe
Mar 17 17:56:35 kenichi kernel: 136c0: ff ff 7f ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 136d0: ff ff ff ff ff fb fb ff ff ff ff ff fb ff ff ff
Mar 17 17:56:35 kenichi kernel: 136e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 136f0: ff ff fd ff ff ff ff ff fb ff ff f7 ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13700: ff ff f7 ff ff ff ff ff ff ff ff ff ff df ff ff
Mar 17 17:56:35 kenichi kernel: 13710: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13720: ff ff ff ff ff ff fb ff df ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13730: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13740: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13750: ff ff bf ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13760: ff ff ff ff bf ff ff ff ff ff ff ff ff fb ff ff
Mar 17 17:56:35 kenichi kernel: 13770: ff ff ff ff ff ff ff ff ff ff f7 ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13780: ff ff bf ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13790: ff ff ff ff ff ff ff ff 7f bf ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 137a0: ff ff ff ff ff ff ff ff ff ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 137b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff df ff
Mar 17 17:56:35 kenichi kernel: 137c0: ff ff ff ff ff ff ff ff fb ff ff fe ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 137d0: ff ff ff ff ff ff ff ff ff f7 ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 137e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 137f0: fb ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13800: ff ff fb ff ff ff ff ff ff ff ff ff ff f7 ff ff
Mar 17 17:56:35 kenichi kernel: 13810: 7f ff ff ff ff ff ff ff ff ff ff ff ff ff 7f ff
Mar 17 17:56:35 kenichi kernel: 13820: ff ff ff ff ff ff ff ff ff ff fb 7f ef ff 7f ff
Mar 17 17:56:35 kenichi kernel: 13830: ff ff fd ff ff ff df ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13840: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13850: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13860: 7f ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13870: ef ff ff ff ff ff ff ff ff ff 7f ff ff fe ff ff
Mar 17 17:56:35 kenichi kernel: 13880: ff ff ff ff ff bf ff ff f7 fd ff ff ff bf ff ff
Mar 17 17:56:35 kenichi kernel: 13890: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 138a0: ff ff ff ff ff ff fb ff ff fd ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 138b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 138c0: fb ff fb ff ff 7f ff ff ef ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 138d0: ff ff df ff ff ff ff df ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 138e0: ff ff ff ff ff ff df ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 138f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13900: ff ff ff ff ff ff ff ff ef df ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13910: ff df ff ff ff ff ff ff ff bf df ff ff ff ef ff
Mar 17 17:56:35 kenichi kernel: 13920: ff ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13930: ff 7f ff 7f ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13940: ff ff ff ef ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13950: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13960: ff ff ff ff ff ff ff ff ff fb ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13970: ff ff df ff ff ff fe ff ff ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13980: ff df ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13990: ff ff ff ff ff ff ff ff ff ff ff ff ff f7 ff ff
Mar 17 17:56:35 kenichi kernel: 139a0: ff ff ff ff ff ff ff ff ff ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 139b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 139c0: ff df ff 7f ff ff fd ff ff ff ff ff ff bf ef ff
Mar 17 17:56:35 kenichi kernel: 139d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff df 7f
Mar 17 17:56:35 kenichi kernel: 139e0: ff ff ff ff ff ff ff ff ff ff ff ff ff bf ff ff
Mar 17 17:56:35 kenichi kernel: 139f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a00: ff ff ff ff ff db ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a10: ff ff ff ff ff ff 7f ff ff fd ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a20: ff ff ff ff ff ff ff ff df ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a30: ff ff ff ff ff f7 bf ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a40: ff ff ff ff ff ff ff ff fe ff ff ff ff ff ff ef
Mar 17 17:56:35 kenichi kernel: 13a50: ff bf ff ff ff ff f7 ff ff ff df ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a60: ff ff ff ff ff fb ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a80: ff f7 ff ff ff ff 7f ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13a90: ff ff ff ff ff ff ff ff ff ff df ff bf ff ff ff
Mar 17 17:56:35 kenichi kernel: 13aa0: ff ff ff ff ff ff ff ff ff ff ff ff 5f ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ab0: ff ff df ff ff ff ff ff ff ff ff ff 7f ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ac0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ad0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ae0: ff ff ff ff ff ff fb ff ff 7f ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13af0: ff ff ff ff ff ff ff ff fb ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b00: ff ff ff ff ff fd ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b10: ff ff 7f 7f ff bf ff ff 7f ff ff ff ef ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b30: ff ff ff bf ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b40: ff ff ff ff ff df ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b70: ff ff ff ff ff ff ff 7f ff ff 7f ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b80: ff df ff fb df fb ff ff 7f ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13b90: ff ff ff ff ff ff ff ff fe ff fb ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ba0: ff ff ff ff ff ff ff ff ff ff ff ff ff 7f ff ff
Mar 17 17:56:35 kenichi kernel: 13bb0: ff ff ff ff ff ff ff ff df ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13bc0: ff ff fb ff ff fb ff ff ff ff ff ff ff fb ff ff
Mar 17 17:56:35 kenichi kernel: 13bd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13be0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13bf0: ff ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c00: f7 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c20: ff ff bf ff ff 7f ff ff ff ff d7 ff ff ff ff bf
Mar 17 17:56:35 kenichi kernel: 13c30: ff ff ff ff ff ff ff ff ff bf 7f ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c40: ff fe fd ff ff ff f7 ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c50: ff ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13c80: ff ff ff ff ff ff ff ff bf ff ff 7f ff ff f7 ff
Mar 17 17:56:35 kenichi kernel: 13c90: ff ff ff ff ff ff ff ff ff bf ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ca0: ff df ff f7 ff fb ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13cb0: ff ff ff ff ff ff ff ff ff fe ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13cc0: fb ff ff ff ff ff ff ff ff ff ff ff ff ff ff df
Mar 17 17:56:35 kenichi kernel: 13cd0: 7f ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ce0: ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13cf0: ff ff ff ff ff ff ff ff ff bf ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d10: ff f7 ff ff ff ff ff ff ff ff ff ff ff ff 7b ff
Mar 17 17:56:35 kenichi kernel: 13d20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d50: ff ff ff ff ff fb ff ff ff fe ff ff ff bf ff ff
Mar 17 17:56:35 kenichi kernel: 13d60: ff ff ff ff ff ff ff ff 7f ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d70: ff bf ff ff ff 7f ff ff fb ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d80: ff ff ff ff ff ff ff ff f7 ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13d90: ff ff ff ff ff ff 7f ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13da0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13db0: ff ff ff ff ff ff ff ff ff ff ff fe ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13dc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13dd0: ff ff ff ff ff 7f ff ff df ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13de0: ff ff ff ff ff ff ff ff ff ff ff ff df ff ff ff
Mar 17 17:56:35 kenichi kernel: 13df0: ff ff 7f ff ff ff ff ff ff ff df ff ff 7f ef ff
Mar 17 17:56:35 kenichi kernel: 13e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e10: ff ff ff ff ff ff ff ff ff fd 7f ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e20: ff ff ff ff ff ff ff ff bf ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e30: ff ff ff ff ff ff ff ff f7 ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e40: ff ff ff 7f ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e50: ff ff ff fe ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff fb
Mar 17 17:56:35 kenichi kernel: 13e70: ff ff ff ff ff ff fb ff ff ff 5f ff ff ff df ff
Mar 17 17:56:35 kenichi kernel: 13e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13e90: ff ff ff 7f ff ff ff ff ff ff ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ea0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff
Mar 17 17:56:35 kenichi kernel: 13eb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff
Mar 17 17:56:35 kenichi kernel: 13ec0: ff ff ff ff ff ff ff ff ff ff 7f ff ff ff ff fe
Mar 17 17:56:35 kenichi kernel: 13ed0: ff ff ff ff ff ff ff ff ff ff ff ff bf ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ee0: ff ff ff ff ff ff ff ff ff fe f7 ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13ef0: ff ff ff ff ff ff fd f7 ff fd ff ff ff ff ff ff
Mar 17 17:56:35 kenichi kernel: 13f00: 50 05 ff ff f5 ff ff ff ff ff 00 01 f8 02 f8 02
Mar 17 17:56:35 kenichi kernel: 13f10: 00 08 23 08 00 01 79 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Mar 17 17:56:35 kenichi kernel: 13fd0: 00 00 bf ff ff ff ff ff ff ff ff ff ff ff df ff
Mar 17 17:56:35 kenichi kernel: 13fe0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff fb ff
Mar 17 17:56:35 kenichi kernel: 13ff0: ff ff ff ff ff ff ff ff 00 00 00 00 ff 1f 00 00
Mar 17 17:56:35 kenichi kernel: 14000:<1>Unable to handle kernel paging request at virtual address e0000000
Mar 17 17:56:35 kenichi kernel:  printing eip:
Mar 17 17:56:35 kenichi kernel: c013d458
Mar 17 17:56:35 kenichi kernel: *pde = 00000000
Mar 17 17:56:35 kenichi kernel: Oops: 0000 [#1]
Mar 17 17:56:35 kenichi kernel: PREEMPT 
Mar 17 17:56:35 kenichi kernel: CPU:    0
Mar 17 17:56:35 kenichi kernel: EIP:    0060:[check_slabp+136/240]    Not tainted VLI
Mar 17 17:56:35 kenichi kernel: EFLAGS: 00010092   (2.6.11-mm3) 
Mar 17 17:56:35 kenichi kernel: EIP is at check_slabp+0x88/0xf0
Mar 17 17:56:35 kenichi kernel: eax: 0000000a   ebx: 00014000   ecx: 00000001   edx: 00000001
Mar 17 17:56:35 kenichi kernel: esi: dffec000   edi: dfff3800   ebp: dfff3870   esp: c14eded4
Mar 17 17:56:35 kenichi kernel: ds: 007b   es: 007b   ss: 0068
Mar 17 17:56:35 kenichi kernel: Process events/0 (pid: 4, threadinfo=c14ec000 task=c14d6a40)
Mar 17 17:56:35 kenichi kernel: Stack: c03e9885 00014000 df000009 dffec000 00000007 dffec000 dfff3800 dfff380c 
Mar 17 17:56:35 kenichi kernel:        c013e0bc dfff3800 dffec000 00000001 0000007b dfff375c dfff375c dfff3800 
Mar 17 17:56:35 kenichi kernel:        00000001 c013e66e dfff3800 dfff46c4 00000000 dfff375c c14ec000 c14ec000 
Mar 17 17:56:35 kenichi kernel: Call Trace:
Mar 17 17:56:35 kenichi kernel:  [check_redzone+188/320] check_redzone+0xbc/0x140
Mar 17 17:56:35 kenichi kernel:  [cache_reap+558/576] cache_reap+0x22e/0x240
Mar 17 17:56:35 kenichi kernel:  [worker_thread+480/688] worker_thread+0x1e0/0x2b0
Mar 17 17:56:35 kenichi kernel:  [cache_reap+0/576] cache_reap+0x0/0x240
Mar 17 17:56:35 kenichi kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Mar 17 17:56:35 kenichi kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Mar 17 17:56:35 kenichi kernel:  [worker_thread+0/688] worker_thread+0x0/0x2b0
Mar 17 17:56:35 kenichi kernel:  [kthread+165/176] kthread+0xa5/0xb0
Mar 17 17:56:35 kenichi kernel:  [kthread+0/176] kthread+0x0/0xb0
Mar 17 17:56:35 kenichi kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Mar 17 17:56:35 kenichi kernel: Code: 24 0c 89 54 24 08 8b 47 6c 31 db c7 04 24 a0 a4 3e c0 89 44 24 04 e8 d8 a1 fd ff 8b 47 3c 8d 44 00 04 39 c3 73 25 f6 c3 0f 74 3b <0f> b6 04 33 43 c7 04 24 5d aa 40 c0 89 44 24 04 e8 b3 a1 fd ff 
Mar 17 17:56:35 kenichi kernel:  <6>note: events/0[4] exited with preempt_count 1
Mar 17 18:00:58 kenichi kernel: SysRq : Emergency Sync

The second crash had the same signature, but without the prior Redzone
log entries.

I am using the reiserfs and reiser4 filesystems.

Is there further information that would be useful? Is there any information
I should gather if the redzone log entries reappear?

I will try and figure out how to recreate the problem.

Andrew Wade
