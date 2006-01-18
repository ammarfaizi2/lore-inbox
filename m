Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWARTTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWARTTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWARTTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:19:20 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:59047 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030388AbWARTTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:19:19 -0500
Message-ID: <43CE9149.10806@gmail.com>
Date: Wed, 18 Jan 2006 23:04:41 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Mauro Carvalho Chehab <mchehab@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       alsa devel <alsa-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Johannes Stezenbach <js@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
References: <1137590968.32449.46.camel@localhost> <s5h8xtdtsej.wl%tiwai@suse.de>
In-Reply-To: <s5h8xtdtsej.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Wed, 18 Jan 2006 11:29:28 -0200,
> Mauro Carvalho Chehab wrote:
>   
>> Lee/Andrew/Linus/Takashi and others,
>>
>> 	Currently, we have some audio modules for multimedia devices under
>> drivers/media and others under sound. They also appear under different
>> points at Kconfig menus. 
>>
>> 	So, for BTTV support, current structure at linus -git is (from Kconfig
>> perspective):
>>
>> 	Sound/ALSA/PCI Devices/Bt87x Audio capture
>> 		sound/snd-bt87x.ko - ALSA audio for bttv boards
>> 	Sound/OSS/TV Card (bt848) mixer support
>> 		drivers/media/video/tvmixer.ko
>>
>> 	Multimedia/V4L/BT848 V4L
>> 		drivers/media/video/bttv.ko
>> 	Multimedia/V4L/BT848 V4L/DVB-ATSC support
>> 		drivers/media/dvb/bt8xx/bt878.ko
>> 		drivers/media/dvb/bt8xx/dvb-bt8xx.o
>>
>> 	This I couldn't found at any Kconfig (but module exists, and also an
>> entry at Makefile):
>> sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    += btaudio.o
>>
>> 	For SAA7134 and CX88, all are under Multimedia/V4L. All
>> OSS/ALSA/DVB/MPEG options are under the driver name.
>>
>> 	IMHO, from users perspective, it makes much more sense if all BTTV
>> moules (even sound ones) being under bttv video driver. Current module
>> allows using audio driver without video, but this doesn't make sense,
>> since audio will be only available, in practice, after selecting a
>> video/audio input or tuning a channel. These functionalities are
>> provided by bttv. So, we could even disable audio modules if bttv were
>> not compiled.
>>
>> 	Also, bug 5995 showed a problem when user have a bttv card and dvb is
>> also probed. dvb also handles audio, so, currently, it is mutually
>> exclusive with snd-bt87x audio.
>>
>> 	So, my proposal is to move sound/snd-bt87x.ko to drivers/media, moving
>> also its menu, and moving tvmixer menu also. After it, should move some
>> related code at bttv dvb modules, to reduce or eliminate mutually
>> exclusiveness between the two. 
>>
>> 	We might keep supporting btaudio, but I think this is already obsoleted
>> by alsa one, so, IMHO, we can just drop it. We intend to do the same
>> with saa7134-oss after some time (kernel 2.6.15 is the first with this
>> module, so we may remove it on 2.6.18 to give some time for testing).
>>     
>
> Which directory do you suppose exactly?  drivers/media/tv (or
> something like that), or existing one like drivers/media/video?
>   

Since we have the majority of existing bttv code in drivers/media/video, 
i was planning to move some existing dvb code into drivers/media/video. 
If we have alsa code also in the same place, we can have a consolidation 
of code, might be easier to go through the code, but that is my personal 
opinion, but having code related to one chip in one place might make it 
look better probably..


Manu

