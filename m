Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVIFPJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVIFPJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVIFPJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:09:54 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:37572 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750709AbVIFPJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:09:53 -0400
Message-ID: <431DB127.3010809@emc.com>
Date: Tue, 06 Sep 2005 11:09:27 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: use common pci remove in ahci
References: <20050903071852.95A10271C2@lns1058.lss.emc.com> <431CBDCB.40903@pobox.com>
In-Reply-To: <431CBDCB.40903@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.6.14
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Brett Russ wrote:
>> 2) Isn't it wrong for the IRQ disable at the chip to occur *after*
>> free_irq() is called to disconnect the handler (independent of
>> question 1...since this is the case currently)?  Granted, all of the
>> ports have gone through scsi_remove_host() but theoretically there
>> still is a possibility the chip could interrupt.
>>
>> If I'm wrong on both counts I'll blame it on need for sleep... :-)
> 
> 
> 
> Moving AHCI away from ata_pci_remove_one() was actually intentional. 
> This gives the driver a bit more freedom:  legacy region handling and 
> ->host_stop() became unnecessary.  Also, I was concerned that 
> ata_pci_remove_one() might grow into a one-size-fits-all unmaintainable 
> behemoth.
> 
> Short term, if one were being obsessive, a potential cleanup could be to 
> make common the two loops in ahci_remove_one()/ata_pci_remove_one().
> 
> Long term, libata driver API should become more like the 
> register_foo()/unregister_foo() interfaces you see elsewhere in the 
> kernel.  That direction has the potential to shake up the current code 
> path through ata_pci_remove_one().
> 
> So... your patch, while technically correct, is going in the opposite 
> direction to where I want to go :)


Good to know, thanks for explaining the goals.  How about question #2 above?

Thanks,
BR
