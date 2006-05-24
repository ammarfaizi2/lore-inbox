Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWEXXdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWEXXdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWEXXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:33:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20625 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932318AbWEXXde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:33:34 -0400
Message-ID: <4474ED4A.9090703@garzik.org>
Date: Wed, 24 May 2006 19:33:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, robomod@news.nic.it
Subject: Re: Q: how to send ATA cmds to USB drive?
References: <6fXQT-16z-11@gated-at.bofh.it> <4474E92E.8020403@shaw.ca>
In-Reply-To: <4474E92E.8020403@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Herbert Rosmanith wrote:
>> good day,
>>
>> I have a question concerning sending arbitrary ATA commands to an USB
>> drive.
>>
>> Currently, I have a particular application which sends special ATA 
>> commands
>> to an IDE drive using IDE_TASKFILE. So far, this works pretty well.
>>
>> But now I also have to support USB harddisks from the same company.
>> The USB harddisk uses the same set of ATA commands as the IDE harddisk,
>> well, at least that's what I suppose.
>>
>> How do I send ATA commands to this USB drive? I suppose this would be
>> done via SG_IO (the drive is recognised by linux as usb-storage, of
>> course), but how exactly does this have to be done? I have already
>> used SG_IO before to send some MMC commands to cdvd-drives, but I
>> don't know how to send ATA (such as those from T13) commands with this
>> interface.
> 
> Short answer is you likely can't. The USB-to-IDE bridge pretty much 
> entirely hides the fact that it's an IDE drive behind it, from the 
> host's viewpoint it looks pretty much like SCSI. Maybe if you sent SCSI 
> commands to the device it would translate them into the correct ATA 
> commands, depending on what exactly you're doing, but that's entirely 
> dependent on the bridge chip in question and I would guess most of them 
> don't support such fancy operations.

AFAIK most are not really pure bridges, but really microcontrollers 
running a tiny firmware.  So there is a non-zero chance of there being 
an 'ata passthrough' SCSI command.

I would try to the official ATA_12 and ATA_16 SCSI commands first, to 
see if they do something useful.

	Jeff



