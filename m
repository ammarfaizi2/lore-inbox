Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbULCVvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbULCVvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbULCVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:51:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:47288 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbULCVvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:51:06 -0500
Message-ID: <41B0DC46.7050906@osdl.org>
Date: Fri, 03 Dec 2004 13:36:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rf@q-leap.de
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Trouble with swiotlb
References: <16816.30598.368287.762457@gargle.gargle.HOWL>
In-Reply-To: <16816.30598.368287.762457@gargle.gargle.HOWL>
Content-Type: multipart/mixed;
 boundary="------------040709030402050206040308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040709030402050206040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Roland Fehrenbacher wrote:
> Hi,
> 
> when building 2.4.28 or 2.4.27 on x86_64 with IOMMU and SWIOTLB support
> enabled I get unresolved symbol for 3 modules:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.28/kernel/drivers/net/e1000/e1000.o
> depmod: *** Unresolved symbols in /lib/modules/2.4.28/kernel/drivers/usb/host/uhci.o
> depmod: *** Unresolved symbols in /lib/modules/2.4.28/kernel/drivers/usb/host/usb-uhci.o
> 
> When modprobing any of the modules I get:
> unresolved symbol swiotlb
> 
> The kernel boots fine on Opterons and EM64T Xeons otherwise.
> 
> Any ideas.

Looks like it just needs 'swiotlb' exported (as in 2.6.x).
Can you test the attached patch?
I don't have 2.4.x booting on x8-64 yet.

-- 
~Randy


--------------040709030402050206040308
Content-Type: text/x-patch;
 name="swiotlb_2428.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swiotlb_2428.patch"

linux-2428-work
<description>

Signed-off-by: Your Name <email@domain.tld>

diffstat:=
 arch/x86_64/kernel/setup.c |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./arch/x86_64/kernel/setup.c~swiotlb ./arch/x86_64/kernel/setup.c
--- ./arch/x86_64/kernel/setup.c~swiotlb	2004-08-07 16:26:04.000000000 -0700
+++ ./arch/x86_64/kernel/setup.c	2004-12-03 11:54:07.000000000 -0800
@@ -52,6 +52,7 @@ int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);
 
 int swiotlb;
+EXPORT_SYMBOL(swiotlb);
 
 extern	int phys_proc_id[NR_CPUS];
 

--------------040709030402050206040308--
