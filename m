Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVAPPpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVAPPpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVAPPpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:45:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:48013 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261268AbVAPPpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:45:08 -0500
Date: Sun, 16 Jan 2005 16:37:32 +0100 (MET)
Message-Id: <200501161537.j0GFbWE3028005@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@stusta.de, hch@lst.de
Subject: Re: [PATCH] fix CONFIG_AGP depencies
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 13:09:11 +0100, Christoph Hellwig wrote:
>On Sun, Jan 16, 2005 at 01:05:50PM +0100, Adrian Bunk wrote:
>> This doesn't seem to achieve what you want:
>> PPC is defined on ppc64...
>
>*grmbl*
>
>
>--- 1.39/drivers/char/agp/Kconfig	2005-01-08 01:15:52 +01:00
>+++ edited/drivers/char/agp/Kconfig	2005-01-16 11:39:56 +01:00
>@@ -1,5 +1,6 @@
> config AGP
>-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K && !ARM
>+	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
>+	depends on ALPHA || IA64 || PPC32 || X86
> 	default y if GART_IOMMU
> 	---help---
> 	  AGP (Accelerated Graphics Port) is a bus system mainly used to

You're preventing the ppc64 kernel for Apple PowerMac G5s
from including AGP support via CONFIG_AGP_UNINORTH. I doubt
that's correct.
