Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUJXQEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUJXQEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUJXQDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:03:52 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:52864 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261544AbUJXP7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:59:30 -0400
Date: Sun, 24 Oct 2004 19:59:23 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: alex@local.promotion-ie.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.9 on alpha noritake
Message-ID: <20041024195923.A794@den.park.msu.ru>
References: <1098476483.11296.37.camel@pro30.local.promotion-ie.de> <1098520279.14984.12.camel@pro30.local.promotion-ie.de> <20041023175811.GA23184@twiddle.net> <20041024144329.A623@den.park.msu.ru> <1098632003.8479.4.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1098632003.8479.4.camel@pro30.local.promotion-ie.de>; from alex@local.promotion-ie.de on Sun, Oct 24, 2004 at 05:33:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 05:33:23PM +0200, alex@local.promotion-ie.de wrote:
> but as usually one thing fixed next broken....
> now the sym53c8xx won't scan the SCSI bus.

Probably it's my fault - previous patch was incomplete.
Please try this one instead.

Ivan.

--- 2.6.9/include/asm-alpha/core_cia.h	Tue Oct 19 01:54:30 2004
+++ linux/include/asm-alpha/core_cia.h	Sun Oct 24 16:52:42 2004
@@ -347,14 +347,14 @@ __EXTERN_INLINE unsigned int cia_ioread8
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
 
-	/* We can use CIA_MEM_R1_MASK for io ports too, since it is large
-	   enough to cover all io ports, and smaller than CIA_IO.  */
-	addr &= CIA_MEM_R1_MASK;
 	if (addr >= CIA_DENSE_MEM)
 		base_and_type = CIA_SPARSE_MEM + 0x00;
 	else
 		base_and_type = CIA_IO + 0x00;
 
+	/* We can use CIA_MEM_R1_MASK for io ports too, since it is large
+	   enough to cover all io ports, and smaller than CIA_IO.  */
+	addr &= CIA_MEM_R1_MASK;
 	result = *(vip) ((addr << 5) + base_and_type);
 	return __kernel_extbl(result, addr & 3);
 }
@@ -364,12 +364,12 @@ __EXTERN_INLINE void cia_iowrite8(u8 b, 
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long w, base_and_type;
 
-	addr &= CIA_MEM_R1_MASK;
 	if (addr >= CIA_DENSE_MEM)
 		base_and_type = CIA_SPARSE_MEM + 0x00;
 	else
 		base_and_type = CIA_IO + 0x00;
 
+	addr &= CIA_MEM_R1_MASK;
 	w = __kernel_insbl(b, addr & 3);
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
@@ -379,12 +379,12 @@ __EXTERN_INLINE unsigned int cia_ioread1
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
 
-	addr &= CIA_MEM_R1_MASK;
 	if (addr >= CIA_DENSE_MEM)
 		base_and_type = CIA_SPARSE_MEM + 0x08;
 	else
 		base_and_type = CIA_IO + 0x08;
 
+	addr &= CIA_MEM_R1_MASK;
 	result = *(vip) ((addr << 5) + base_and_type);
 	return __kernel_extwl(result, addr & 3);
 }
@@ -394,12 +394,12 @@ __EXTERN_INLINE void cia_iowrite16(u16 b
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long w, base_and_type;
 
-	addr &= CIA_MEM_R1_MASK;
 	if (addr >= CIA_DENSE_MEM)
 		base_and_type = CIA_SPARSE_MEM + 0x08;
 	else
 		base_and_type = CIA_IO + 0x08;
 
+	addr &= CIA_MEM_R1_MASK;
 	w = __kernel_inswl(b, addr & 3);
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
