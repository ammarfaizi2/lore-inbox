Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVKVBzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVKVBzD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVKVBzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:55:03 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:32963 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964863AbVKVBzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:55:00 -0500
Message-ID: <43827AB1.2090908@student.ltu.se>
Date: Tue, 22 Nov 2005 02:56:01 +0100
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
>
Opps, misread your mail. Sorry.
But in that case, why shall we have any pci_*-function in the first 
place when !CONFIG_PCI? As it was before, they were contained within 
#ifdef CONFIG_PCI's.
You said your patch were easier to read, please elaborate. Yes, in the 
dgrs_init_module() (no arguments there), but you introduces new 
functions (who need to be checked out if you read the code for the first 
time) and is really #ifdef's a good idea to change function behavior? 
Isn't better to change the input? (I know, linux/pci.h does it, but at 
least that is in a .h-file with inline functions containing at most 
"return 0;").

Btw, you said Jeff should decide. Why not Rich Richardson who is the author?

Apologize for the ranting.
As I said before, thinking of deleting CONFIG_PCI's containing 
pci_*-functions and if so, need a valid plan for it (because of the 
pci_driver-struct). If there is any no-no in "my" way, please point it 
out to spare me/you/lkml the patches. If not for this, I would've let 
this rest and leave it to Jeff (or Rich ;) ).

cu,
Richard

