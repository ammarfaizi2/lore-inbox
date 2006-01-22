Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWAVSvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWAVSvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAVSvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:51:49 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41641 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751143AbWAVSvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:51:48 -0500
Date: Sun, 22 Jan 2006 13:51:41 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
In-Reply-To: <1137918044.3328.6.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> 
 <1137917798.3328.2.camel@laptopd505.fenrus.org> <1137918044.3328.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Jan 2006, Arjan van de Ven wrote:

> On Sun, 2006-01-22 at 09:16 +0100, Arjan van de Ven wrote:
>> On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:
>>> I have a memory leak in scsi_cmd_cache.

>> does this happen without the binary nvidia driver too? (it appears
>> you're using that). That's a good datapoint to have if so...

I had the exact same nvidia driver with 2.6.12 (just recompiled) and it 
didn't happen there.

But just in case I used slabtop to watch scsi_cmd_cache grow by 1.24KB per 
second (104MB per day), then I rmmoded nvidia and watched it grow by 
1.16KB per second.

The speed is not constant, watching it, and listening to the disks, it 
looks like it grows with each IO request.

> btw please post an lsmod, so that we can find "common" things with the
> other reporters of this issue, and thus maybe are able to get closer to
> the issue by reducing the candidates...

Here is my lsmod, but since I compile most things into the kernel the 
config.gz I sent earlier is probably much more useful.

And BTW I don't even have any scsi devices. scsi is being used by sata and 
usb storage.

 	-Ariel

Module                  Size  Used by
nvidia               3924252  12
vmnet                  34340  3
vmmon                 172556  0
snd_rtctimer            3724  1
ipv6                  269408  24
ipt_state               2304  5
ipt_MASQUERADE          4096  1
eth1394                21512  0
cx88_blackbird         21276  0
tvaudio                24732  0
msp3400                35248  0
tda9887                16656  0
tuner                  45476  0
cx88_dvb               10628  0
cx8802                 12676  2 cx88_blackbird,cx88_dvb
mt352                   7172  1 cx88_dvb
or51132                11140  1 cx88_dvb
video_buf_dvb           7172  1 cx88_dvb
ohci1394               35764  0
bttv                  168208  0
nxt200x                16004  1 cx88_dvb
firmware_class         10880  4 cx88_blackbird,or51132,bttv,nxt200x
cx8800                 33548  1 cx88_blackbird
ieee1394              313016  2 eth1394,ohci1394
cx88xx                 63776  4 cx88_blackbird,cx88_dvb,cx8802,cx8800
snd_bt87x              15432  3
video_buf              22788  7 
cx88_blackbird,cx88_dvb,cx8802,video_buf_dvb,bttv,cx8800,cx88xx
ir_common               9988  1 cx88xx
tveeprom               15760  2 bttv,cx88xx
lgdt330x                8604  1 cx88_dvb
cx22702                 6916  1 cx88_dvb
btcx_risc               5384  4 cx8802,bttv,cx8800,cx88xx

