Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWEMDmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWEMDmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWEMDmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:42:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37089 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932174AbWEMDml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:42:41 -0400
Message-ID: <446555AA.9000603@pobox.com>
Date: Fri, 12 May 2006 23:42:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ata_piix failure on ich6m
References: <20060510235650.GA20206@srcf.ucam.org> <44629E68.3020302@gmail.com>
In-Reply-To: <44629E68.3020302@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Matthew Garrett wrote:
>> Hi,
>>
>> We've got an ich6m system (a Toshiba Portege S100). ata_piix attempts 
>> to drive the chipset, but fails - however, it doesn't bail out. As a 
>> result it remains bound to the device and ahci isn't loaded.
>>
>> I've attached the lspci output for the chipset. A few things to note are:
>>
>> 1) The AHCI BAR is set
>> 2) The SCC register identifies it as an AHCI controller
>> 3) Bits 2 and 0 of the PCS are set, which the spec claims indicates 
>> that the port is to be controlled as an ahci device.
>>
>> So, my question is effectively: why does ata_piix attempt to disable 
>> ahci rather than simply letting the ahci driver bind? Points (1) and 
>> (2) seem to be checked by the code, but I'm guessing that in the case 
>> of (3) it should just return ENODEV and let ahci be run instead. If 
>> so, should I code up a patch?
>>
> 
> I'm not very sure but it might be historical.  ahci got implemented 
> after ata_piix and in the meantime ata_piix must have handled all it 
> could.  Can you verify whether modifying the code to return -ENODEV work 
> for your machine?  If so, that could be the correct solution but I'm a 
> bit worried because it could change probing order or fail to enable 
> devices it used to.  Maybe we need a hack to return -ENODEV iff ahci is 
> there to handle the device.

It's definitely historical.  I'm pretty frazzled now so I don't 
remember.  It may be that on ICH6, AHCI mode does not cause the PCI IDs 
to change, so driver load order winds up dictating what gets used.

	Jeff



