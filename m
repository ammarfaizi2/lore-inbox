Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130719AbRCMBTr>; Mon, 12 Mar 2001 20:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130722AbRCMBTh>; Mon, 12 Mar 2001 20:19:37 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:52997 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130719AbRCMBT0>; Mon, 12 Mar 2001 20:19:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 13 Mar 2001 12:18:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15021.30069.381855.886337@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - compile fix for 3c509.c in 2.4.3-pre3
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 in 2.4.3-pre3, drivers/net/3c509.c will not compile ifdef CONFIG_ISAPNP.

 The following patches fixes the error.  I suspect that 3c515.c has
 the same problem, but I didn't need to fix that to get my kernel to
 build... so I didn't.

NeilBrown



--- ./drivers/net/3c509.c	2001/03/12 00:39:58	1.1
+++ ./drivers/net/3c509.c	2001/03/12 01:31:13	1.2
@@ -327,7 +327,7 @@
 			irq = idev->irq_resource[0].start;
 			if (el3_debug > 3)
 				printk ("ISAPnP reports %s at i/o 0x%x, irq %d\n",
-					el3_isapnp_adapters[i].name, ioaddr, irq);
+					(char *)el3_isapnp_adapters[i].driver_data, ioaddr, irq);
 			EL3WINDOW(0);
 			for (j = 0; j < 3; j++)
 				el3_isapnp_phys_addr[pnp_cards][j] =
