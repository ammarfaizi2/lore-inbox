Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWIVLcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWIVLcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIVLcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:32:18 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:19372 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751084AbWIVLcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:32:17 -0400
Message-ID: <4513C9BF.7040706@grupopie.com>
Date: Fri, 22 Sep 2006 12:32:15 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Om Narasimhan <om.turyx@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>	 <20060921072017.GA27798@us.ibm.com>	 <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com> <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com> <4513A21C.40704@gmail.com>
In-Reply-To: <4513A21C.40704@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Om Narasimhan wrote:
>> [...]
>> --- a/drivers/block/cpqarray.c
>> +++ b/drivers/block/cpqarray.c
>> @@ -424,7 +424,7 @@ static int __init cpqarray_register_ctlr
>>     hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
>>         hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
>>         &(hba[i]->cmd_pool_dhandle));
>> -    hba[i]->cmd_pool_bits = kmalloc(
>> +    hba[i]->cmd_pool_bits = kzalloc(
>>         ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
>>         GFP_KERNEL);
> 
> kcalloc?

Agreed on every comment except this one. That complex expression is 
really just a constant in the end, so there is no point in using kcalloc.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
