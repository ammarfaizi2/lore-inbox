Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDTILQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDTILQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDTILQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:11:16 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:43499
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1750715AbWDTILO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:11:14 -0400
Message-ID: <001e01c66451$f9a470f0$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Jens Axboe" <axboe@suse.de>
Cc: <dax@gurulabs.com>, <billion.wu@areca.com.tw>,
       "\"Al Viro\"" <viro@ftp.linux.org.uk>,
       "\"Andrew Morton\"" <akpm@osdl.org>,
       "\"Randy.Dunlap\"" <rdunlap@xenotime.net>,
       "\"Matti Aarnio\"" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>,
       "\"James Bottomley\"" <James.Bottomley@steeleye.com>,
       "\"Chris Caputo\"" <ccaputo@alt.net>
References: <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de> <002901c65e33$ceac9e00$b100a8c0@erich2003> <20060419104009.GB614@suse.de> <003301c663b3$6bfcc020$b100a8c0@erich2003> <20060419131916.GH614@suse.de> <001401c6641d$586bd950$b100a8c0@erich2003> <20060420064249.GO614@suse.de>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Date: Thu, 20 Apr 2006 16:11:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-OriginalArrivalTime: 20 Apr 2006 08:05:53.0312 (UTC) FILETIME=[3EAA6200:01C66451]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dear Jens Axboe,

Thanks for your notification and advice.
Areca's firmware has max sg entries of 38 limit.
In my debug driver I had add this condition check.
But no one request more than 38 sg.
Both transfer length all have a lot of requests equal with 38 sg.
But why it ocur only at 4096 sectors?
If the /sys/block/sda/queue/max_sectors_kb equal 256 all operation running 
well.
But if I modify it more than 256, the bug appeared.
I  will do more research about why there were a lot of requests equal with 
38 sg in all file system.
And only it ocur at the volume that format with mkfs.ext2.
Thanks again.

Best Regards
Erich Chen

----- Original Message ----- 
From: "Jens Axboe" <axboe@suse.de>
To: "erich" <erich@areca.com.tw>
Cc: <dax@gurulabs.com>; <billion.wu@areca.com.tw>; "Al Viro" 
<viro@ftp.linux.org.uk>; "Andrew Morton" <akpm@osdl.org>; "Randy.Dunlap" 
<rdunlap@xenotime.net>; "Matti Aarnio" <matti.aarnio@zmailer.org>; 
<linux-kernel@vger.kernel.org>; "James Bottomley" 
<James.Bottomley@steeleye.com>; "Chris Caputo" <ccaputo@alt.net>
Sent: Thursday, April 20, 2006 2:42 PM
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken


> On Thu, Apr 20 2006, erich wrote:
>> Dear Jens Axboe,
>>
>> I  do "fsck -fy /dev/sda1" on driver MAX_XFER_SECTORS 512.
>> The file system was not clean.
>> I attach mesg.txt for you refer to.
>>
>> =====================================
>> == boot with driver MAX_XFER_SECTORS 4096
>> =====================================
>> #mkfs.ext2 /dev/sda1
>> #reboot
>> =====================================
>> == boot with driver MAX_XFER_SECTORS 512
>> =====================================
>> #fsck -fy /dev/sda1
>> /dev/sda1:clean,.............
>> #reboot
>> =====================================
>> == boot with driver MAX_XFER_SECTORS 4096
>> =====================================
>> #mount /dev/sda1 /mnt/sda1
>> #cp /root/aa /mnt/sda1
>> #reboot
>> =====================================
>> == boot with driver MAX_XFER_SECTORS 512
>> =====================================
>> #fsck -fy /dev/sda1
>> /dev/sda1: no clean,........and dump message such as the attach file
>> mesg.txt.
>
> So the conclusion is that your driver and/or hardware corrupts data when
> you set MAX_XFER_SECTORS too high. I can't help you anymore with this,
> you should be in the best position to debug the driver and/or hardware
> :-)
>
> It could be that the higher setting just exposes another transfer
> setting bug, like maximum number of segments or segment size, etc.
>
> -- 
> Jens Axboe
> 

