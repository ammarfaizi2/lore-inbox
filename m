Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTIHT45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbTIHT45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:56:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:57041 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263599AbTIHT4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:56:54 -0400
Date: Mon, 8 Sep 2003 12:54:12 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
In-Reply-To: <20030907095423.GA10520@lps.ens.fr>
Message-ID: <Pine.LNX.4.33.0309081244080.972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been testing swsusp to disk on my computer using kernel
> 2.6.0-test4 + Patrick Mochel's main PM patch (posted on lkml on aug 31) +
> IDE PM fix from benh (posted on lkml by P. Mochel on sep 2)
> 
> I found that my computer is able to suspend to disk if I boot with
> init=/bin/sh, but not with a normal boot. I tried swsusp with a normal
> boot (Xfree, kde, ...) but after removing several modules form
> /lib/modules, to see which modules make problems. What I found:

Wow. Thanks a lot for taking the time to test this. 

> * swsusp doesn't like accelerated graphics. If the following modules are
>   loaded:
>     i830                   68120  20
>     intel_agp              14744  1
>     agpgart                25640  3 intel_agp
>   resuming fails. (Different kind of failures, from spontaneous reboot to
>   kernel panic.) I could try to pinpoint more precisely which module
>   causes trouble.

This is not suprising, and likely something that many people will run 
into. There is a lot of driver work that needs to be done, especially WRT 
video devices, as many of them are not tied into the new driver model at 
all. 

For now, the best I can say is to manually unload those modules before 
suspending and reloading them after resume. We'll work on getting the 
drivers fixed up, but it will probably take a while. 

> * Apart from that, the computer can suspend and come back to life !
>   Modules loaded:
>     snd_mixer_oss          16768  3
>     binfmt_misc             8200  1
>     autofs                 12928  0
>     ne2k_pci                8288  0
>     8390                    8576  1 ne2k_pci
>     snd_virmidi             3584  2
>     snd_seq_virmidi         5632  1 snd_virmidi
>     ipchains               48080  15
>     ide_cd                 36736  0
>     cdrom                  33312  1 ide_cd
>     loop                   13192  14
>     hid                    30272  0
>     ehci_hcd               21120  0
>     uhci_hcd               27656  0
>     usbcore                91348  5 hid,ehci_hcd,uhci_hcd
>   However, the mouse is not working anymore (mouse is usb, the only usb
>   device connected) nor network on eth1 (I haven't tried eth0.)

For both the mouse and eth1, will they work if you unload the modules 
first, and reload them after resuming? 

Thanks,


	Pat

