Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTK3RCw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTK3RCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:02:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1458 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264955AbTK3RCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:02:49 -0500
Message-ID: <3FCA22A9.2050805@pobox.com>
Date: Sun, 30 Nov 2003 12:02:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: libata and pm
References: <3FC9CBB8.7020108@gmx.de> <3FCA147F.4040503@pobox.com> <3FCA2153.1040900@gmx.de>
In-Reply-To: <3FCA2153.1040900@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Jeff Garzik wrote:
> 
>> Prakash K. Cheemplavam wrote:
>>
>>> Hi,
>>>
>>> I wonder whether libata can easily be made compatible with swsup or 
>>> pmdisk.
>>>
>>> Currently my tries stop with the message:
>>>
>>> PM: Preparing system for suspend
>>> Stopping tasks: 
>>> =================================================exiting...========
>>>  stopping tasks failed (1 tasks remaining)
>>> Restarting tasks...<6> Strange, katad-1 not stopped
>>>  done
>>>
>>>
>>> I think that katad belongs to libata.
>>
>>
>>
>> I'm curious if this [completely untested] patch works?  :)
> 
> 
> Well, it works as it should -I guess-,ie. swsusp proceeds, but (as 
> expected) after all it doesn't work with scsi and swsusp gives a kernel 
> panic. But that is another matter. ;-)
> 
> Nevertheless I got following wanrings on compile (second one was already 
> there):
> 
> drivers/scsi/libata-core.c: In function `ata_thread':
> drivers/scsi/libata-core.c:2571: Warnung: implicit declaration of 
> function `refrigerator'
> drivers/scsi/libata-core.c: At top level:
> drivers/scsi/libata-core.c:2141: Warnung: `ata_qc_push' defined but not 
> used
> 
> (Furthermore the patch didn't want to apply, so I had to do it by hand.)


Duh, I'm silly... you need #include <linux/suspend.h> at the top of that 
file, too.  I'm amazed swsusp proceeds at all :)

	Jeff



