Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVCaVCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVCaVCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVCaVBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:01:46 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:40380 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261776AbVCaVAh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:00:37 -0500
Date: Thu, 31 Mar 2005 16:00:34 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07 (update)
In-reply-to: <200503311317.55230.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>
Message-id: <200503311600.34454.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
 <20050331174927.GA11483@elte.hu> <200503311317.55230.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 13:17, Gene Heskett wrote:
>On Thursday 31 March 2005 12:49, Ingo Molnar wrote:
>>* Steven Rostedt <rostedt@goodmis.org> wrote:
>>> Oh, and did your really want to assign debug = .1?
>>>
>>> - .debug = .1, .file = __FILE__, .line = __LINE__
>>> + .debug = 1, .file = __FILE__, .line = __LINE__
>>
>>doh - indeed. This means rwlocks were nondebug all along? Ouch.
>> I've uploaded -42-08 with the fix.
>>
>> Ingo
>
>It wasn't there when I looked yet, so I just built 42-05, Ingo.
>Almost everything works except I can't get any video out of tvtime,
>and the audio quality is still intermittently tinny,  sometimes
> cured by an internal tvtime restart with earlier versions but not
> this version.  Tinny sound seem to be forever now.
>
>Also, lots of logging from tvtime, as if it was getting the video
> but missing a frame occasionally, and spit this out when I quit it.
>
>Mar 31 13:05:00 coyote kernel: rtc latency histogram of
> {tvtime/5251, 1303 samples}:
>Mar 31 13:05:00 coyote kernel: 4 1
>Mar 31 13:05:00 coyote kernel: 5 190
>Mar 31 13:05:00 coyote kernel: 6 455
>Mar 31 13:05:00 coyote kernel: 7 264
>Mar 31 13:05:00 coyote kernel: 8 84
>Mar 31 13:05:00 coyote kernel: 9 42
>Mar 31 13:05:00 coyote kernel: 10 22
>Mar 31 13:05:00 coyote kernel: 11 34
>Mar 31 13:05:00 coyote kernel: 12 15
>Mar 31 13:05:00 coyote kernel: 13 21
>Mar 31 13:05:00 coyote kernel: 14 19
>Mar 31 13:05:00 coyote kernel: 15 18
>Mar 31 13:05:00 coyote kernel: 16 10
>Mar 31 13:05:00 coyote kernel: 17 6
>Mar 31 13:05:00 coyote kernel: 18 8
>Mar 31 13:05:00 coyote kernel: 19 6
>Mar 31 13:05:00 coyote kernel: 20 8
>Mar 31 13:05:00 coyote kernel: 21 1
>Mar 31 13:05:00 coyote kernel: 22 2
>Mar 31 13:05:00 coyote kernel: 23 2
>Mar 31 13:05:00 coyote kernel: 25 1
>Mar 31 13:05:00 coyote kernel: 26 2
>Mar 31 13:05:00 coyote kernel: 29 1
>Mar 31 13:05:00 coyote kernel: 30 2
>Mar 31 13:05:00 coyote kernel: 47 1
>Mar 31 13:05:00 coyote kernel: 9999 88
>
>
>I have -08 now, so I'll go build that one next.  Other than these,
>this one 'feels' good.
>
Now I'm on 42-08, it still feels good, but somebodies done something 
bad for tvtime when its accessing a pcHDTV-3000 card for the src.  No 
video, blue screen.

Thinking that loading it in rc.local was out of order (that works for 
2.6.12-rc1), I've rmmod-ed the whole thing and reloaded after 
starting X, no difference.

>From the logs when I executed a modprobe cx88-dvb:
-----------------------------
Mar 31 15:18:53 coyote kernel: Linux video capture interface: v1.00
Mar 31 15:18:53 coyote kernel: cx2388x v4l2 driver version 0.0.4 
loaded
Mar 31 15:18:53 coyote kernel: ACPI: PCI interrupt 0000:01:07.0[A] -> 
GSI 11 (level, low) -> IRQ 11
Mar 31 15:18:53 coyote kernel: cx88[0]: subsystem: 7063:3000, board: 
pcHDTV HD3000 HDTV [card=22,autodetected]
Mar 31 15:18:53 coyote kernel: i2c-algo-bit.o: cx88[0] passed test.
Mar 31 15:18:53 coyote kernel: tuner 3-0061: chip found @ 0xc2 (cx88
[0])
Mar 31 15:18:53 coyote kernel: tuner 3-0061: type set to 52 (Thomson 
DDT 7610 (ATSC/NTSC))
Mar 31 15:18:53 coyote kernel: cx88[0]/0: found at 0000:01:07.0, rev: 
5, irq: 11, latency: 32, mmio: 0xea000000
Mar 31 15:18:53 coyote kernel: cx88[0]/0: registered device video0 
[v4l2]
Mar 31 15:18:53 coyote kernel: cx88[0]/0: registered device vbi0
Mar 31 15:18:53 coyote kernel: cx88[0]/0: registered device radio0
Mar 31 15:19:03 coyote kernel: cx2388x dvb driver version 0.0.4 loaded
Mar 31 15:19:03 coyote kernel: ACPI: PCI interrupt 0000:01:07.2[A] -> 
GSI 11 (level, low) -> IRQ 11
Mar 31 15:19:03 coyote kernel: cx88[0]/2: found at 0000:01:07.2, rev: 
5, irq: 11, latency: 32, mmio: 0xeb000000
Mar 31 15:19:03 coyote kernel: cx88[0]/2: cx2388x based dvb card
Mar 31 15:19:03 coyote kernel: DVB: registering new adapter (cx88[0]).
Mar 31 15:19:03 coyote kernel: DVB: registering frontend 0 (pcHDTV 
HD3000 HDTV)...
----------------------------

