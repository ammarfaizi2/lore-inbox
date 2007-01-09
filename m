Return-Path: <linux-kernel-owner+w=401wt.eu-S932494AbXAIW7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbXAIW7F (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAIW7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:59:04 -0500
Received: from mail.icabo.tv.br ([200.220.202.3]:58714 "EHLO mail.icabo.tv.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494AbXAIW7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:59:01 -0500
Message-ID: <45A41E0E.9050608@fliagreco.com.ar>
Date: Tue, 09 Jan 2007 19:58:22 -0300
From: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
User-Agent: Thunderbird 3.0a1 (Windows/20070109)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar> <459B9F91.9070908@gmail.com> <459BC703.9000207@fliagreco.com.ar> <459C8A5E.5010206@gmail.com> <459CFE7B.6090306@fliagreco.com.ar> <459DC2EE.1090307@fliagreco.com.ar> <45A1AB3F.1080408@gmail.com> <45A2376D.5060905@fliagreco.com.ar>
In-Reply-To: <45A2376D.5060905@fliagreco.com.ar>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ICABO-MailScanner-Information: Please contact the ISP for more information
X-ICABO-MailScanner: Sem Virus encontrado
X-MailScanner-From: lkml@fliagreco.com.ar
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Sebastian Greco wrote:
> Tejun Heo wrote:
>> Pablo Sebastian Greco wrote:
>>  
>>> After an uptime of  13:34 under heavy load and no errors, I'm pretty
>>> sure your patch is correct. Is there a way to backport this to 
>>> 2.6.18.x?
>>>     
>>
>> I forgot this (even though I implemented it) but you can turn off NCQ by
>> doing the following.
>>
>> # echo 1 > /sys/block/sdX/device/queue_depth
>>
>> Can you put the seagate drive under load to verify that it's the samsung
>> drive's problem not the controller's?
>>
>>  
>>> Just an off topic question, does anyone know why I get so uneven IRQ
>>> handling on 2.6.19-20 and almost perfect on 2.6.20-rc2-mm1?
>>>     
>>
>> I dunno.  You have much better chance of getting a useful answer by
>> asking it on a separate thread with proper subject line.  People usualyl
>> screen threads by subject.  There are just too many message in LKML for
>> anyone to follow all the message.
>>
>> Thanks.
>>
>>   
> Guess I spoke too soon :(
> Today I found this
> Jan  8 04:01:40 squid kernel: ata2.00: exception Emask 0x0 SAct 0x0 
> SErr 0x0 action 0x2 frozen
> Jan  8 04:01:40 squid kernel: ata2.00: cmd 
> 25/00:08:49:ee:e8/00:00:16:00:00/e0 tag 0 cdb 0x0 data 4096 in
> Jan  8 04:01:40 squid kernel:          res 
> 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Jan  8 04:01:40 squid kernel: ata2: soft resetting port
> Jan  8 04:01:40 squid kernel: ata2: softreset failed (port busy but 
> CLO unavailable)
> Jan  8 04:01:40 squid kernel: ata2: softreset failed, retrying in 5 secs
> Jan  8 04:01:45 squid kernel: ata2: hard resetting port
> Jan  8 04:01:53 squid kernel: ata2: port is slow to respond, please be 
> patient (Status 0x80)
> Jan  8 04:02:16 squid kernel: ata2: port failed to respond (30 secs, 
> Status 0x80)
> Jan  8 04:02:16 squid kernel: ata2: COMRESET failed (device not ready)
> Jan  8 04:02:16 squid kernel: ata2: hardreset failed, retrying in 5 secs
> Jan  8 04:02:21 squid kernel: ata2: hard resetting port
> Jan  8 04:02:21 squid kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Jan  8 04:02:21 squid kernel: ata2.00: configured for UDMA/133
> Jan  8 04:02:21 squid kernel: ata2: EH complete
> Jan  8 04:02:21 squid kernel: SCSI device sdb: 488397168 512-byte hdwr 
> sectors (250059 MB)
> Jan  8 04:02:21 squid kernel: sdb: Write Protect is off
> Jan  8 04:02:21 squid kernel: SCSI device sdb: write cache: enabled, 
> read cache: enabled, doesn't support DPO or FUA
> #uptime
> 10:10:12 up 3 days, 22:48,  1 user,  load average: 0.22, 0.19, 0.18
> 4 am is the lowest load ever, so I don't get it.
> I've found two differences with older errors
>    SAct is now 0x0 when before was 0x7fffffff
>    And the cmd/res used to be really long, now it's just one command
> About heavy loading the seagate, I've tested as suggested on other 
> thread dd if=<drive> of=/dev/null
> for all 4 drives simultaneously, on top of usual load, and all was 
> perfect with current kernel (2.6.20-rc3 + blacklist).
> Don't know what to do to help
>
> Thanks.
> Pablo.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
And now this :( , still  running rc3+blacklist without rebooting

Jan  9 05:30:36 squid kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Jan  9 05:30:36 squid kernel: ata2.00: cmd 
c8/00:08:87:83:85/00:00:00:00:00/e2 tag 0 cdb 0x0 data 4096 in
Jan  9 05:30:36 squid kernel:          res 
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  9 05:30:36 squid kernel: ata2: soft resetting port
Jan  9 05:30:36 squid kernel: ata2: softreset failed (port busy but CLO 
unavailable)
Jan  9 05:30:36 squid kernel: ata2: softreset failed, retrying in 5 secs
Jan  9 05:30:41 squid kernel: ata2: hard resetting port
Jan  9 05:30:49 squid kernel: ata2: port is slow to respond, please be 
patient (Status 0x80)
Jan  9 05:31:12 squid kernel: ata2: port failed to respond (30 secs, 
Status 0x80)
Jan  9 05:31:12 squid kernel: ata2: COMRESET failed (device not ready)
Jan  9 05:31:12 squid kernel: ata2: hardreset failed, retrying in 5 secs
Jan  9 05:31:17 squid kernel: ata2: hard resetting port
Jan  9 05:31:17 squid kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Jan  9 05:31:17 squid kernel: ata2.00: configured for UDMA/133
Jan  9 05:31:17 squid kernel: ata2: EH complete
Jan  9 05:31:17 squid kernel: SCSI device sdb: 488397168 512-byte hdwr 
sectors (250059 MB)
Jan  9 05:31:17 squid kernel: sdb: Write Protect is off
Jan  9 05:31:17 squid kernel: SCSI device sdb: write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jan  9 05:32:17 squid kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Jan  9 05:32:17 squid kernel: ata2.00: cmd 
c8/00:08:37:ac:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
Jan  9 05:32:17 squid kernel:          res 
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  9 05:32:18 squid kernel: ata2: soft resetting port
Jan  9 05:32:18 squid kernel: ata2: softreset failed (port busy but CLO 
unavailable)
Jan  9 05:32:18 squid kernel: ata2: softreset failed, retrying in 5 secs
Jan  9 05:32:23 squid kernel: ata2: hard resetting port
Jan  9 05:32:30 squid kernel: ata2: port is slow to respond, please be 
patient (Status 0x80)
Jan  9 05:32:53 squid kernel: ata2: port failed to respond (30 secs, 
Status 0x80)
Jan  9 05:32:53 squid kernel: ata2: COMRESET failed (device not ready)
Jan  9 05:32:53 squid kernel: ata2: hardreset failed, retrying in 5 secs
Jan  9 05:32:58 squid kernel: ata2: hard resetting port
Jan  9 05:32:58 squid kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Jan  9 05:32:58 squid kernel: ata2.00: configured for UDMA/133
Jan  9 05:32:58 squid kernel: ata2: EH complete
Jan  9 05:33:58 squid kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Jan  9 05:33:58 squid kernel: ata2.00: cmd 
c8/00:08:37:ac:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
Jan  9 05:33:58 squid kernel:          res 
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  9 05:33:59 squid kernel: ata2: soft resetting port
Jan  9 05:33:59 squid kernel: ata2: softreset failed (port busy but CLO 
unavailable)
Jan  9 05:33:59 squid kernel: ata2: softreset failed, retrying in 5 secs
Jan  9 05:34:04 squid kernel: ata2: hard resetting port
Jan  9 05:34:11 squid kernel: ata2: port is slow to respond, please be 
patient (Status 0x80)
Jan  9 05:34:34 squid kernel: ata2: port failed to respond (30 secs, 
Status 0x80)
Jan  9 05:34:34 squid kernel: ata2: COMRESET failed (device not ready)
Jan  9 05:34:34 squid kernel: ata2: hardreset failed, retrying in 5 secs
Jan  9 05:34:39 squid kernel: ata2: hard resetting port
Jan  9 05:34:39 squid kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Jan  9 05:34:39 squid kernel: ata2.00: configured for UDMA/133
Jan  9 05:34:39 squid kernel: ata2: EH complete
Jan  9 05:34:39 squid kernel: SCSI device sdb: 488397168 512-byte hdwr 
sectors (250059 MB)
Jan  9 05:34:39 squid kernel: sdb: Write Protect is off
Jan  9 05:34:39 squid kernel: SCSI device sdb: write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jan  9 05:34:39 squid kernel: SCSI device sdb: 488397168 512-byte hdwr 
sectors (250059 MB)
Jan  9 05:34:39 squid kernel: sdb: Write Protect is off
Jan  9 05:34:39 squid kernel: SCSI device sdb: write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jan  9 05:42:21 squid kernel: ata2.00: limiting speed to UDMA/100
Jan  9 05:42:21 squid kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Jan  9 05:42:21 squid kernel: ata2.00: cmd 
c8/00:08:cf:63:8b/00:00:00:00:00/ee tag 0 cdb 0x0 data 4096 in
Jan  9 05:42:21 squid kernel:          res 
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  9 05:42:22 squid kernel: ata2: soft resetting port
Jan  9 05:42:22 squid kernel: ata2: softreset failed (port busy but CLO 
unavailable)
Jan  9 05:42:22 squid kernel: ata2: softreset failed, retrying in 5 secs
Jan  9 05:42:27 squid kernel: ata2: hard resetting port
Jan  9 05:42:34 squid kernel: ata2: port is slow to respond, please be 
patient (Status 0x80)
Jan  9 05:42:57 squid kernel: ata2: port failed to respond (30 secs, 
Status 0x80)
Jan  9 05:42:57 squid kernel: ata2: COMRESET failed (device not ready)
Jan  9 05:42:57 squid kernel: ata2: hardreset failed, retrying in 5 secs
Jan  9 05:43:02 squid kernel: ata2: hard resetting port
Jan  9 05:43:02 squid kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Jan  9 05:43:02 squid kernel: ata2.00: configured for UDMA/100
Jan  9 05:43:02 squid kernel: ata2: EH complete
Jan  9 05:43:02 squid kernel: SCSI device sdb: 488397168 512-byte hdwr 
sectors (250059 MB)
Jan  9 05:43:02 squid kernel: sdb: Write Protect is off
Jan  9 05:43:02 squid kernel: SCSI device sdb: write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA

Should I try a different kernel? rc3-mm1 or rc4?

Thanks.
Pablo.
