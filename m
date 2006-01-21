Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWAUGyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWAUGyU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 01:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWAUGyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 01:54:20 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:17350 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750976AbWAUGyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 01:54:19 -0500
Message-ID: <43D1DA98.1080704@linuxtv.org>
Date: Sat, 21 Jan 2006 01:54:16 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Gill <gillb4@telusplanet.net>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BTTV broken on recent kernels
References: <43CAFF82.4030500@telusplanet.net> <200601160418.44549.s0348365@sms.ed.ac.uk> <43CC51FE.7090907@telusplanet.net>
In-Reply-To: <43CC51FE.7090907@telusplanet.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Gill wrote:

> Alistair John Strachan wrote:
>
>> On Monday 16 January 2006 02:05, Bob Gill wrote:
>>  
>>
>>> Hi.  The last several kernel versions have led to broken bttv (up to 4
>>> or 5 kernel versions ago, I could watch tv on either mplayer or xawtv),
>>> but lately bttv is broken.  My card is an 'bt878 compatible built by 
>>> ATI
>>> (ATI TV Wonder VE).  I'm pretty certain it worked as late as
>>> 2.6.14-git7.  I've peeked around /Changes and didn't see anything.   
>>> I'm
>>> using the same build script as before, and a piece of lsmod shows
>>> serial_core            14848  1 8250
>>> rtc                     9524  0
>>> tuner                  36908  0
>>> bttv                  148564  0
>>> video_buf              15748  1 bttv
>>> compat_ioctl32          1152  1 bttv
>>> i2c_algo_bit            7432  1 bttv
>>> v4l2_common             6528  2 tuner,bttv
>>> btcx_risc               3720  1 bttv
>>> ir_common               7812  1 bttv
>>> tveeprom               12304  1 bttv
>>> i2c_core               14864  4 tuner,bttv,i2c_algo_bit,tveeprom
>>> videodev                6912  1 bttv
>>> snd_emu10k1            94628  2 snd_emu10k1_synth
>>> ..........also, a chunk of lspci shows:
>>> 0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game
>>> Port (rev 07)
>>> 0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878
>>> Video Capture (rev 02)
>>> 0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio
>>> Capture (rev 02)
>>> ....it's just that I get a blank (screen blanking due to no signal)
>>> screen when I start a tv application.  I can try to change 
>>> channels/tune
>>> frequencies, and it looks like the applications are trying, but nothing
>>> gets tuned in.   To be fair, I must mention that I *ahem* taint the
>>> kernel with Nvidia stuff, and recently upgraded gcc (although it has
>>> always worked well with tainted kernel, and it broke before I upgraded
>>> gcc (to gcc version 4.0.2) on Debian Sarge.   
>>
>>
>> This problem sounds suspiciously like an overlay bug, known in the 
>> binary NVIDIA driver. Please try changing it to "nv" in XF86Config, 
>> then restarting your TV application..
>>
>>  
>>
>>> If you *really* want, I can revert XF86Config to use non-nvidia 
>>> drivers (and revert back to the old
>>> version of gcc) and give a bug report from that, but I suspect things
>>> will remain broken.  Mplayer compiles very well with the new version of
>>> gcc, and the new kernel (buit with the new version of gcc) does
>>> everything else (sound, firewire, cd/dvd/networking, disk I/O etc.)
>>> without problems.
>>> Thanks in advance,
>>> Bob
>>>   
>>
>>
>>  
>>
> Alistair, Lee: thank you for your replies.  Sadly the bug is in the 
> Nvidia binary.  Changing the driver to nv from nvidia did resolve the 
> issue.  Now I have to decide whether I like accelerated 3d more, or 
> using the tv tuner more (till Nvidia fixes the driver).  Thank you for 
> your time.  I won't waste any more LKML bandwidth on this (Nvidia 
> bug).  Thanks again.
> Bob 

Not that I would recommend the binary nvidia driver, but:

You can probably get bttv to work despite this overlay bug by using 
"grabdisplay" mode instead.  There is an option for it in xawtv.  The 
difference is, in overlay mode, the capture card is writing directly to 
videoram.  Using grabdisplay mode eliminates this optimization, and 
would be a decent workaround for you.

Hope this helps,

Michael

-- 
Michael Krufky

