Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVKUVmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVKUVmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVKUVmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:42:46 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:38326 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750886AbVKUVmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:42:44 -0500
Message-ID: <43824066.4080109@student.ltu.se>
Date: Mon, 21 Nov 2005 22:47:18 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com, ashutosh.naik@gmail.com
Subject: Re: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
References: <E1EdmMo-00020b-00@gondolin.me.apana.org.au> <438097D2.9020607@student.ltu.se> <20051120204001.GA11043@gondor.apana.org.au> <4381C321.5010805@student.ltu.se> <20051121203758.GA25509@gondor.apana.org.au>
In-Reply-To: <20051121203758.GA25509@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>On Mon, Nov 21, 2005 at 01:52:49PM +0100, Richard Knutsson wrote:
>  
>
>>This patch requirer the 
>>"net-fix-compiler-error-on-dgrsc-when-config_pci.patch" (added to the 
>>-mm tree after 2.6.15-rc1-mm2):
>>
>>--- 
>>devel/drivers/net/dgrs.c~net-fix-compiler-error-on-dgrsc-when-config_pci 
>>2005-11-19 18:00:34.000000000 -0800
>>+++ devel-akpm/drivers/net/dgrs.c	2005-11-19 18:00:34.000000000 -0800
>>@@ -1458,6 +1458,8 @@ static struct pci_driver dgrs_pci_driver
>>	.probe = dgrs_pci_probe,
>>	.remove = __devexit_p(dgrs_pci_remove),
>>};
>>+#else
>>+static struct pci_driver dgrs_pci_driver = {};
>>#endif
>>    
>>
>
>I don't see the point.  We shouldn't have this structure at all
>if CONFIG_PCI is not set.
>
>Cheers,
>
We need it even if pci_register_driver() and pci_register_driver() is 
empty shells. And instead of removing #endif CONFIG_PCI for 
dgrs_pci_driver, which needs dgrs_pci_tbl, dgrs_pci_probe() and 
dgrs_pci_remove() (and so on), I added the empty dgrs_pci_driver-structure.

cu,

