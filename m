Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWA1CXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWA1CXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWA1CW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:26042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422798AbWA1CWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:19 -0500
Date: Fri, 27 Jan 2006 18:21:21 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 09/12] Mask off GFP flags before swiotlb_alloc_coherent
Message-ID: <20060128022121.GJ17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mask-off-GFP-flags-before-swiotlb_alloc_coherent.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Andi Kleen <ak@muc.de>

Mask off GFP flags before swiotlb_alloc_coherent

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chris@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/x86_64/kernel/pci-gart.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.15.1.orig/arch/x86_64/kernel/pci-gart.c
+++ linux-2.6.15.1/arch/x86_64/kernel/pci-gart.c
@@ -244,6 +244,7 @@ dma_alloc_coherent(struct device *dev, s
 					   get_order(size));
 
 				if (swiotlb) {
+					gfp &= ~(GFP_DMA32|GFP_DMA);
 					return
 					swiotlb_alloc_coherent(dev, size,
 							       dma_handle,

--
