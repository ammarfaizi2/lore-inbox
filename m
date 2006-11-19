Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933390AbWKSVmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933390AbWKSVmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933389AbWKSVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:42:40 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:63929 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S933388AbWKSVmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:42:39 -0500
Date: Sun, 19 Nov 2006 22:36:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jay Cliburn <jacliburn@bellsouth.net>
cc: jeff@garzik.org, shemminger@osdl.org, romieu@fr.zoreil.com,
       csnook@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
In-Reply-To: <20061119203006.GC29736@osprey.hogchain.net>
Message-ID: <Pine.LNX.4.61.0611192233270.6324@yvahk01.tjqt.qr>
References: <20061119203006.GC29736@osprey.hogchain.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 19 2006 14:30, Jay Cliburn wrote:
>+
>+#define	LBYTESWAP( a )  ( ( ( (a) & 0x00ff00ff ) << 8 ) | ( ( (a) & 0xff00ff00 ) >> 8 ) )
>+#define	LONGSWAP( a )	( ( LBYTESWAP( a ) << 16 ) | ( LBYTESWAP( a ) >> 16 ) )
>+#define	SHORTSWAP( a )	( ( (a) << 8 ) | ( (a) >> 8 ) )

Please use swab16/swab32 for these.

>+#define AT_DESC_UNUSED(R) \
>+	((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
>+	(R)->next_to_clean - (R)->next_to_use - 1)
>+
>+#define AT_DESC_USED(R) \
>+	(((R)->next_to_clean > (R)->next_to_use) ?	\
>+		((R)->count+(R)->next_to_use-(R)->next_to_clean+1) : \
>+		((R)->next_to_use-(R)->next_to_clean+1))

These look like they are on the edge to be written as a static-inline function.
What do others think?

>+#define AT_WRITE_REG(a, reg, value) ( \
>+	writel((value), ((a)->hw_addr + reg)))
>+
>+#define AT_READ_REG(a, reg) ( \
>+	readl((a)->hw_addr + reg ))
>+
>+#define AT_WRITE_REGB(a, reg, value) (\
>+	writeb((value), ((a)->hw_addr + reg)))
>+
>+#define AT_READ_REGB(a, reg) (\
>+	readb((a)->hw_addr + reg))
>+
>+#define AT_WRITE_REGW(a, reg, value) (\
>+	writew((value), ((a)->hw_addr + reg)))
>+
>+#define AT_READ_REGW(a, reg) (\
>+	readw((a)->hw_addr + reg))
>+
>+#define AT_WRITE_REG_ARRAY(a, reg, offset, value) ( \
>+	writel((value), (((a)->hw_addr + reg) + ((offset) << 2))))
>+
>+#define AT_READ_REG_ARRAY(a, reg, offset) ( \
>+	readl(((a)->hw_addr + reg) + ((offset) << 2)))

Possibly similarly.


	-`J'
-- 
