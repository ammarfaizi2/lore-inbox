Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422834AbWAMTNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422834AbWAMTNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWAMTNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:13:24 -0500
Received: from main.gmane.org ([80.91.229.2]:32237 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422834AbWAMTNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:13:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Problem getting PCMCIA to compile in Kernel.
Date: Sat, 14 Jan 2006 04:12:23 +0900
Message-ID: <dq8u2p$jm1$1@sea.gmane.org>
References: <43C8252F.6483.C6B2A8@mikes.kuentos.guam.net> <43C870E2.4989.4EE3A9@mikes.kuentos.guam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060103)
X-Accept-Language: en-us, en
In-Reply-To: <43C870E2.4989.4EE3A9@mikes.kuentos.guam.net>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael D. Setzer II wrote:
> On 14 Jan 2006 at 1:40, Kalin KOZHUHAROV wrote:
> 
>>>Michael D. Setzer II wrote:
>>>
>>>>I've tried to set the PCMCIA options to Y in the kernel build, but get a 
>>>>message that something else is build as a modual, so these can not be 
>>>>changed to y.
>>>
>>>How did you do that?
>>>
>>>Use `make menuconfig` to configure kernel.
>>>
>>>
>>>>I went to the .config file and replaced every =m to =y, and then 
>>>>ran make. The kernel then was built with no problem, but it reset all these 
>>>>option back to =m.
>>>>
>>>>CONFIG_PCMCIA_AHA152X=m
>>>>CONFIG_PCMCIA_FDOMAIN=m
>>>>CONFIG_PCMCIA_NINJA_SCSI=m
>>>>CONFIG_PCMCIA_QLOGIC=m
>>>>CONFIG_PCMCIA_SYM53C500=m
>>>>CONFIG_I2C_STUB=m
>>>>
>>>>I build kernels for G4L, and build everything directly into the kernel, but 
>>>>these do not seem to work, and I don't have an ideal why, since everything 
>>>>else is built in. So what am I missing. This is the 2.6.15 kernel. 
>>>
>>>If you play with .config directly, run a `make oldconfig` after that.
>>>So, `make oldconfig && make && make` should always work.
>>>If you tired that ant it did NOT, please post your .config file (not
>>>compressed) here, or upload it to a website (somewhere).
> 
> 
> I ran the make oldconfig, then make menuconfig, and when I try to change 
> the settings, it gives this message.
> 
> This feature depends on another which has been configured as  a module.
> As a result,  this feature will be built as a module.
> 
> I had manually edited the .config file, and changed all =m to =y, so there is 
> nothing in the file that has the module setting but these.
> 
> I placed a copy of the .config file at the link below. 
> http://www.guam.net/home/mikes/bzImagez.config
> 
> Only those items with the PCMCIA and I2C_STUB have the =m.
> 
> Thanks for the reply. I'm trying to make a kernel that will suppor the most 
> hardware, and avoid conflict.
> 
> 
Michael D. Setzer II wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 14 Jan 2006 at 1:40, Kalin KOZHUHAROV wrote:
> 
> To:             	linux-kernel@vger.kernel.org
> From:           	Kalin KOZHUHAROV <kalin@thinrope.net>
> Subject:        	Re: Problem getting PCMCIA to compile in Kernel.
> Date sent:      	Sat, 14 Jan 2006 01:40:28 +0900
> 
> 
>>Michael D. Setzer II wrote:
>>
>>>I've tried to set the PCMCIA options to Y in the kernel build, but get a 
>>>message that something else is build as a modual, so these can not be 
>>>changed to y.
>>
>>How did you do that?
>>
>>Use `make menuconfig` to configure kernel.
>>
>>
>>>I went to the .config file and replaced every =m to =y, and then 
>>>ran make. The kernel then was built with no problem, but it reset all these 
>>>option back to =m.
>>>
>>>CONFIG_PCMCIA_AHA152X=m
>>>CONFIG_PCMCIA_FDOMAIN=m
>>>CONFIG_PCMCIA_NINJA_SCSI=m
>>>CONFIG_PCMCIA_QLOGIC=m
>>>CONFIG_PCMCIA_SYM53C500=m
>>>CONFIG_I2C_STUB=m
>>>

Hmm, I did reproduce this:

$mkdir -p /var/kernels/src/linux-2.6.15 && cd /var/kernels/src/linux-2.6.15

$tar xjf /usr/portage-distfiles/linux-2.6.15.tar.bz2

$make allyesconfig

$ find . -name Kconfig|xargs  egrep -h "depends on m | && m" -B2
config SOUND_WAVEFRONT
        tristate "Full support for Turtle Beach WaveFront (Tropez Plus,
Tropez, Maui) synth/soundcards"
        depends on SOUND_OSS && m && OBSOLETE_OSS_DRIVER
--
config HOSTESS_SV11
        tristate "Comtrol Hostess SV-11 support"
        depends on WAN && ISA && m && ISA_DMA_API
--
config COSA
        tristate "COSA/SRP sync serial boards support"
        depends on WAN && ISA && m && ISA_DMA_API
--
config DSCC4
        tristate "Etinc PCISYNC serial board support"
        depends on WAN && PCI && m
--
config SEALEVEL_4021
        tristate "Sealevel Systems 4021 support"
        depends on WAN && ISA && m && ISA_DMA_API
--
config NE2000
        tristate "NE2000/NE1000 support"
        depends on NET_ISA || (Q40 && m) || M32R
--
config HYSDN
        tristate "Hypercope HYSDN cards (Champ, Ergo, Metro) support (module
only)"
        depends on m && PROC_FS && PCI && BROKEN_ON_SMP
--
config ISDN_DIVAS_MAINT
        tristate "DIVA Maint driver support"
        depends on ISDN_DIVAS && m
--
config PCMCIA_AHA152X
        tristate "Adaptec AHA152X PCMCIA support"
        depends on m && !64BIT
--
config PCMCIA_NINJA_SCSI
        tristate "NinjaSCSI-3 / NinjaSCSI-32Bi (16bit) PCMCIA support"
        depends on m && !64BIT

So there are things that have to be build as modules??
Didn't know that...

>>>I build kernels for G4L, and build everything directly into the kernel, but 
>>>these do not seem to work, and I don't have an ideal why, since everything 
>>>else is built in. So what am I missing. This is the 2.6.15 kernel. 
>>
>>If you play with .config directly, run a `make oldconfig` after that.
>>So, `make oldconfig && make && make` should always work.
>>If you tired that ant it did NOT, please post your .config file (not
>>compressed) here, or upload it to a website (somewhere).
> 
> 
> I ran the make oldconfig, then make menuconfig, and when I try to change 
> the settings, it gives this message.
> 
> This feature depends on another which has been configured as  a module.
> As a result,  this feature will be built as a module.
> 
> I had manually edited the .config file, and changed all =m to =y, so there is 
> nothing in the file that has the module setting but these.
> 
> I placed a copy of the .config file at the link below. 
> http://www.guam.net/home/mikes/bzImagez.config
> 
> Only those items with the PCMCIA and I2C_STUB have the =m.
> 
> Thanks for the reply. I'm trying to make a kernel that will suppor the most 
> hardware, and avoid conflict.

You can try `make allyesconfig` but that will produce huge kernel.
Try better `make allmodconfig` and then manually edit some important stuff
like IDE to be built in. Or use initrd.

BTW, what is G4L ?

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

