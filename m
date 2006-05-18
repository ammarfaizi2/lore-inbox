Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWERLdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWERLdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWERLda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:33:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:55898 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751345AbWERLd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:33:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=V/RxpdhaQFDSGhOLg7lRI0hXCsQXlJZZgSnnbDOuJHT3QODu7XmgHDM5Bjhy9w4Pjl4Kbm+UL8OHSF1CVnIc+fwdAE+aT/Do40p++eGXvEhN0Zn7NpTf22ARANW6YzlR9Jh3KA43UyAzDtATRdC/FNdiWvyc0ac6S84u8DLQnrw=
Message-ID: <446C5B83.9000305@gmail.com>
Date: Thu, 18 May 2006 20:33:23 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: albertl@mail.com
CC: Andrew Morton <akpm@osdl.org>, jeff@garzik.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <446C5957.9040404@tw.ibm.com>
In-Reply-To: <446C5957.9040404@tw.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Lee wrote:
>> To sum up, it happens when the master slot is occupied by an ATAPI
>> device and the corresponding slave slot is empty.  The slave slot
>> reports ATAPI signature (probably duplicated from the master) and passes
>> all legacy presence test thus resulting in timeout on IDENTIFY.
>>
> 
> This problem was seen with PATA Promise 20275 adapter + IBM DVD-RAM drive.
> Single master device configuration, no slave device.
> The master device acts as slave and creates a phantom slave device.
> (http://marc.theaimsgroup.com/?l=linux-ide&m=113151315602979&w=2)
> 
> The problem was later fixed by Tejun's ata_exec_internal() patch:
> (http://marc.theaimsgroup.com/?l=linux-ide&m=113455450809405&w=2)
> After the patch, the phantom device is finally detected by ata_dev_identify().
> 
> Libata uses polling PIO for IDENTIFY DEVICE before this major update.
> The polling PIO finds something wrong when it reads a 0x00 device status.
> So, the phantom device is detected quite quickly.
> 
> With irq-driven PIO, maybe the phantom device is only detected after time-out.
> So it takes longer (30 secs) to detect the phantom device.
> 
> No good idea how to fix this. Maybe read more registers to see whether the
> phantom device can be detected early before the IDENTIFY DEVICE.
> 

Does the Promise controller show the ghosting problem again with the 
recent updates?  ata_piix can be fixed by using PCS present bits.  I 
don't know about Promise though.

-- 
tejun
