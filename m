Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUKHLEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUKHLEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 06:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUKHLEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 06:04:41 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:27056 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261475AbUKHLEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 06:04:34 -0500
Date: Mon, 8 Nov 2004 12:04:27 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       Gregoire Favre <Gregoire.Favre@freesurf.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
In-Reply-To: <87bre88zt8.fsf@bytesex.org>
Message-ID: <Pine.LNX.4.60.0411081140280.3761@alpha.polcom.net>
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org>
 <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org>
 <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org>
 <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net> <87bre88zt8.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Gerd Knorr wrote:

> Grzegorz Kulewski <kangur@polcom.net> writes:
>
>> I am seeing the same problem with my bttv card. It was present in the
>> 2.4 day and is present to this day. There are some kernels that are
>> more probable to hang while others are less. It does not depend on -ck
>> or any other patchset or scheduling. I reported it to bttv maintainer
>> year or two ago, but it looks like he is very unresponsive. :-)
>
> Well, if it happens almost independant of the kernel/driver version it
> most likely is buggy hardware.  I can't do much about it ...

Well, I have Abit KG7 with AMD 760 and VIA 686B and this machine is rock 
stable. I am not able to lock it with any other usage than watching tv 
with bttv. I tested it with memtest for 40+ hours, and with heavy disk 
loads and I am compiling Gentoo from stage1 on it pretty often with 
very expensive optimizations. So I think that it is not hardware problem. 
Or it is hardware problem only when using bttv.

But others can reproduce similar problems. Two my friends have the same 
problem on very different hardware. And under Windows everything seems to 
be working well. And sometimes, but very rare, I get oops in my log 
saying something about mm and fs structures broken. But I am using nvidia 
binary drivers and I can reproduce this kind of oops once per half a year 
or something, so I didn't posted it here. If you want to look at it, I can 
search my old logs and post it off list.

It is not kernel independent too. Some 2.6 kernels are better, some are 
worse. With some kernels I can have no hang for over a month (I think it 
is near to maximal lifetime of kernel in my box) and with some others I 
can get one per couple of hours.

It is not hardware dependent too. I saw people on this list that see 
similar problems on AMD64.


> Well known example are some via chipsets which have trouble with
> multiple devices doing DMA at the same time (those tend to run stable
> with bttv once you've turned off ide-dma ...).
>
> Getting broken hardware run stable and fast is black magic.  You can
> try these (if that happens to help we can put that info into the pci
> quirks btw.):
>
>  eskarina kraxel ~# modinfo bttv | grep "pci config"
>  parm: vsfx:set VSFX pci config bit [yet another chipset flaw workaround]
>  parm: triton1:set ETBF pci config bit [enable bug compatibility for triton1 + others]

I will look at it. But now I have nearly IDE free setup. I have Silicon 
Image simple SATA controller and I still can reproduce the same problem. I 
am now using IDE only for CD/DVD, but cdrom.ko is loaded only on demand in 
my system, and I am not using it with bttv at the same time.

> Otherwise BIOS updates, obscure BIOS settings, shuffling cards in PCI
> slots, enable/disable ACPI and/or APIC, whatelse may or may not help.

Tried 100000 times.

> See also Documentation/video4linux/bttv/README.freeze

It is mirrored in my brain.

Thanks for your work. I really see the difference betwen bttv from the 
early 2.4 ancient era and smooth and clear image and sound from today's 
2.6 bttv (always with the same BT878 Prolink Pixelview PlayTV PAK II 
card).


Grzegorz Kulewski

