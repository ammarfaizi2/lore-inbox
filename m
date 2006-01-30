Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWA3Jku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWA3Jku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWA3Jkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:40:49 -0500
Received: from mtaout3.012.net.il ([84.95.2.7]:14192 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S932167AbWA3Jkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:40:49 -0500
Date: Mon, 30 Jan 2006 11:40:49 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: 2.6.16-rc1-mm4
In-reply-to: <20060129144533.128af741.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark Maule <maule@sgi.com>
Message-id: <20060130094049.GF23968@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060129144533.128af741.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> 
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/

IA64 defconfig breaks with:

  CC      arch/ia64/sn/pci/tioce_provider.o
/home/muli/kernel/common-swiotlb/mm4.swiotlb/arch/ia64/sn/pci/tioce_provider.c:721:32:
macro "ATE_MAKE" requires 3 arguments, but only 2 given
/home/muli/kernel/common-swiotlb/mm4.swiotlb/arch/ia64/sn/pci/tioce_provider.c:
In function `tioce_reserve_m32':

Attached patch fixes it. Mark, looks like it's your Altix MSI support
patch (http://patchwork.ozlabs.org/linuxppc64/patch?id=4231) that
broke it. Is the fix correct?

Signed-off-by: Muli Ben-Yehuda <mulix@mulix.org>

diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/pci/tioce_provider.c mm4.ate/arch/ia64/sn/pci/tioce_provider.c
--- mm4.orig/arch/ia64/sn/pci/tioce_provider.c	2006-01-30 10:34:57.000000000 +0200
+++ mm4.ate/arch/ia64/sn/pci/tioce_provider.c	2006-01-30 11:27:58.000000000 +0200
@@ -717,7 +717,7 @@ tioce_reserve_m32(struct tioce_kernel *c
 	while (ate_index <= last_ate) {
 		u64 ate;
 
-		ate = ATE_MAKE(0xdeadbeef, ps);
+		ate = ATE_MAKE(0xdeadbeef, ps, 0);
 		ce_kern->ce_ate3240_shadow[ate_index] = ate;
 		tioce_mmr_storei(ce_kern, &ce_mmr->ce_ure_ate3240[ate_index],
 				 ate);


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

