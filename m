Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVDBWjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDBWjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVDBWjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:39:14 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:61134 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261304AbVDBWit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:38:49 -0500
Date: Sat, 02 Apr 2005 17:38:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-reply-to: <20050402203458.GA16230@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Steven Rostedt <rostedt@goodmis.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Message-id: <200504021738.36739.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050325145908.GA7146@elte.hu>
 <1112473038.28826.25.camel@mindpipe> <20050402203458.GA16230@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 April 2005 15:34, Ingo Molnar wrote:
>* Lee Revell <rlrevell@joe-job.com> wrote:
>> It wasn't clear from your last mail whether you were using NFS. 
>> If so I would be suspicious given the NFS changes in the new RT
>> patches. I'll try to reproduce the problem on a local fs.
>
>also, try to undo the fs/nfs/*.c and include/linux/*nfs*.h changes,
>those are latency breakers, so not strictly necessary.
>
> Ingo
Hi Ingo;

I just got done rebooting to 43-06, had problems with my heyu
startup scripts again, but I finally found a missing & in one
of them, and I can have it recycle itself from the cli like it
used to again.

So far, with *all* the 'logit' switches turned on and in full
preempt mode, there's nothing unusual in the log.

Here goes tvtime from a cli:
Audio only, blue screen video, this in the log:
---------------
Apr  2 17:12:48 coyote kernel: cx88[0]: video y / packed - dma channel status dump
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: initial risc: 0x06b46000
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: cdt base    : 0x00180440
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: cdt size    : 0x0000000c
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: iq base     : 0x00180400
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: iq size     : 0x00000010
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: risc pc     : 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: iq wr ptr   : 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: iq rd ptr   : 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: cdt current : 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: pci target  : 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]:   cmds: line / byte : 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]:   risc0: 0x00000000 [ INVALID count=0 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   risc1: 0x00000000 [ INVALID count=0 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   risc2: 0x00000000 [ INVALID count=0 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   risc3: 0x00000000 [ INVALID count=0 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 0: 0x80008000 [ sync resync count=0 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 1: 0x1c000500 [ write sol eol count=1280 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 2: 0x06922000 [ arg #1 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 3: 0x1c000500 [ write sol eol count=1280 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 4: 0x06922a00 [ arg #1 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 5: 0x1c000500 [ write sol eol count=1280 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 6: 0x2dc68400 [ arg #1 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 7: 0x18000200 [ write sol count=512 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 8: 0x2dc68e00 [ arg #1 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq 9: 0x14000300 [ write eol count=768 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq a: 0x2dc69000 [ arg #1 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq b: 0x1c000500 [ write sol eol count=1280 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq c: 0x2dc69800 [ arg #1 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq d: 0x0031c040 [ INVALID 21 20 cnt0 resync 14 count=64 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq e: 0x00000000 [ INVALID count=0 ]
Apr  2 17:12:48 coyote kernel: cx88[0]:   iq f: 0x00000011 [ INVALID count=17 ]
Apr  2 17:12:48 coyote kernel: cx88[0]: fifo: 0x00180c00 -> 0x183400
Apr  2 17:12:48 coyote kernel: cx88[0]: ctrl: 0x00180400 -> 0x180460
Apr  2 17:12:48 coyote kernel: cx88[0]:   ptr1_reg: 0x00182118
Apr  2 17:12:48 coyote kernel: cx88[0]:   ptr2_reg: 0x00180488
Apr  2 17:12:48 coyote kernel: cx88[0]:   cnt1_reg: 0x00000082
Apr  2 17:12:48 coyote kernel: cx88[0]:   cnt2_reg: 0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]/0: [d4da5940/0] timeout - dma=0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]/0: [d4da5d40/1] timeout - dma=0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]/0: [d417d960/2] timeout - dma=0x00000000
Apr  2 17:12:48 coyote kernel: cx88[0]/0: [d4da5540/3] timeout - dma=0x06b46000
Apr  2 17:12:49 coyote kernel: cx88[0]: video y / packed - dma channel status dump
[...]
followed by many repeats of the above as I let it run about
5-6 seconds.  On exit, this:
Apr  2 17:12:57 coyote kernel: rtc latency histogram of {tvtime/5717, 232 samples}:
Apr  2 17:12:57 coyote kernel: 20 4
Apr  2 17:12:57 coyote kernel: 21 81
Apr  2 17:12:57 coyote kernel: 22 64
Apr  2 17:12:57 coyote kernel: 23 32
Apr  2 17:12:57 coyote kernel: 24 13
Apr  2 17:12:57 coyote kernel: 25 2
Apr  2 17:12:57 coyote kernel: 26 8
Apr  2 17:12:57 coyote kernel: 27 2
Apr  2 17:12:57 coyote kernel: 28 3
Apr  2 17:12:57 coyote kernel: 29 1
Apr  2 17:12:57 coyote kernel: 30 1
Apr  2 17:12:57 coyote kernel: 32 2
Apr  2 17:12:57 coyote kernel: 33 2
Apr  2 17:12:57 coyote kernel: 34 1
Apr  2 17:12:57 coyote kernel: 35 1
Apr  2 17:12:57 coyote kernel: 37 1
Apr  2 17:12:57 coyote kernel: 9999 14
------------
dma timeouts. I don't get these, and I do get good video under 2.6.12-rc1
re-installing the pcHDTV-2.0 stuff doesn't help.

The rest of the stuff I usually check..

xsane ok

kino ok, only errors logged was because I started it before
turning the camera on :(

spcagui ok once spca50x was reinstalled, a few lines in the log:
-------------------
Apr  2 17:21:54 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: USB SPCA5XX camera found. Type Labtec Webcam Pro Zc0302 + Hdcs2020
Apr  2 17:21:54 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: [spca50x_probe:7258] Camera type JPEG
Apr  2 17:21:54 coyote kernel: usbcore: registered new driver spca50x
Apr  2 17:21:54 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: spca5xx driver 56.02.06 registered
Apr  2 17:21:54 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/zc3xx.h: [zc3xx_init:231] Find Sensor HDCS2020
Apr  2 17:21:55 coyote kernel: /usr/src/spca-stf/spca5xx-20050206/drivers/usb/spca50x.c: init isoc: usb_submit_urb(0) ret -28
Apr  2 17:22:08 coyote kernel: ohci_hcd 0000:00:02.1: bad entry 37ce6580
-------------------
That last item was when I clicked the Q button I believe.
But it worked, albeit with a pretty decent cpu hit, 25% or so.
That cpu hit is nothing new, its the jpeg decoder I'm told.

This "feels good" so far, but I'd sure like to get tvtime working again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
