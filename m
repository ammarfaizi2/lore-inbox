Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWFGNPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWFGNPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWFGNPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 09:15:04 -0400
Received: from rtr.ca ([64.26.128.89]:35294 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750813AbWFGNPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 09:15:03 -0400
Message-ID: <4486D14F.50607@rtr.ca>
Date: Wed, 07 Jun 2006 09:14:55 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net, usb-storage@lists.one-eyed-alien.net
Subject: Re: usb device problem
References: <44859A9B.6080202@gmail.com> <4485A299.7070007@rtr.ca> <4485A855.1020602@gmail.com> <4485C446.2040203@rtr.ca> <4485C5D8.5070907@rtr.ca> <4485F590.8000304@gmail.com> <44860586.5080308@gmail.com>
In-Reply-To: <44860586.5080308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Jiri Slaby napsal(a):
>> Mark Lord napsal(a):
>>> Mmm.. okay, a quick glance at the USB storage code revealed one instance:
>>>
>>>        /* Did we transfer less than the minimum amount required? */
>>>        if (srb->result == SAM_STAT_GOOD &&
>>>                        srb->request_bufflen - srb->resid < srb->underflow)
>>>                srb->result = (DID_ERROR << 16) | (SUGGEST_RETRY << 24);
>>>
>>>        return;
>>>
>>> So I suppose this *could* be the driver thinking it had a bad sector,
>>> but it really looks like it's guessing.  The code also appears to be
>>> instrumented for some kind of USB tracing.. If you can figure out how
>>> to turn that on, then the trace will probably tell us what is really
>>> going on there.
>>> Look for a file called "usbmon.txt" in the Documentation/usb/ subdir
>>> of your kernel source tree.  It describes how to do the tracing.
>> Did you want me to do something like this:
>> http://www.fi.muni.cz/~xslaby/sklad/usbmon/?M=A
>>
>> usb2 means usb bus 2.
>>
>> without "a"s commands was:
>>
>> [connect the device]
>> mount /dev/sdb usb/ [filesystem is vfat]
>> dd if=/dev/zero of=usb/zero1 bs=1k count=3
>> [wait some time to let system syncing automagically]
>> umount usb/
>> [disconnect the device]
>>
>>
>>
>> with "a" there is only difference in dd command:
>> ...
>> dd if=/dev/zero of=usb/zero2 bs=1k count=5
>> ...
>>
>> The first serie is without the error in the latter one appeared (some time after
>> `dd', when system syncs):
>> sd 6:0:0:0: SCSI error: return code = 0x10070000
>> end_request: I/O error, dev sdb, sector 8223
>> [same as before]
>>
>>
>>
>> I have i386 arch, so 4096 is PAGE_SIZE, when it syncs only one dirty page, it
>> seems to be OK, otherwise it's not, if this helps in any way.
>>
> 
> Just a notice, I've just returned from the big w*ows system and it's working
> there ... huh ... better to say, it doesn't complain ... hum ... it means almost
> nothing ... But seems to work.

I think it's time for you to try the USB Storage maintainer(s).

I've CC'd their mailing list on this note, but you should probably
repost the earlier descriptions to their lists.

Cheers