An lsmod shows this for that card:
--Module                  Size  Used by
cx88_dvb                5764  0
cx8802                  8068  1 cx88_dvb
mt352                   6532  1 cx88_dvb
or51132                 9348  1 cx88_dvb
dvb_pll                 3972  2 cx88_dvb,or51132
video_buf_dvb           4740  1 cx88_dvb
dvb_core               76072  1 video_buf_dvb
cx8800                 27276  0
cx88xx                 48416  3 cx88_dvb,cx8802,cx8800
i2c_algo_bit            8456  1 cx88xx
video_buf              17796  5 
cx88_dvb,cx8802,video_buf_dvb,cx8800,cx88xx
ir_common               6404  1 cx88xx
tveeprom               11800  1 cx88xx
v4l1_compat            12676  1 cx8800
v4l2_common             4992  1 cx8800
btcx_risc               4104  3 cx8802,cx8800,cx88xx
tuner                  25768  0
videodev                7680  2 cx8800,cx88xx
-------------------
I've snipped the webcam and firewire stuff as its not applicable here.

>From the logs when I fired up tvtime:
-----------------------------
Mar 31 15:22:12 coyote kernel: cx88[0]: video y / packed - dma channel 
status dump
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: initial risc: 
0x1ecce000
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: cdt base    : 
0x00180440
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: cdt size    : 
0x0000000c
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: iq base     : 
0x00180400
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: iq size     : 
0x00000010
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: risc pc     : 
0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: iq wr ptr   : 
0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: iq rd ptr   : 
0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: cdt current : 
0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: pci target  : 
0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]:   cmds: line / byte : 
0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]:   risc0: 0x00000000 [ INVALID 
count=0 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   risc1: 0x00000000 [ INVALID 
count=0 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   risc2: 0x00000000 [ INVALID 
count=0 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   risc3: 0x00000000 [ INVALID 
count=0 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 0: 0x80008000 [ sync 
resync count=0 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 1: 0x1c000500 [ write sol 
eol count=1280 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 2: 0x1b9a3000 [ arg #1 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 3: 0x1c000500 [ write sol 
eol count=1280 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 4: 0x1b9a3a00 [ arg #1 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 5: 0x1c000500 [ write sol 
eol count=1280 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 6: 0x194d4400 [ arg #1 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 7: 0x18000200 [ write sol 
count=512 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 8: 0x194d4e00 [ arg #1 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq 9: 0x14000300 [ write eol 
count=768 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq a: 0x194d5000 [ arg #1 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq b: 0x1c000500 [ write sol 
eol count=1280 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq c: 0x194d5800 [ arg #1 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq d: 0x0031c040 [ INVALID 
21 20 cnt0 resync 14 count=64 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq e: 0x00000000 [ INVALID 
count=0 ]
Mar 31 15:22:12 coyote kernel: cx88[0]:   iq f: 0x00000011 [ INVALID 
count=17 ]
Mar 31 15:22:12 coyote kernel: cx88[0]: fifo: 0x00180c00 -> 0x183400
Mar 31 15:22:12 coyote kernel: cx88[0]: ctrl: 0x00180400 -> 0x180460
Mar 31 15:22:12 coyote kernel: cx88[0]:   ptr1_reg: 0x00181d20
Mar 31 15:22:12 coyote kernel: cx88[0]:   ptr2_reg: 0x00180478
Mar 31 15:22:12 coyote kernel: cx88[0]:   cnt1_reg: 0x0000005a
Mar 31 15:22:12 coyote kernel: cx88[0]:   cnt2_reg: 0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]/0: [f3aa07e0/0] timeout - 
dma=0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]/0: [f3aa01e0/1] timeout - 
dma=0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]/0: [edbc8a60/2] timeout - 
dma=0x00000000
Mar 31 15:22:12 coyote kernel: cx88[0]/0: [f7391540/3] timeout - 
dma=0x1ecce000
------------------------------
and which appears to repeat for every frame it should display.  Very 
voluminous logging.

It works great when running 2.6.12-rc1 FWTW.  Which I'll be doing 
again shortly, but first I'll check out kino & my movie camera, and 
spca50x & my webcam.

kino works, includeing sound, this is ieee1394/firewire stuffs.

And, after a make clean;make;make install in the scpa50x src dir, that 
works.  My scanner works and while I haven't tried to print, the web 
interface says its all ready and waiting to go.  In other words the 
usb appears to be fine.

Networking seems to be ok, mail is coming in more or less normally.

So does anyone have any suggestions as to what to check out in 
tvtime/pcHDTV area.

Humm, in the FWIW category, under the video stuffs in a make xconfig, 
the module/switch/whatever that is under
DVB broadcasting-->DVB for linux-->Core Support, and way down at the 
bottom of the list is "Customize DVB Frontends", and again clear at 
the bottom of the list is "nxt2002 based" which when you check it, 
should show (I think)
 a checkbox infront of the OR51132 Based (pcHDTV)
But it does not.  However, the command to 'modprobe cx88-dvb' does 
load it as can be seen by the lsmod screen above.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
