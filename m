Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315903AbSEGRAh>; Tue, 7 May 2002 13:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315906AbSEGRAg>; Tue, 7 May 2002 13:00:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54796 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315903AbSEGRAe>; Tue, 7 May 2002 13:00:34 -0400
Date: Tue, 7 May 2002 10:00:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E1758Ra-00081f-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002, Alan Cox wrote:
>
> /proc/ide has useful information in it that you can't get easily by
> other means at the moment - which controller is driving the disks, what
> devices are present etc.

I'd love for somebody to add the devices to the real device tree, at which
point this kind of information would be very much visible..

Right now devicefs isn't even mounted by default, but it's the only
_really_ generic way of showing things like this that we have. For people
who haven't seen it before, do a

	mount -t driverfs /devfs /devfs

and go look in there.. In particular, if you have a PCI system with a USB
device tree (or _multiple_ such trees), notice how you can look at things
like

	/driverfs/root/pci0/00:1f.4/usb_bus/000/

and it wouldn't be impossible (or even necessarily very hard) to make an
IDE controller export the "IDE device tree" the same way a USB controller
now exports the "USB device tree".

For things like hotplug etc, I think driverfs is eventually the only way
to go, simply because it gives you the full (and unambiguous) path to
_any_ device, and is completely bus-agnostic.

But there is definitely a potential backwards-compatibility-issue.

		Linus

