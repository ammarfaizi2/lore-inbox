Return-Path: <linux-kernel-owner+w=401wt.eu-S1751947AbXAVQYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXAVQYU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbXAVQYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:24:20 -0500
Received: from bay0-omc3-s23.bay0.hotmail.com ([65.54.246.223]:54065 "EHLO
	bay0-omc3-s23.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751947AbXAVQYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:24:19 -0500
X-Greylist: delayed 804 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 11:24:19 EST
Message-ID: <BAY125-DAV14DB3B267D410F37358DFA93AE0@phx.gbl>
X-Originating-IP: [143.182.124.1]
X-Originating-Email: [multisyncfe991@hotmail.com]
From: "Liang Yang" <multisyncfe991@hotmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>, "kyle" <kylewong@southa.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f> <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan>
Subject: Re: change strip_cache_size freeze the whole raid
Date: Mon, 22 Jan 2007 09:10:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 22 Jan 2007 16:10:54.0860 (UTC) FILETIME=[E4F6F4C0:01C73E3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we need to consider the chunk size when we adjust the value of 
Striped_Cache_Szie for the MD-RAID5 array?

Liang

----- Original Message ----- 
From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
To: "kyle" <kylewong@southa.com>
Cc: <linux-raid@vger.kernel.org>; <linux-kernel@vger.kernel.org>
Sent: Monday, January 22, 2007 5:18 AM
Subject: Re: change strip_cache_size freeze the whole raid


>
>
> On Mon, 22 Jan 2007, kyle wrote:
>
>> Hi,
>>
>> Yesterday I tried to increase the value of strip_cache_size to see if I 
>> can
>> get better performance or not. I increase the value from 2048 to 
>> something
>> like 16384. After I did that, the raid5 freeze. Any proccess read / write 
>> to
>> it stucked at D state. I tried to change it back to 2048, read
>> strip_cache_active, cat /proc/mdstat, mdadm stop, etc. All didn't return 
>> back.
>> I even cannot shutdown the machine. Finally I need to press the reset 
>> button
>> in order to get back my control.
>>
>> Kernel is 2.6.17.8 x86-64, running at AMD Athlon3000+, 2GB Ram, 8 x 
>> Seagate
>> 8200.10 250GB HDD, nvidia chipset.
>>
>> cat /proc/mdstat (after reboot):
>> Personalities : [raid1] [raid5] [raid4]
>> md1 : active raid1 hdc2[1] hda2[0]
>>      6144768 blocks [2/2] [UU]
>>
>> md2 : active raid5 sdf1[7] sde1[6] sdd1[5] sdc1[4] sdb1[3] sda1[2] 
>> hdc4[1]
>> hda4[0]
>>      1664893440 blocks level 5, 512k chunk, algorithm 2 [8/8] [UUUUUUUU]
>>
>> md0 : active raid1 hdc1[1] hda1[0]
>>      104320 blocks [2/2] [UU]
>>
>> Kyle
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Yes, I noticed this bug too, if you change it too many times or change it
> at the 'wrong' time, it hangs up when you echo numbr >
> /proc/stripe_cache_size.
>
> Basically don't run it more than once and don't run it at the 'wrong' time
> and it works.  Not sure where the bug lies, but yeah I've seen that on 3
> different machines!
>
> Justin.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

