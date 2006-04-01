Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWDATOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWDATOG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWDATOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 14:14:06 -0500
Received: from smtpout.mac.com ([17.250.248.47]:25317 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750860AbWDATOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 14:14:04 -0500
In-Reply-To: <442ECE9F.4020206@shaw.ca>
References: <5WD6n-5fR-9@gated-at.bofh.it> <5WD6n-5fR-11@gated-at.bofh.it> <5WD6n-5fR-13@gated-at.bofh.it> <5WD6n-5fR-15@gated-at.bofh.it> <5WD6n-5fR-17@gated-at.bofh.it> <5WD6n-5fR-7@gated-at.bofh.it> <5WEvy-7az-7@gated-at.bofh.it> <442ECE9F.4020206@shaw.ca>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA7D3020-0CEF-49DD-A1F3-7D89E92521EC@mac.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Sat, 1 Apr 2006 14:13:55 -0500
To: Robert Hancock <hancockr@shaw.ca>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 1, 2006, at 14:03:59, Robert Hancock wrote:
> Kyle Moffett wrote:
>>>> hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>>> hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
>>>
>>> Hmm, are these new? Sure you don't have a bad IDE cable?
>> Oh, those aren't the errors I'm worried about; I've had those for  
>> a while and they're harmless.  Those are due to the kernel running  
>> the IDE controller at a higher-than-supported speed.  It gets  
>> errors for a couple seconds and automatically drops the bus down  
>> to a lower and safer speed.
>
> That would be a bug, no? Sounds dangerous to rely on that.

Well, no one else seems concerned by that behavior (and I recall it  
being mentioned previously on this list somewhere).  I've tested it  
fairly extensively; if I turn up the drive speed with hdparm, it gets  
about 4 more CRC errors during data transfer (each badcrc command is  
retried, of course), and then does a bus reset and drops to a lower  
speed again.  I've never had any problems with data corruption on  
this system, and it has been a RAID5 fileserver for several years now.

>>  The cable's aren't bad, I've tried at least 6 different 80- 
>> conductor cables that all work fine in other systems.  The errors  
>> I _am_ worried about are these:
>>> Mar 28 03:15:13 penelope kernel: hdi: status timeout: status=0xd0  
>>> { Busy }
>>> Mar 28 03:15:13 penelope kernel: PDC202XX: Secondary channel reset.
>>> Mar 28 03:15:13 penelope kernel: hdi: no DRQ after issuing  
>>> MULTWRITE_EXT
>>> Mar 28 03:15:13 penelope kernel: ide4: reset: success
>>> Mar 28 03:30:13 penelope kernel: hdi: status timeout: status=0xd0  
>>> { Busy }
>>> Mar 28 03:30:13 penelope kernel: PDC202XX: Secondary channel reset.
>>> Mar 28 03:30:13 penelope kernel: hdi: no DRQ after issuing  
>>> MULTWRITE_EXT
>>> Mar 28 03:30:13 penelope kernel: ide4: reset: success
>
> That sounds fishy to me. If the controller is having trouble  
> communicating with the drive causing BadCRC errors, it could easily  
> cause such errors as the above as well.

Except you seem to have missed the fact that these errors never  
occurred under 2.6.12, and occur regularly on 2.6.15.  Besides, after  
the initial boot-time lowering of the speed, I never get another  
badCRC error from the drive, and I've never had any data corruption.

Cheers,
Kyle Moffett
