Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290977AbSBLLqr>; Tue, 12 Feb 2002 06:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290974AbSBLLqh>; Tue, 12 Feb 2002 06:46:37 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:22284 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S290973AbSBLLqU>; Tue, 12 Feb 2002 06:46:20 -0500
Date: Tue, 12 Feb 2002 20:45:02 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pcnet32 workaround for IBM xSeries250
Message-Id: <20020212204502.4743b3e7.go@turbolinux.co.jp>
Organization: Turbolinux
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is workaround for IBM xSeries250 onbord AMD79C975.
Auto negotiation failed with full duplex HUB.

If we set it to auto negotiation, this patch will be meaningless.
However, this patch is needed by auto-negotiation of full-duplex

The status is as follows:

setup HUB to half duplex. link OK
setup HUB to full duplex. link OK

Of course, AMD79C973 wrok too.
It's been tested by IBM staff too.

--- linux/drivers/net/pcnet32.c.orig	Sun Jan 27 02:30:16 2002
+++ linux/drivers/net/pcnet32.c	Sun Jan 27 02:37:16 2002
@@ -857,6 +857,9 @@
 	    val |= 1;
 	    if (lp->options == (PORT_FD | PORT_AUI))
 		val |= 2;
+	} else if (lp->options & PORT_ASEL) {
+	/* workaround for xSeries250 */
+	    val |= 3;
 	}
 	lp->a.write_bcr (ioaddr, 9, val);
     }
