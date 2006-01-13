Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161563AbWAMRFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161563AbWAMRFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161564AbWAMRFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:05:12 -0500
Received: from main.gmane.org ([80.91.229.2]:37585 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161563AbWAMRFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:05:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: ata errors -> read-only root partition. Hardware issue?
Date: Sat, 14 Jan 2006 02:04:31 +0900
Message-ID: <dq8mj0$leb$1@sea.gmane.org>
References: <5ttip-Xh-13@gated-at.bofh.it> <43C4493A.4010305@shaw.ca>	 <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>	 <1136986688.28616.7.camel@localhost.localdomain>	 <5a2cf1f60601110552t5e9afa0dr7785b22ae6dbd99b@mail.gmail.com>	 <5a2cf1f60601110726r46805e1dl784f0a0ca20c128@mail.gmail.com> <1137001442.27255.53.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060103)
X-Accept-Language: en-us, en
In-Reply-To: <1137001442.27255.53.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-01-11 at 16:26 +0100, jerome lacoste wrote:
> 
>>Could something else (bad cable or disk controller ) trigger these
>>issues?
>>
>>It would be great if we users had a quick way to decipher these
>>messages.
>>
>>E.g.
>>
>>"Buffer I/O error on device xxxx, logical block yyyyyyy"
>>
>>Usualy a disk failure, may also be caused by.... 
> 
> 
> This is not a bad idea, "status=0x51 { DriveReady SeekComplete Error }"
> in my experience always indicates a failing hard drive.  Maybe a
> "Possible drive or media failure" could be added?

I posted this in another thread, but reposting here. This is an Asus P5GDC-V
MB with WD740GD harddisk.

The machine was locking hard (no KBD, video, network) after a few hours of
uptime with kenrels 2.6.12 ... 2.6.14.4, now running 2.6.15 with patched
sk98lin. After some random time (up to 2d), the dmesg output is full of these:

[snip, see below as it is identical]

the fs is mounted ro, and most I/O is dead (like trying to use
/sbin/shutdown resulting in I/O error). I checked the disk with WD Data
LifeGuardTools and no errors were reported. smartctl says this:

ooops, the machine is again borked and not here, will post smartctl
tomorrow, but basicaly no errors are reported after extended tests.

Now dmesg says:

[17225533.452000] ata1: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 471
ss 113 se 0
[17225533.452000] ata1: translated ATA stat/err 0x71/04 to SCSI SK/ASC/ASCQ
0xb/00/00
[17225533.452000] ata1: status=0x71 { DriveReady DeviceFault SeekComplete
Error }
[17225533.452000] ata1: error=0x04 { DriveStatusError }
[17225533.452000] ata1: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 471
ss 113 se 0
[17225533.452000] ata1: translated ATA stat/err 0x71/04 to SCSI SK/ASC/ASCQ
0xb/00/00
[17225533.452000] ata1: status=0x71 { DriveReady DeviceFault SeekComplete
Error }
[17225533.452000] ata1: error=0x04 { DriveStatusError }
[17225533.452000] ata1: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 471
ss 113 se 0
[17225533.452000] ata1: translated ATA stat/err 0x71/04 to SCSI SK/ASC/ASCQ
0xb/00/00
[17225533.452000] ata1: status=0x71 { DriveReady DeviceFault SeekComplete
Error }
[17225533.452000] ata1: error=0x04 { DriveStatusError }
[17225533.452000] ata1: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 471
ss 113 se 0
[17225533.452000] ata1: translated ATA stat/err 0x71/04 to SCSI SK/ASC/ASCQ
0xb/00/00
[17225533.452000] ata1: status=0x71 { DriveReady DeviceFault SeekComplete
Error }
[17225533.452000] ata1: error=0x04 { DriveStatusError }
[17225533.452000] ata1: port reset, p_is 40000001 is 1 pis 0 cmd c017 tf 471
ss 113 se 0
[17225533.452000] ata1: translated ATA stat/err 0x71/04 to SCSI SK/ASC/ASCQ
0xb/00/00
[17225533.452000] ata1: status=0x71 { DriveReady DeviceFault SeekComplete
Error }
[17225533.452000] ata1: error=0x04 { DriveStatusError }
[17225533.452000] sd 0:0:0:0: SCSI error: return code = 0x8000002
[17225533.452000] sda: Current: sense key=0xb
[17225533.452000]     ASC=0x0 ASCQ=0x0
[17225533.452000] end_request: I/O error, dev sda, sector 17632540
[17225533.452000] Buffer I/O error on device sda3, logical block 1216070
[17225533.452000] lost page write due to I/O error on sda3
[17225677.824000] ReiserFS: sda3: warning: clm-6006: writing inode 10055 on
readonly FS
[17225677.824000] ReiserFS: sda3: warning: clm-6006: writing inode 10055 on
readonly FS


At least the good thing is that I can ssh now.

After soft reboot (for i in s u s b; do echo $i >/proc/sysrq-trigger; sleep
1;done ) form a borked state (like now) the bios fails to detect the
harddisk and hangs indefinately...

Kalin.

P.S. Will try sky2 tomorrow instead of sk98lin.
P.P.S. Also askid in "2.6.15 and CONFIG_PRINTK_TIME" thread, but any idea
why is this strange time printed since boot?

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

