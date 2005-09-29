Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVI2Wvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVI2Wvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVI2Wvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:51:35 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:432 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932360AbVI2Wvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:51:35 -0400
Date: Thu, 29 Sep 2005 15:52:41 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bogus cast in IXP2000 I/O macro
Message-ID: <20050929225241.GA3465@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Physical addresses are not valid pointers of any sort and should not be cast 
to such.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/include/asm-arm/arch-ixp2000/ixdp2x01.h b/include/asm-arm/arch-ixp2000/ixdp2x01.h
--- a/include/asm-arm/arch-ixp2000/ixdp2x01.h
+++ b/include/asm-arm/arch-ixp2000/ixdp2x01.h
@@ -22,7 +22,7 @@
 #define	IXDP2X01_CPLD_REGION_SIZE	0x00100000
 
 #define IXDP2X01_CPLD_VIRT_REG(reg) (volatile unsigned long*)(IXDP2X01_VIRT_CPLD_BASE | reg)
-#define IXDP2X01_CPLD_PHYS_REG(reg) (volatile u32*)(IXDP2X01_PHYS_CPLD_BASE | reg)
+#define IXDP2X01_CPLD_PHYS_REG(reg) (IXDP2X01_PHYS_CPLD_BASE | reg)
 
 #define IXDP2X01_UART1_VIRT_BASE	IXDP2X01_CPLD_VIRT_REG(0x40)
 #define IXDP2X01_UART1_PHYS_BASE	IXDP2X01_CPLD_PHYS_REG(0x40)

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
