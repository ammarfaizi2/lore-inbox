Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311519AbSCNFX5>; Thu, 14 Mar 2002 00:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311520AbSCNFXi>; Thu, 14 Mar 2002 00:23:38 -0500
Received: from f00135.st.wakwak.ne.jp ([61.115.73.82]:35847 "EHLO
	suika.yamamoto.gr.jp") by vger.kernel.org with ESMTP
	id <S311519AbSCNFXf>; Thu, 14 Mar 2002 00:23:35 -0500
Message-Id: <200203140521.AA03472@vine.yamamoto.gr.jp>
Date: Thu, 14 Mar 2002 14:21:02 +0900
To: linux-kernel@vger.kernel.org
Subject: BUG CORRECTION: at1700.c
From: sawa <sawa@yamamoto.gr.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] at1700.c bug correction.    
[2.] Multicast does not work.
[3.] ethernet, at1700, fmv18x, fujitsu, NIC, driver, network, module
[4.] 2.4.18
[X.] 
PATCH:
% diff -u at1700.c.org at1700.c
--- at1700.c.org        Thu Oct 11 15:24:09 2001
+++ at1700.c    Thu Mar 14 00:44:15 2002
@@ -856,6 +856,7 @@
                         i++, mclist = mclist->next)
                        set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 26,
                                        mc_filter);
+               outb(0x02, ioaddr + RX_MODE);   /* Use normal mode. */
        }

        save_flags(flags);

RESULT:
 I observed that multicast works using this patch.

ACKNOWLEDGMENT:
 This code was written by Tamiya-san.
