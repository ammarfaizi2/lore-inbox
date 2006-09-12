Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWIMBTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWIMBTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWIMBTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:19:31 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:56594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030479AbWIMBTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:19:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m1E6qqdw4ec7tUBRWdEmryfY0IqgwhYmLm7N18oQdaTGY4u2zrmWWDCDzk105Kkpn0RB83dXZ+90uggyHttJs80mh2fGHEGS5CgcSE0nQz1khIclTiic6RtXQ8uBBB4TSsnEkLOVIBilRvK7T8VkdDXH/DmGeepFMnBi0U6xXV4=
Message-ID: <4506AB4B.9010801@gmail.com>
Date: Tue, 12 Sep 2006 21:42:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Michael Tokarev <mjt@tls.msk.ru>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Vendor field with USB, [SP]ATA etc-attached disks
References: <4505A612.8070603@tls.msk.ru> <4505BA2B.1020105@garzik.org>
In-Reply-To: <4505BA2B.1020105@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Michael Tokarev wrote:
>> With current SATA, PATA and at least some USB disks,
>> Linux reports Vendor: $subsystem, instead of the actual
>> vendor of the drive, like this:
>>
>> scsi1 : ata_piix
>>   Vendor: ATA       Model: ST3808110AS       Rev: n/a
>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>
>> This should be Vendor: Seagate, not ATA (Note also the lack
>> of "Revision" field).  The same for PATA disk:
>>
>> scsi0 : pata_via
>>   Vendor: ATA       Model: ST3120026A        Rev: 3.76
>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>
>> The same is shown in /sys/block/$DEV/device/vendor.
>>
>> Can it be changed to show real vendor, instead of the subsystem name?
> 
> No.  Two reasons:
> 
> * ATA doesn't export the vendor separate from the model, and in some 
> cases (Seagate) it isn't present at all, anywhere.
> * "ATA" vendor string is the standardized value to put in that field, 
> according to the SCSI T10 specifications.

To add a small detail.  The reason it's printed that way is because 
libata (the new ATA driver) emulates SCSI device at the moment, so it 
has to fake SCSI vendor ID and model string, which BTW is shorter than 
ATA string and thus truncated in some cases.  The vendor ID "ATA" is 
defined in SAT (SCSI ATA translation) standard, IIRC.

For the time being, we'll have to live with boilerplate ATA vendor and 
truncated vendor ID.  There are plans to make libata independent from 
SCSI which should solve the problem but it will take quite some time.

-- 
tejun

