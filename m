Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVLBQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVLBQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLBQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:20:29 -0500
Received: from mail.tmr.com ([64.65.253.246]:16793 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750822AbVLBQU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:20:28 -0500
Message-ID: <43907734.6090207@tmr.com>
Date: Fri, 02 Dec 2005 11:32:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke-Jr <luke-jr@utopios.org>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
References: <200511281218.17141.luke-jr@utopios.org> <438B70AA.7090805@tmr.com> <200511291912.21255.luke-jr@utopios.org>
In-Reply-To: <200511291912.21255.luke-jr@utopios.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> On Monday 28 November 2005 21:03, you wrote:
> 
>>Luke-Jr wrote:
>>
>>>Note: results are with 2.6.13 (-gentoo-r4 + supermount) and 2.6.14
>>>(-gentoo) I've been struggling with burning DVD+R DL discs and upgrading
>>>the firmware on my DVD burner, and just today decided to rmmod ide-cd and
>>>try using ide-scsi. Turns out it works... so is ide-cd *supposed* to
>>>handle cases other than simple reading and burning or is this a bug? If
>>>not a bug, should ide-scsi really be marked as deprecated?
>>>Also, two bugs with ide-scsi:
>>>1. On loading the module, it detects and allocates 6 SCSI devices for a
>>>single DVD burner (Toshiba ODD-DVD SD-R5272); kernel log for this event
>>>attached 2. On attempted unloading of the module, rmmod says 'Killed' and
>>>the module stays put, corrupt. There was some kind of error in dmesg, but
>>>it appears to have avoided syslog-- If I see it again, I'll save it.
>>
>>I think you may have the probe-all-LUNs set, and a CD burner which
>>responds to more than one. That's one possible cause for this.
> 
> 
> Yep, it was set. I'll try turning it off.
> 
> 
>>Unfortunately using ide-cd still doesn't have the code set to allow all
>>burning features to work if you are not root. Even if you have read+write
>>there's one command you need to do multi-session which is only allowed to
>>root. Works fine for single sessions, I guess that's all someone uses.
> 
> 
> I'm pretty sure I tried doing everything as root days before I even considered 
> ide-scsi... In regards to firmware upgrades, I wouldn't expect non-root to be 
> allowed to, even with rw access.

Actually, a single session burn seems to work (I'm doing tests as soon 
as I get a compile of the latest kernel). What doesn't (or didn't) work 
is multisession, even with r/w "cdrecord -msinfo" fails, which is how 
you get the starting info for the next session.
> 
> 
>>Haven't tried unloading the module, so I have no advice on that other than
>>"don't do that." 
> 
> 
> Well, I had reasons... =p
> The first time, I was going to switch back to ide-cd (for DMA), and the second 
> time was because the drive was stuck on Busy and I'm not sure of any (other?) 
> way to reset it without hotplugging the IDE power cable (which I'm sure isn't 
> a good idea and I don't want to risk).

I thought ide-scsi now did DMA, at least for data burns. Don't know 
about audio, I occasionally do an audio burn, but my main machine for 
burning uses ide-cd, so it's not an issue.

I saw a note somewhere about using capabilities on the cdrecord 
executable to allow the realtime sched to be set, but I don't seem to 
find it now. Maybe it was a question rather than an example :-(

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
