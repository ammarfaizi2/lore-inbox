Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVBJEXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVBJEXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVBJEXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:23:15 -0500
Received: from smtpauth06.mail.atl.earthlink.net ([209.86.89.66]:715 "EHLO
	smtpauth06.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262016AbVBJEXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:23:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple;
  s=test1; d=earthlink.net;
  h=Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HnfLxIfSOdH31CcGnDnyK9/tnQy44wUc0FLjxLBODNA7SGRc806s1I1qVZTBkP+D;
Message-ID: <420AE1CE.2070306@earthlink.net>
Date: Wed, 09 Feb 2005 23:23:42 -0500
From: Todd Shetter <tshetter-lkml@earthlink.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.4.x kernel BUG at filemap.c:81
References: <42099C57.9030306@earthlink.net> <20050209121011.GA13614@logos.cnet> <420A3A8D.9030705@earthlink.net> <20050209130319.GA13986@logos.cnet> <420A76E0.2030604@earthlink.net> <20050209174232.GC15888@logos.cnet>
In-Reply-To: <20050209174232.GC15888@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: 20b3e7689bd2545e1aa676d7e74259b7b3291a7d08dfec790ba751edd9dd6c91c860bc811dd36b0a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.144.117.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Wed, Feb 09, 2005 at 03:47:28PM -0500, Todd Shetter wrote:
>
>  
>
>>>>>>Running slackware 10 and 10.1, with kernels 2.4.26, 2.4.27, 2.4.28, 
>>>>>>2.4.29 with highmem 4GB, and highmem i/o support enabled, I get a 
>>>>>>system lockup. This happens in both X and console. Happens with and 
>>>>>>without my Nvidia drivers loaded. I cannot determine what makes this 
>>>>>>bug present it self besides highmem and high i/o support enabled. Im 
>>>>>>guessing the system is fine until highmem is actually used to some 
>>>>>>point and then it borks, but I really have no idea and so im just 
>>>>>>making a random guess. I ran memtest86 for a few hours a while ago 
>>>>>>thinking that it may be bad memory, but that did not seem to be the 
>>>>>>problem.
>>>>>>
>>>>>>If you need anymore information, or have questions, or wish me to test 
>>>>>>anything, PLEASE feel free to contact me, I would really like to see 
>>>>>>this bug resolved. =)
>>>>>>
>>>>>>--
>>>>>>Todd Shetter
>>>>>>
>>>>>>
>>>>>>Feb  8 19:49:31 quark kernel: kernel BUG at filemap.c:81!
>>>>>>Feb  8 19:49:31 quark kernel: invalid operand: 0000
>>>>>>Feb  8 19:49:31 quark kernel: CPU:    0
>>>>>>Feb  8 19:49:31 quark kernel: EIP:    0010:[<c01280d1>]    Tainted: P
>>>>>>
>>>>>>
>>>>>>      
>>>>>>
>>>>>>            
>>>>>>
>>>>>Hi Todd, 
>>>>>
>>>>>Why is your kernel tainted ?
>>>>>
>>>>>          
>>>>>
>>>>I had the nvidia 1.0-6629 driver loaded when I got that error. I 
>>>>compiled the kernel using the slackware 10.1 config, enabled highmem 4GB 
>>>>support, highmem i/o, and then some kernel hacking options including 
>>>>debugging for highmen related things.
>>>>
>>>>I booted, loaded X with KDE, opened firefox a few times, and then 
>>>>started running hdparm because some newer 2.4.x kernels dont play nice 
>>>>with my SATA, ICH5, and DMA. hdparm segfaulted while running the drive 
>>>>read access portion of its tests, and things locked up from there in 
>>>>about 30secs.
>>>>
>>>>I've gotten the same error with the nvidia driver not loaded, so I dont 
>>>>think that is part of the problem.
>>>>
>>>>As I said, if you want me to test or try anything feel free to ask.  =)
>>>>  
>>>>        
>>>>
>>>Todd,
>>>
>>>Would be interesting to have the oops output without the kernel nvidia 
>>>module. 
>>>Do you have that saved?
>>>
>>>
>>>
>>>      
>>>
>>Sorry, it took me FOREVER to get this bug to appear again, and this time 
>>its a little different.
>>    
>>
>
>Hum, both BUGs are due to a page with alive ->buffers mapping.
>
>Did it crashed right after hdparm now too? 
>
>Can you boot your box without SATA drivers, configuring the interface to IDE 
>mode ?
>
>Which problems are you facing with newer v2.4.x kernels and SATA? 
>  
>

Im waiting for the system to crash, so I figured I might as well get on 
with the SATA problems....

Running 2.4.29 neither the CONFIG_BLK_DEV_IDE_SATA nor the 
CONFIG_SCSI_SATA are set currently and DMA is not enabled on either of 
my drives,  hda: ST380013AS,  hdb: WDC WD2500SD-01KCB0,  hdc: Maxtor 
94610U6. Setting DMA manually on the hard drives yields a HDIO_SET_DMA 
failed: Operation not permitted error.

Using 2.4.26, DMA worked fine on the drives. Under 2.4.27, 2.4.28, and 
2.4.29 using CONFIG_SCSI_SATA does not allow setting of DMA on the 
drives, yielding a HDIO_SET_DMA failed: Operation not permitted error, 
and the transfer speeds reported by hdparm are at about 3MB/s.

Under 2.4.29 using CONFIG_BLK_DEV_IDE_SATA the DMA is set fine upon 
boot, and I get good transfers, hdparm reports 58MB/s on my Western 
Digital drive. I have not tested using CONFIG_BLK_DEV_IDE_SATA on any 
previous kernel versions.

Well, still no crash yet....Again, anything else you want me to try or 
do just let me know.

--
Todd Shetter

