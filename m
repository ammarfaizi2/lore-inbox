Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVHXXwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVHXXwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVHXXwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 19:52:46 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:16789 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932364AbVHXXwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 19:52:46 -0400
Date: Wed, 24 Aug 2005 16:52:23 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.13-rc7] Fix IXP4xx flash resource range
Message-ID: <20050824235223.GA32353@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend...forgot to send to lkml]

We are currently reserving one byte more than actually needed 
by the flash device and overlapping into the next I/O expansion 
bus window. This a) causes us to allocate an extra page of VM due
to ARM ioremap() alignment code and b) could cause problems
if another driver tries to request the next expansion bus window.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -36,7 +36,7 @@ static struct flash_platform_data coyote
 
 static struct resource coyote_flash_resource = {
 	.start		= COYOTE_FLASH_BASE,
-	.end		= COYOTE_FLASH_BASE + COYOTE_FLASH_SIZE,
+	.end		= COYOTE_FLASH_BASE + COYOTE_FLASH_SIZE - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -114,7 +114,7 @@ static struct flash_platform_data gtwx57
 
 static struct resource gtwx5715_flash_resource = {
 	.start		= GTWX5715_FLASH_BASE,
-	.end		= GTWX5715_FLASH_BASE + GTWX5715_FLASH_SIZE,
+	.end		= GTWX5715_FLASH_BASE + GTWX5715_FLASH_SIZE - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -36,7 +36,7 @@ static struct flash_platform_data ixdp42
 
 static struct resource ixdp425_flash_resource = {
 	.start		= IXDP425_FLASH_BASE,
-	.end		= IXDP425_FLASH_BASE + IXDP425_FLASH_SIZE,
+	.end		= IXDP425_FLASH_BASE + IXDP425_FLASH_SIZE - 1,
 	.flags		= IORESOURCE_MEM,
 };
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
