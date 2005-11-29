Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVK2VaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVK2VaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVK2VaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:30:07 -0500
Received: from kirby.webscope.com ([204.141.84.57]:31650 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932375AbVK2VaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:30:05 -0500
Message-ID: <438CC83E.50100@m1k.net>
Date: Tue, 29 Nov 2005 16:29:34 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: video4linux-list@redhat.com, CityK <CityK@rogers.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Perry Gilfillan <perrye@linuxmail.org>, Don Koch <aardvark@krl.com>,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <200511291335.18431.gene.heskett@verizon.net> <438CA1E3.7010101@m1k.net> <200511291546.27365.gene.heskett@verizon.net>
In-Reply-To: <200511291546.27365.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk, Perry and Don, please see below...

Gene Heskett wrote:

>On Tuesday 29 November 2005 13:45, Michael Krufky wrote:
>
>>>me too.  And I just rebuilt 2.6.14 w/o the cvs, did a cold boot, and
>>>it works just fine except the modprobe stage was silent at the cli.
>>>But my logs are being spammed with:
>>>
>>>Nov 29 13:24:49 coyote kernel: CORE IOCTL: 0xc02c5638
>>>Nov 29 13:24:49 coyote kernel: CORE IOCTL: 0xc054561d
>>>Nov 29 13:24:49 coyote last message repeated 2 times
>>>Nov 29 13:24:49 coyote kernel: CORE IOCTL: 0xc008561c
>>>Nov 29 13:24:49 coyote kernel: CORE IOCTL: 0xc0445624
>>>Nov 29 13:24:49 coyote kernel: CORE IOCTL: 0xc008561c
>>>Nov 29 13:24:49 coyote kernel: CORE IOCTL: 0xc054561d
>>>Nov 29 13:24:53 coyote last message repeated 131 times
>>>Nov 29 13:24:53 coyote kernel: CORE IOCTL: 0xc008561c
>>>
>>>
>>>My hard drives have been power cycled more times in the last few days
>>>playing with this than at any time in their history since I have a BIG
>>>ups.
>>>
>>>So I think I'm back to 2.6.14.3 for a while. Lemme know if and when
>>>there is something else to test.  Right now I'm vacuuming up water in
>>>the basement for the first time in years, it rained HARD here earlier.
>>>      
>>>
>>Gene-
>>
>>There IS something more to test, unless I missed an email from you....
>>
>>...and it's going to be very hard for people to follow your problem...
>>Please stick with your original thread to discuss your particular
>>problem.
>>    
>>
>Gah, I marked the thread as important, but then it jumped to the v4l
>list from lkml and I got lost in the shuffle.
>
>>What happens when you install v4l-dvb cvs on top of 2.6.14.y ?
>>    
>>
>Already did that, blew up as usual, cold boot required.
>
>>(Gene's card uses Thomson DDT 7610 - we need to figure out what analog
>>demod is in play, here.)
>>    
>>
>Ok, here is an lsmod after doing the modprobe cx88-dvb:
>
>[root@coyote linux-2.6.14]# lsmod |grep cx88
>cx88_dvb                7428  0
>cx8800                 27276  0
>v4l1_compat            13188  1 cx8800
>v4l2_common             4864  1 cx8800
>cx8802                  9092  1 cx88_dvb
>cx88xx                 53024  3 cx88_dvb,cx8800,cx8802
>i2c_algo_bit            8456  1 cx88xx
>ir_common               7556  1 cx88xx
>btcx_risc               3976  3 cx8800,cx8802,cx88xx
>tveeprom               12304  1 cx88xx
>videodev                7296  2 cx8800,cx88xx
>mt352                   6148  1 cx88_dvb
>or51132                 9220  1 cx88_dvb
>video_buf_dvb           4612  1 cx88_dvb
>video_buf              17540  5
>cx88_dvb,cx8800,cx8802,cx88xx,video_buf_dvb
>lgdt330x                7580  1 cx88_dvb
>cx22702                 5892  1 cx88_dvb
>dvb_pll                 7812  3 cx88_dvb,or51132,cx22702
>i2c_core               17808  12
>cx88_dvb,cx88xx,i2c_algo_bit,tuner,tveeprom,mt352,or51132,lgdt330x,cx227
>02,w83627hf,i2c_isa,i2c_nforce2
>---------
>And the log spamming originates and stops according to whether or not
>I'm watching tv on it, and continues to do so when booted to 2.6.14.3. 
>Once up and running, its not very often, but hundreds of lines of it
>during the startup & a few during the shutdown (of tvtime)
>
>Interesting to me is that I was under the impression that the nxt200x
>module was the tuner driver, but its not anyplace in the list whether I
>smunch it with the grep or not.
>  
>
nxt200x is a dvb frontend driver -- it is NOT a tuner driver, although 
it does work with the tuner, but not on your board (pchdtv 3000).  
nxt200x is used by cx88-dvb for the ATi HDTV Wonder, and it's used by 
saa7134-dvb for the AVerTVHD A180.  The nxt200x was not present in 
2.6.14, although it IS present in 2.6.15 and v4l-dvb cvs.  We know that 
this is not causing your trouble because Kirk Lapray has both the ATI 
HDTV Wonder AND pcHDTV 3000 installed on his system, and he says both 
are working properly.

However, I don't know if Kirk has tried 2.6.15-rc3 yet...

Kirk, do both cards work properly in both analog AND digital video?  
...or were you only talking about digital?  Kirk, I could really use 
your help in diagnosing the problem that Gene, Perry and Don are talking 
about.  It looks like something in the 2.6.15 patchsets broke analog 
video on the pcHDTV 3000.... Would you kindly be able to test 2.6.15-rc3 
on your hardware?

>The logs do say its a Thompson 7610 tuner though.
>-----------
>Nov 29 13:38:31 coyote kernel: TV tuner 52 at 0x1fe, Radio tuner -1 at
>0x1fe
>Nov 29 13:38:31 coyote kernel: tuner 2-0061: chip found @ 0xc2 (cx88[0])
>Nov 29 13:38:31 coyote kernel: tuner 2-0061: type set to 52 (Thomson DDT
>7610 (ATSC/NTSC))
>----------
>
>Now, I'm out of pocket till late this evening.  I'll check in of course
>when I get back.  I'd like to get this resolved before I get stuck in
>an airplane & shipped to upstate MI for a while.  I'm gettin too old
>for this back to work crap.   But a $1k/week & expenses comes in handy
>too. :)
>  
>
Gene, Perry and Don -

I wish that we could resolve this with a -git bisection test... 
Unfortunately, we cannot do it this time, as the VM_RESERVED memory 
problems existed throughout 2.6.15 development.

All I can think of doing is telling you to start reverting cx88 / tuner 
related v4l patches, but that is very tedious....

Another idea is to try installing cvs again on top of your kernel, but 
with each unsuccessful checkout, back out cvs a few days, using the -D 
option.....

If you need better details on how to do this, let me know... I'll try to 
write something up.

-Mike
