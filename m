Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWFFQHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWFFQHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWFFQHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:07:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:52859 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750970AbWFFQHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:07:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=KUZ3kDMpAmKjWGI0UGitngeUMovNDVzCbqhWZHEh5E9oD/cOTSn5y+gCIi9exEjSAvYDs7949IVqw4DLdgDcypLD30MNL+u9K1C8JVckn3ORKUeDposD+NcNlkZ6GPrK5G68mAuOE/pHxygtoOEbejXvec+7ac2lMU3fsKt6xGE=
Message-ID: <4485A855.1020602@gmail.com>
Date: Tue, 06 Jun 2006 18:07:26 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb device problem
References: <44859A9B.6080202@gmail.com> <4485A299.7070007@rtr.ca>
In-Reply-To: <4485A299.7070007@rtr.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord napsal(a):
> Jiri Slaby wrote:
>> Hello,
>>
>> I get this with 2.6.17-rc5-mm3 kernel:
> ..
>> usb-storage: device found at 10
>> usb-storage: waiting for device to settle before scanning
>>   Vendor:           Model:                   Rev:
>>   Type:   Direct-Access                      ANSI SCSI revision: 00
>> SCSI device sdb: 245920 512-byte hdwr sectors (126 MB)
> ..
>> now read and write and sync or umount, then:
>> ---
>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 1575
>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 1583
>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 1591
>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 1599
>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 1607
>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 1615
>> ... and so on. data are maybe there, but it takes so long to write a
>> meg file.
>> sometimes
> ..
> 
> This *looks* like maybe the drive reported a sector read error,
> and the standard "fail the whole request one block at a time"
> error mechanism from sd.c has kicked in.

Do you mean something like seek error, i.e. error in hardware, or how to call
this? This is brand new minisd card, it is possible to be waster, but it's
rather something bad in the software (writing by the device itself is perfomed
and data are ok). The error occurs accurately every 8 sectors...

> 
> I have a patch to fix this behaviour (in sd.c), but it has not yet
> been decided whether to go upstream with it or not.

Could you post me a copy, please?

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
