Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267218AbUHIU1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUHIU1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUHIUYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:24:31 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44202 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267218AbUHIUV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:21:29 -0400
Message-ID: <4117DD8F.3050707@tmr.com>
Date: Mon, 09 Aug 2004 16:24:47 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Jens Axboe <axboe@suse.de>
CC: Zinx Verituse <zinx@epicsol.org>, linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
References: <20040731182741.GA21845@bliss><20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de>
In-Reply-To: <20040731200036.GM23697@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Jul 31 2004, Zinx Verituse wrote:
> 
>>On Sat, Jul 31, 2004 at 05:36:10PM +0200, Jens Axboe wrote:
>>
>>>On Fri, Jul 30 2004, Zinx Verituse wrote:
>>>
>>>>I'm going to bump this topic a bit, since it's been a while..
>>>>There are still some issues with ide-cd's SG_IO, listed from
>>>>most important as percieved by me to least:
>>>>
>>>> * Read-only access grants you the ability to write/blank media in the drive
>>>> * (with above) You can open the device only in read-only mode.
>>>
>>>That's by design. Search linux-scsi or this list for why that is so.
>>
>>The only thing I can find on the linux-scsi list is refering to sg
>>devices, which are on a different device node from the non-generic
>>device.  This means you can still allow users read access to the disk
>>without allowing them to send random commands to the disk -- this isn't
>>currently possible with the IDE interface, since the device with
>>generic access is the same as the one with the original read/cdrom
>>commands access.
>>
>>As it is, it's impossible grant users read-only access to an IDE cd-rom
>>without allowing them to do things like replacing the firmware with a
>>malicious/non-working one.
>>
>>Generic access allowing such things is fine; but only if we can grant
>>non-generic access without granting generic access.
> 
> 
> If you want it to work that way, you have the have a pass-through filter
> in the kernel knowing what commands are out there (including vendor
> specific ones). That's just too ugly and not really doable or
> maintainable, sorry.
> 
> If you have access to issue ioctls to the device, you have access to
> send it arbitrary commands - period.
> 
Let me try this again... To do the normal "reasonable" things associated 
with raw read, the standard SCSI command set includes commands in the 
read and seek sets which seem to be what is needed. These are standard, 
and I fail to see how allowing them, and only them, could be so 
complicated in the case where only read access is allowed. There is no 
need to allow vendor commands or any kind to permit programs such as 
checks and backups of various kinds to be used.

I think the same is true of write, filtering out anything but the set of 
write commands in the common SCSI command set is fine, and in the rare 
case where it isn't, I'm happy to say that raw write capability is the 
answer.

   read does not imply write
   write does not imply anything but data

firmware reload, low level format, spin in the other direction, all 
would require capability.

If you disagree with the above in some technical way, please clarify. If 
you just are opposing filtration on general principles because you run 
everything as root or don't believe in levels of security, I sure can't 
change your mind if you're willing to disagree with Alan.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
