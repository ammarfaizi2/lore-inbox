Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbUABIQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUABIQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 03:16:42 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:51468 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265435AbUABIQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 03:16:39 -0500
Message-ID: <3FF5297E.6060802@nishanet.com>
Date: Fri, 02 Jan 2004 03:19:10 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla Thunderbird 0.5a (20040102)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE-RAID Drive Performance
References: <S265736AbTL3KoB/20031230104401Z+18387@vger.kernel.org> <20031230122119.1566247a@Genbox>
In-Reply-To: <20031230122119.1566247a@Genbox>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Alexandre wrote:

>On Tue, 30 Dec 2003 11:44:01 +0100 
>Mr(s): Nicklas Bondesson wrote:
>
>  
>
>>Hi!
>>
>>I think i'm getting really bad values from my disks. It's two Western
>>Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected to a
>>Promise TX2000 (PDC20271) card (RAID1 using ataraid under Linux 2.4.23).
>>
>>The disks are setup with hdparm at boot time:
>>
>>/sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda 
>>/sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hdc
>>
>>When running hdparm -tT I get the following:
>>
>>/dev/hda:
>> Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>> Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec
>>
>>/dev/hdc:
>> Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>> Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec
>>
>>Are these normal values? I don't think so. Please advise.
>>
>>/Nicke
>>    
>>
>
>Hi.
>This is what i get with a Maxtor 6Y120L0 (2MB cache):
>
>/dev/hda:
> Timing buffer-cache reads:   1320 MB in  2.00 seconds = 659.44 MB/sec
> Timing buffered disk reads:  140 MB in  3.02 seconds =  46.40 MB/sec
>
>Using:
>-d1 -u1 -m16 -c3 -W1 -A1 -k1 -X70 -a 8192
>
>I'm not using raid, its a single disk connected to IDE1 on the motherboard.
>
>Maybe you can try those parameters and see if it helps :)
>  
>
I have two promise cards and four Maxtor
DiamondMax Plus9 60G with 8MB cache each
hdparm -d1 -u1 -m16 -c1 -W1 -A1 -k1 -X70 -a 8192

and my raid0 is software, linux, not the promise chip's raid

on each drive I see 900 MB/s 47.2 MB/s
and on /dev/md/2 /tmp with four drives
four partitions I see 900 MB/s 94 MB/s

that's with 64k raid chunk, reiser 4096b blocks

Linux says 2048k raid chunk would minimize
seek time for better real world performance. It
doesn't work better with hdparm -tT but that's not
realworld. My version of reiserfs doesn't allow
changing the block size.

-Bob D
