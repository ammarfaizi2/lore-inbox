Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWGVRBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWGVRBH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWGVRBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:01:07 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:37314 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1750969AbWGVRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:01:02 -0400
Message-ID: <44C259CB.8040901@mauve.plus.com>
Date: Sat, 22 Jul 2006 18:00:59 +0100
From: Ian Stirling <tandra@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Montgomery <xiphmont@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] USB snd-usb-audio wedges lsusb when unplugged
 while playing sound.
References: <44C21635.5090808@mauve.plus.com> <806dafc20607220949y4ebbc88av99e0e689e1fd687e@mail.gmail.com>
In-Reply-To: <806dafc20607220949y4ebbc88av99e0e689e1fd687e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Montgomery wrote:
> On 7/22/06, Ian Stirling <tandra@mauve.plus.com> wrote:
> 
>> Config/... as my earlier message on USB - though with the bandwidth
>> enforcement
>> turned off so it actually plays sound, when plugged into the USB1 port.
>>
>> 2.6.17.
>>
>> Basically - playing sound with
>> mplayer -ao alsa:device=hw=1 or whatever - and then unplugging the
>> soundcard completely wedges lsusb/usb configuration, until the mplayer
>> process is killed.
> 
> 
> This sounds like the well known EPIPE problem in usb-audio and one I
> intended to fix after dealing with the ehci scheduler.
<snip>
> enough system load on the machine that it may well even stop pinging.
> Although the *machine* is not wedged, if this happens in a realtime
> thread (eg, jack using a usb-audio device), it may well be hosed
> enough to become unrecoverable.

I just did it again, and the machine is >90% idle (PII/300), with 
mplayer doing:

ioctl(5, 0x806c4120, 0xbffeffd0)        = -1 ENODEV (No such device)
write(2, "alsa-lib: pcm_hw.c:406:(snd_pcm_"..., 89) = 89
write(2, "alsa-space: cannot get pcm statu"..., 50) = 50
nanosleep({0, 10000000}, NULL)          = 0
ioctl(5, 0x806c4120, 0xbffeffd0)        = -1 ENODEV (No such device)

about 70 times a second.
Of course, with other software, it may be different.
