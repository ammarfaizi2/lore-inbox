Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUGPOfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUGPOfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUGPOfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:35:33 -0400
Received: from bay1-f12.bay1.hotmail.com ([65.54.245.12]:59660 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266451AbUGPOfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:35:08 -0400
X-Originating-IP: [65.33.213.143]
X-Originating-Email: [theosib@hotmail.com]
From: "Timothy Miller" <theosib@hotmail.com>
To: tiwai@suse.de, miller@techsource.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: HELP: Cannot get ALSA working on via82xx
Date: Fri, 16 Jul 2004 10:35:07 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F12tY48eOLJSs100037ffc@hotmail.com>
X-OriginalArrivalTime: 16 Jul 2004 14:35:07.0389 (UTC) FILETIME=[172A7AD0:01C46B42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Takashi Iwai <tiwai@suse.de>
>To: Timothy Miller <miller@techsource.com>
>CC: Timothy Miller <theosib@hotmail.com>,linux-kernel@vger.kernel.org
>Subject: Re: HELP:  Cannot get ALSA working on via82xx
>Date: Thu, 15 Jul 2004 18:09:29 +0200
>
>At Thu, 15 Jul 2004 12:08:47 -0400,
>Timothy Miller wrote:
> >
> > Thank you for responding!
> >
> >
> > Takashi Iwai wrote:
> > > At Wed, 07 Jul 2004 14:26:54 -0400,
> > > Timothy Miller wrote:
> > >
> > >>I must once again reiterate my begging for help on this topic.  I've
> > >>gotten lots of help on the gentoo forum, but none of it's fixed my
> > >>problems, and I've only gotten one response on LKML.
> > >>
> > >>*BEG* *BEG* *BEG*
> > >>
> > >>Please, won't someone take pity on me?  :)  Thanks!
> > >
> > >
> > > via82xx doesn't support MPU401 by itslef although via686 does.
> >
> > I'm not sure if I have via686 or not.  Various tools like lspci don't
> > seem to reveal much.
>
>Hmm, lspci must show the string like 'VIA86C686A' or 'VIA8235' ('VIA'
>can be 'VT').

Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 
Audio Controller (rev 50)

Is this meaningful?

Here's the whole thing:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] 
Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:0b.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 
01)
0000:00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 0c)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If 
[Radeon 9000] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc Radeon RV250 [Radeon 
9000] (Secondary) (rev 01)


>
> > That's one of the problems I keep running into with Linux.  There aren't
> > good tools for finding out what you have, and even when you do find out
> > what you have, it's hard to figure out which modules you need, because
> > the module names don't correspond well with the chipset name.
>
>You can use alsaconf script.  It will detect the right module.

I ran that just now... it ripped out the dxs_support option, it didn't seem 
to do anything with regard to modules, and the sound system is going 
completely nuts.

>
> > Furthermore, there doesn't seem to be a good way to relate module names
> > with menuconfig entries.  When someone says to use xyz module, I can't
> > figure out which menuconfig option to select, so I have to compile ALL
> > of them as modules, and when someone tells me to use a given menu
> > option, I can't figure out which module corresponds to it.
>
>That's true.  The sure way would be to retrieve the pci id table from
>the source code...
>
> > > You can try snd-mpu401 module instead.
> >
> > Well, I have a module snd-mpu401, but when I modprobe it, I get an error
> > about a non-existant device.
>
>Then you might need to give the correct port number and the irq
>number as module parameters.  Perhaps you can get them from BIOS.
>

I'll have to look, but I'm not sure the BIOS says anything about it.  
Shouldn't it be "plug and play" anyhow?  I thought the days of manually 
configuring IRQ's were gone...

>
> >  > When ACPI is enabled, the
> > > configuration will be done automatically.
> > > The midi device can be available as the second card.
> >
> > Ah, well, I had nightmares trying to use ACPI.  I use just APM for
> > things like power-off (power-off works with APM, but not with ACPI).
> > Maybe some of the experts can help me to figure out how to get it all to
> > work.
> >
> > I'm about ready to give up on ALSA and go back to OSS.  Maybe someone
> > can help me to figure out how to get MIDI sequencing to work with OSS
> > instead.  OSS would at least do audio right without noise and popping
> > sounds, etc.
>
>I guess you see a kernel message when you load snd-via8xx driver
>regarding dxs_support option (suppose that your chip is VIA823x)?
>
>In worst case, you can eliminate the  noises with dxs_support=2
>option.

Everyone else says to use 3, but since that doesn't work, I guess I'll try 
2.  :)

>
>
> > I apologize for the impatient nature of this post... I've been
> > struggling for weeks to get audio working right with ALSA, but every
> > piece of advise I get seems only to make things worse.
> >
> >  From what I read on various web sites, ALSA for via82xx is so buggy
> > that it's really not worth using yet.
>
>Sorry, no, the chipset on many mobos is so buggy :)
>That's why we need so many workarounds.
>
>OSS driver has no problem regarding clicking noises because it doesn't
>support the DXS channels, the multiple playback.  ALSA supports it as
>default.  dxs_support=2 options disables it.
>See ALSA-Configuration.txt for details.
>
>Anyway, OSS VIA driver also doesn't support MIDI for VIA823x.
>It's for VIA686 only, as well as on ALSA driver.

Hmm... maybe I don't have MIDI hardware then.  Time to look into timidity.

_________________________________________________________________
MSN 9 Dial-up Internet Access helps fight spam and pop-ups – now 2 months 
FREE! http://join.msn.click-url.com/go/onm00200361ave/direct/01/

