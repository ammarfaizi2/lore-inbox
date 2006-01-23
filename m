Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWAWMb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWAWMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAWMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:31:28 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:61380 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751095AbWAWMb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:31:26 -0500
Message-ID: <43D4CC9C.9060500@dgreaves.com>
Date: Mon, 23 Jan 2006 12:31:24 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Mitchell Laks <mlaks@verizon.net>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, IDE Linux <linux-ide@vger.kernel.org>
Subject: Possible libata/sata/Asus problem (was Re: Need to upgrade to latest
 stable mdadm version?)
References: <Pine.LNX.4.44.0601221719020.24057-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0601221719020.24057-100000@coffee.psychology.mcmaster.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>>>and with the ETCH testing 2.6.12:  the sata_via module fails with
>>>      
>>>
>I'm sure you know that no kernel developer really cares about distro-hacked 
>kernels.  why not test a real (kernel.org) kernel?
>  
>
Only because if the problem exists on the stock kernel and not on the
distro kernel then there could be assistance in determining which patch
solves (or hides!) the problem. This may or may not actually be helpful.


>>>ata1: status=0x51 { DriveReady SeekComplete Error }
>>>ata1: error=0x84 { DriveStatusError BadCRC }
>>>      
>>>
>badcrc's are a sign that the link is failing - bad cable, bad power,
>overclocking,
>
OK

>possibly an error in the driver's timing config.
>  
>
A-ha!

>it cannot possibly be an mdadm problem, and cannot be related to 
>other software (kernel memory management, say.)
>  
>
Agreed.

> I don't see how driver interaction could cause the BadCRC, unless one
> driver
>
>is screwing with the timing registers of the other's hardware.
>  
>
And maybe, on a lightly loaded system, RAID causes concurrent access
(and potentially triggers problems) more often than a non-RAID solution?

> mdadm cannot possibly have anything to do with causing BadCRC's.
> upgrade if
>
>you feel like it, but not because of this problem.
>  
>
Completely agree.

>>I am running the *stock* 2.6.15 and get the same problems (ata timeouts etc)
>>    
>>
>is there a reason you call this a timeout, rather than a BadCRC?
>  
>
I had:
  ata2: command 0x25 timeout, stat 0x51 host_stat 0x0

It stuck in my head. It's not that representative. My bad.

most errors (for me) were:

Jan 19 15:23:05 haze kernel: ata1: PIO error
Jan 19 15:23:05 haze kernel: ata1: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:05 haze kernel: ata1: PIO error
Jan 19 15:23:05 haze kernel: ata1: status=0x50 { DriveReady SeekComplete }
Jan 19 15:23:05 haze kernel: ata1: PIO error


But if you look at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113769509617034&w=2

you'll see that I had what looked like a 'spurious' bad-block error -
and I have an Asus motherboard, am using the via_sata driver, have
another sata driver loaded and am using md - all under 2.6.15 .... hence
the tentative association of the problems :)

Oh, and libata's error handling is embryonic - maybe it should be
retrying. I dunno.

I've seen other potentially related problems in the
sata/motherboard/raid area.
Personally I suspect buggy Asus motherboards.
I wonder if the bug is triggered by multiple drivers or some concurrency
- hence raid's involvment...
(Since I suspect md is actually tickling it, not causing it moving to
lkml and linux-ide too)

Of course I plan to do some tests - but mentioning it may give others
ideas too... And maybe I/we'll get suggestions as to what to try next...

David

-- 

