Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWBNDgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWBNDgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWBNDgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:36:13 -0500
Received: from rtr.ca ([64.26.128.89]:3779 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030299AbWBNDgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:36:12 -0500
Message-ID: <43F15027.2090304@rtr.ca>
Date: Mon, 13 Feb 2006 22:36:07 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       smartmontools-support@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: default hdparms? readahead=256? Re: WD 400GB xATA Drives
References: <Pine.LNX.4.64.0602130524350.13160@p34> <43F1393D.9050801@tlinx.org>
In-Reply-To: <43F1393D.9050801@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
>..
> set to known values may not contain "great values".  My "readahead"
> value seems to boot with a value of "256" for all of my drives.
> 
> Is this not a bit "excessive"?

Wow.. that does look a bit HUGE.  Thanks for pointing it out,
I'm resetting mine back to 128 for now.

> Justin Piszcz wrote:
>> When I write to this disk for a while, I see this in dmesg (only once 
>> so far):
>>
>> [31230.223504] ata6: translated ATA stat/err 0x51/04 to SCSI 
>> SK/ASC/ASCQ 0xb/00/00
>> [31230.223511] ata6: status=0x51 { DriveReady SeekComplete Error }
>> [31230.223515] ata6: error=0x04 { DriveStatusError }
>>
>> Is there some sort of smart testing going on constantly?  I only get 
>> 26-27MB/s on this 400GB/SATA/16MB/7200RPM drive.  I use smartmontools 
>> to do a daily test.  However, even with smart disabled, I get:
>>
>> # hdparm -t /dev/sde
>> /dev/sde:
>>  Timing buffered disk reads:   78 MB in  3.06 seconds =  25.46 MB/sec
>>
>> Does anyone know if this drive has problems in Linux or something?
>>
>> [    6.895914]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
...

Some drives suck at sequential reads, in favour of doing random seeks
very very well.  Basically, the on-drive seek algorithm may not favour
doing much read-ahead.  Try "hdparm -A1" and see if that helps.
