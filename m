Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUCXVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUCXVU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:20:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261885AbUCXVUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:20:17 -0500
Message-ID: <4061FB7E.9000609@pobox.com>
Date: Wed, 24 Mar 2004 16:19:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] sata_via broken by recent libata updates
References: <20040324163340.GD23503@master.mivlgu.local> <4061CEB1.3080600@pobox.com>
In-Reply-To: <4061CEB1.3080600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Sergey Vlasov wrote:
> 
>> Hello!
>>
>> After updating from 2.4.25-libata1 to 2.4.25-libata9 the sata_via
>> driver stopped working.  The module loads and even seems to detect
>> the presense of drives, but the SCSI-emulation devices are not
>> registered:
> 
> [...]
> 
>> Seems that the problem is caused by changes in the device
>> initialization - calling ata_device_add() from svia_init_one() does
>> not work (at least with the 2.4.x SCSI layer).  The following patch
>> solves the initialization problem:
>>
>> --- kernel-source-2.4.25/drivers/scsi/sata_via.c.sata_via-init-fix    
>> 2004-03-22 14:03:31 +0300
>> +++ kernel-source-2.4.25/drivers/scsi/sata_via.c    2004-03-24 
>> 16:27:50 +0300
>> @@ -264,9 +264,7 @@ static int svia_init_one (struct pci_dev
>>  
>>      pci_set_master(pdev);
>>  
>> -    /* FIXME: check ata_device_add return value */
>> -    ata_device_add(probe_ent);
>> -    kfree(probe_ent);
>> +    ata_add_to_probe_list(probe_ent);
>>  
>>      return 0;
> 
> 
> Ah, indeed.  A bug in the 2.4 backport.  Seems to be present in sata_sis 
> too.
> 
> Thanks for spotting, I just checked in the attached patch.


FYI, this fix is in the 2.4.x patch just posted,

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-libata12.patch.bz2


