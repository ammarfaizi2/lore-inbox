Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbUAFR0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUAFR0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:26:00 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:48808 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264594AbUAFRZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:25:59 -0500
Date: Tue, 6 Jan 2004 09:24:45 -0800
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support in ia64 generic kernels
Message-ID: <20040106172445.GA24489@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040106010924.GA21747@sgi.com> <20040106102538.A14492@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106102538.A14492@infradead.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 10:25:38AM +0000, Christoph Hellwig wrote:
> On Mon, Jan 05, 2004 at 05:09:24PM -0800, Jesse Barnes wrote:
> > The 'depends' directive for SGI IOC4 support is too restrictive.  Just
> > kill it altogether.
> 
> Umm, it won't work for anything but a kernel with SN2 support compile in
> due to the bridge-level dma byteswapping it needs (through a week symbol,
> that's why you don't see compile failures for other architectures, eek!).

Good point.  They'll need either CONFIG_IA64_SGI_SN2 or
CONFIG_IA64_GENERIC to get the right stuff.

> So at least make it depend on CONFIG_IA64

Here's a more correct fix that should prevent people from seeing build
failures at all.

Jesse

===== drivers/ide/Kconfig 1.33 vs edited =====
--- 1.33/drivers/ide/Kconfig	Mon Dec 29 13:37:48 2003
+++ edited/drivers/ide/Kconfig	Tue Jan  6 09:23:30 2004
@@ -747,7 +747,7 @@
 
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset support"
-	depends on IA64_SGI_SN2
+	depends on IA64_SGI_SN2 || IA64_GENERIC
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
