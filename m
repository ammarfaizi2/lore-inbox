Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUFLSOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUFLSOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUFLSOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 14:14:20 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:28885 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264891AbUFLSOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 14:14:17 -0400
Message-ID: <40CB47F6.1060600@blue-labs.org>
Date: Sat, 12 Jun 2004 14:14:14 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [culprit found] Re: [boot hang] 2.6.7-rc2, VIA VT8237
References: <23tuk-7Os-7@gated-at.bofh.it> <23tDX-7UV-17@gated-at.bofh.it>	<23tNH-834-27@gated-at.bofh.it> <23wix-1FP-19@gated-at.bofh.it>	<2652y-760-19@gated-at.bofh.it> <m34qpgzxmu.fsf@averell.firstfloor.org>
In-Reply-To: <m34qpgzxmu.fsf@averell.firstfloor.org>
Content-Type: multipart/mixed;
 boundary="------------060503010107050607030401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060503010107050607030401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yep, that patch makes this thing bootable now :)

Thank you,
David

Andi Kleen wrote:

>David Ford <david+challenge-response@blue-labs.org> writes:
>
>  
>
>>Culprit found.  If CONFIG_IOMMU_DEBUG is enabled, the machine will
>>hang on boot at the partition check when using the VIA driver.
>>    
>>
>
>The real culprit is buggy VIA silicon. Use this patch.
>
>-Andi
>
>---------------------------------------------------------------
>Enable VIA softmmu workaround for iommu=force/IOMMU_DEBUG too
>
>diff -u linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c-o linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c
>--- linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c-o	2004-06-11 03:02:42.000000000 +0200
>+++ linux-2.6.7rc3-bk3/arch/x86_64/kernel/io_apic.c	2004-06-12 15:46:35.000000000 +0200
>@@ -252,7 +252,8 @@
> 				switch (vendor) { 
> 				case PCI_VENDOR_ID_VIA:
> #ifdef CONFIG_GART_IOMMU
>-					if (end_pfn >= (0xffffffff>>PAGE_SHIFT) &&
>+					if ((end_pfn >= (0xffffffff>>PAGE_SHIFT) ||
>+					     force_iommu) &&
> 					    !iommu_aperture_allowed) {
> 						printk(KERN_INFO
>     "Looks like a VIA chipset. Disabling IOMMU. Overwrite with \"iommu=allowed\"\n");
>
>  
>

--------------060503010107050607030401
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060503010107050607030401--
