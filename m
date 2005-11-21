Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVKUXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVKUXPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVKUXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:15:48 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:22205 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932463AbVKUXPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:15:46 -0500
Message-ID: <4382563E.50502@student.ltu.se>
Date: Tue, 22 Nov 2005 00:20:30 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com, ashutosh.naik@gmail.com
Subject: Re: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
References: <E1EeJu8-0006vr-00@gondolin.me.apana.org.au>
In-Reply-To: <E1EeJu8-0006vr-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>  
>
>>We need it even if pci_register_driver() and pci_register_driver() is 
>>empty shells. And instead of removing #endif CONFIG_PCI for 
>>    
>>
>
>I don't think so.  Please see my previous patch where pci_register_driver
>is not called at all if CONFIG_PCI is not defined.
>
>Cheers,
>  
>
Yes, I know you patch don't need it (thought you commented the patch vs. 
dgrs.c, not vs. you patch). But to do that, you have to introduce a new 
dgrs-specific pci-layer to compensate. If you don't want to have an 
empty struct, is it not nicer/easier to just #ifdef CONFIG_PCI the 
pci_*-functions? (instead of two inline functions for every used 
pci_*-function?)

Am thinking of removing the #ifdef CONFIG_PCI's in other files, to 
"clean up" the code, but that would introduce this problem again, don't 
you think it is more readable to make an empty struct when !CONFIG_PCI, 
then making new pci_*-functions specific to the driver?

cu

