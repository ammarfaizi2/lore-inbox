Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUGOS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUGOS3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUGOS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 14:29:40 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:20896 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S266273AbUGOS3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 14:29:31 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: HELP:  Cannot get ALSA working on via82xx
Date: Thu, 15 Jul 2004 14:29:29 -0400
User-Agent: KMail/1.6
References: <BAY1-F133LSW50Pfs56000059d7@hotmail.com> <s5hk6x9cseh.wl@alsa2.suse.de> <40F6AC0F.1010309@techsource.com>
In-Reply-To: <40F6AC0F.1010309@techsource.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407151429.29988.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.62.14] at Thu, 15 Jul 2004 13:29:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 July 2004 12:08, Timothy Miller wrote:
>Thank you for responding!
>
>Takashi Iwai wrote:
>> At Wed, 07 Jul 2004 14:26:54 -0400,
>>
>> Timothy Miller wrote:
>>>I must once again reiterate my begging for help on this topic. 
>>> I've gotten lots of help on the gentoo forum, but none of it's
>>> fixed my problems, and I've only gotten one response on LKML.
>>>
>>>*BEG* *BEG* *BEG*
>>>
>>>Please, won't someone take pity on me?  :)  Thanks!
>>
>> via82xx doesn't support MPU401 by itslef although via686 does.
>
>I'm not sure if I have via686 or not.  Various tools like lspci
> don't seem to reveal much.
>
>That's one of the problems I keep running into with Linux.  There
> aren't good tools for finding out what you have, and even when you
> do find out what you have, it's hard to figure out which modules
> you need, because the module names don't correspond well with the
> chipset name. Furthermore, there doesn't seem to be a good way to
> relate module names with menuconfig entries.  When someone says to
> use xyz module, I can't figure out which menuconfig option to
> select, so I have to compile ALL of them as modules, and when
> someone tells me to use a given menu option, I can't figure out
> which module corresponds to it.
>
>> You can try snd-mpu401 module instead.
>
>Well, I have a module snd-mpu401, but when I modprobe it, I get an
> error about a non-existant device.
>
> > When ACPI is enabled, the
>>
>> configuration will be done automatically.
>> The midi device can be available as the second card.
>
>Ah, well, I had nightmares trying to use ACPI.  I use just APM for
>things like power-off (power-off works with APM, but not with ACPI).
>Maybe some of the experts can help me to figure out how to get it
> all to work.
>
>I'm about ready to give up on ALSA and go back to OSS.  Maybe
> someone can help me to figure out how to get MIDI sequencing to
> work with OSS instead.  OSS would at least do audio right without
> noise and popping sounds, etc.
>
>I apologize for the impatient nature of this post... I've been
>struggling for weeks to get audio working right with ALSA, but every
>piece of advise I get seems only to make things worse.
>
> From what I read on various web sites, ALSA for via82xx is so buggy
>that it's really not worth using yet.
>
Humm, then why is everything running fine here, using alsa, on a 
via82xx chipset, an 8233 TBE.  Check your lsmod output against this:

Module                  Size  Used by
snd_seq_oss            32896  0
snd_seq_midi_event      7744  1 snd_seq_oss
snd_seq                51408  4 snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            50792  0
snd_mixer_oss          18624  1 snd_pcm_oss
snd_via82xx            25860  2
snd_ac97_codec         65860  1 snd_via82xx
snd_pcm                92644  3 snd_pcm_oss,snd_via82xx
snd_timer              24964  2 snd_seq,snd_pcm
snd_page_alloc         11400  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7488  1 snd_via82xx
snd_rawmidi            24448  1 snd_mpu401_uart
snd_seq_device          8072  3 snd_seq_oss,snd_seq,snd_rawmidi
snd                    54500  14 
snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

All this on a 2.6.8-rc1-mm1 kernel.

xmms runs fine, tvtime runs fine, I can play a cd or a realaudio 
stream from the net, and the sound is pretty decent.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
