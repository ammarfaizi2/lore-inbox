Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSE1EzY>; Tue, 28 May 2002 00:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSE1EzX>; Tue, 28 May 2002 00:55:23 -0400
Received: from mail.turbolinux.co.jp ([210.171.55.67]:29702 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S312381AbSE1EzX>; Tue, 28 May 2002 00:55:23 -0400
Date: Tue, 28 May 2002 13:50:26 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [PATCH] fixup pcnet32 workaround xSeries250
Message-Id: <20020528135026.4e669b53.go@turbolinux.co.jp>
Organization: Turbolinux
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have sent the update patch for pcnet32 which included the workaround for xSeries250 
on the other day.

However, the workaround has the problem with 79C970A 10M full duplex cards 
which causes the netowrk slowing-down.
To solve this problem, the workaound is set to be turned on for "79C975" only.
Please apply.

-- GO!

--- linux/drivers/net/pcnet32.c.orig	Mon May 27 17:15:12 2002
+++ linux/drivers/net/pcnet32.c	Tue May 28 12:35:29 2002
@@ -847,8 +847,9 @@
 	    if (lp->options == (PCNET32_PORT_FD | PCNET32_PORT_AUI))
 		val |= 2;
 	} else if (lp->options & PCNET32_PORT_ASEL) {
-	/* workaround for xSeries250 */
-	    val |= 3;
+	/* workaround of xSeries250, turn on for 79C975 only */
+	    i = ((lp->a.read_csr(ioaddr, 88) | (lp->a.read_csr(ioaddr,89) << 16)) >> 12) & 0xffff;
+	    if (i == 0x2627) val |= 3;
 	}
 	lp->a.write_bcr (ioaddr, 9, val);
     }
