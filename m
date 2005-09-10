Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbVIJEyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVIJEyV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 00:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVIJEyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 00:54:21 -0400
Received: from mailrly07.isp.novis.pt ([195.23.133.217]:8655 "EHLO
	mailrly07.isp.novis.pt") by vger.kernel.org with ESMTP
	id S1030444AbVIJEyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 00:54:20 -0400
Message-ID: <43226701.1000606@vgertech.com>
Date: Sat, 10 Sep 2005 05:54:25 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID resync speed
References: <432240E9.9010400@eyal.emu.id.au> <43224ABB.3030002@vgertech.com> <4322506A.1010303@eyal.emu.id.au>
In-Reply-To: <4322506A.1010303@eyal.emu.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote:
> Nuno Silva wrote:
>>Hi,
>>Eyal Lebedinsky wrote:
>>>I noticed that my 3-disk RAID was syncing at about 40MB/s, now that I
>>>added a fourth disk it goes at only 20+MB/s. This is on an idle machine.
>>3*40=120
>>4*20=80
> What does this mean? The raid is syncing at 20MB/s, not each disk, so I do
> not see what the multiplication is about.


Yes, you're correct :-)


>>>Individually, each disk measures 60+MB/s with hdparm.
>>And concurrent hdparms? Or some dd's concurrently?
> 
> I do not see this as relevant, but four concurrent hdparms (each to a
> different disk) give about 30MB/s per disk. I expect the controller
> to talk to the four disks at their full speed so concurrency should
> not be the issue.


I guess you're using linux's software raid?
If so, you're hitting the 120MB/sec (and I *think* this time I'm 
correct! :-)

If this is a PCI32/33mhz slot you're not going to be able to get more 
juice. (I bet that 3 concurrent dd's gets you 40MB each).

Anyway, this may be offtopic because the problem (only 20MB/sec for the 
raid with 4 disks) should be something else... Sorry for the noise.

>>>kernel: 2.6.13 on ia32
>>>Controller: Promise SATAII150 TX4
>>>Disks: WD 320GB SATA
>>>
>>>Q: Is this the way the raid code works? The way the disk-io is
>>>managed? Or
>>>could it be due to the SATA controller?
>>
>>You can isolate the performance drop with some dd's. Maybe this card is
>>in a pci32/33mhz and you're hitting the pci bus' limits? (120~130MB/sec).
> 
> 
> 'hdparm -T' gives about 1250 MB/sec so this is not the limiting
> factor.


Mine outputs some fabulous values too... I'm not sure I trust them ;)

# hdparm -T /dev/sda

/dev/sda:
  Timing cached reads:   3536 MB in  2.00 seconds = 1767.38 MB/sec

Regards,
Nuno Silva
