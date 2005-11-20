Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVKTTRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVKTTRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVKTTRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:17:18 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:34428 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932071AbVKTTRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:17:17 -0500
Date: Sun, 20 Nov 2005 14:17:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <200511201237.27537.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Message-id: <200511201417.12918.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511201202.51123.gene.heskett@verizon.net>
 <200511201237.27537.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 12:37, Gene Heskett wrote:
>On Sunday 20 November 2005 12:02, Gene Heskett wrote:
>>On Sunday 20 November 2005 00:18, Gene Heskett wrote:
>>>On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
>>>>There it is (or will soon be - the tar-ball and patches are still
>>>>uploading, and mirroring can obviously take some time after that).
>>>
>>>First breakage report, tvtime, blue screen no audio.  Trying slightly
>>>different .config for next build.  My tuner (OR51132) seems to be
>>>permanently selected in an xconfig screen.  Dunno if thats good or
>>> bad ATM.
>>
>>Update, I may be sticking my finger in the dike and hollering wolf or
>>however that old saw goes.  I've now rebooted to 3 kernels where
>> tvtime was known to work, but it doesn't.  Turning off the signal
>> detection shows that all I'm getting is some sort of digital noise. 
>> So its time to drag in another receiver and see if its the DISH
>> convertor or my pcHDTV-3000.
>>
>>More later when I've done that.
>
>Ok, the Dish is working.  My tv card, a pcHDTV-3000, worked less than 5
>minutes before I rebooted to 2.6.15-rc2 from 2.6.14.2, and now it
>doesn't even when booted back to 2.6.14.2.  These were not powerdown
>reboots so that may have a bearing on this.
>
>That leaves two possibilities.
>1) The card has died (doubtfull)
>2) something in the i2c probing for 2.6.15-rc2 put it into some odd
>mode, from which tvtime seems unable to recover from.
>
>I'd turned on the nxt-200x stuff and have now turned it off, which was
>the only diff in an lsmod listing between the boots.  If that module
>does something to the card as it inits, how can I undo that?

See above, a powerdown for 20 seconds, followed by a reboot to
2.6.14.2, and tvtime works just fine.

Here is the lsmod output for this boot:
[root@coyote linux-2.6.15-rc2]# lsmod
Module                  Size  Used by
cx88_dvb                7428  0
cx8800                 27276  2
v4l1_compat            13188  1 cx8800
v4l2_common             4864  1 cx8800
cx8802                  9092  1 cx88_dvb
cx88xx                 53024  3 cx88_dvb,cx8800,cx8802
i2c_algo_bit            8456  1 cx88xx
ir_common               7556  1 cx88xx
btcx_risc               3976  3 cx8800,cx8802,cx88xx
tuner                  37032  0
tveeprom               12304  1 cx88xx
videodev                7296  4 cx8800,cx88xx
mt352                   6148  1 cx88_dvb
or51132                 9220  1 cx88_dvb
video_buf_dvb           4612  1 cx88_dvb
dvb_core               75304  1 video_buf_dvb
video_buf              17540  5
cx88_dvb,cx8800,cx8802,cx88xx,video_buf_dvb
lgdt330x                7580  1 cx88_dvb
cx22702                 5892  1 cx88_dvb
dvb_pll                 7812  3 cx88_dvb,or51132,cx22702
radeon                101888  1
drm                    64020  2 radeon
nvidia_agp              6044  1
agpgart                29000  2 drm,nvidia_agp
w83627hf               24592  0
hwmon_vid               2176  1 w83627hf
i2c_isa                 3584  1 w83627hf
i2c_nforce2             5760  0
i2c_core               17808  12
cx88_dvb,cx88xx,i2c_algo_bit,tuner,tveeprom,mt352,or51132,lgdt330x,cx227
02,w83627hf,i2c_isa,i2c_nforce2

Pardon the wrapping of the last line in mid-word.

Now, the difference that I can see is that I cannot build a 2.6.15-rc2
without the nxt200x stuffs without depmod spitting out a whole menu of
squawks about dvb_stuffs.

This card apparently doesn't need the nxt2000x stuffs, so how do I go
about building a working 2.6.15-rc2 kernel without it?

.configs available on request.

>Comments anyone?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

