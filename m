Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315908AbSEGRTa>; Tue, 7 May 2002 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315910AbSEGRT3>; Tue, 7 May 2002 13:19:29 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:35782 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S315908AbSEGRT2>; Tue, 7 May 2002 13:19:28 -0400
From: <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Date: Tue, 7 May 2002 19:19:46 +0200
Message-Id: <20020507171946.29430@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	/driverfs/root/pci0/00:1f.4/usb_bus/000/
>
>and it wouldn't be impossible (or even necessarily very hard) to make an
>IDE controller export the "IDE device tree" the same way a USB controller
>now exports the "USB device tree".
>
>For things like hotplug etc, I think driverfs is eventually the only way
>to go, simply because it gives you the full (and unambiguous) path to
>_any_ device, and is completely bus-agnostic.
>
>But there is definitely a potential backwards-compatibility-issue.

One interesting thing here would be to have some optional link between
the bus-oriented device tree and the function-oriented tree (ie. devfs
or simply /dev). For example, an IDE node in driverfs could eventually
hold symlinks to the entries it provides in /dev when using devfs (or
just provide major/minor when not using devfs).

What do you think ?

One problem I've been faced with on ppc is to be able to match
a linux device with what the firmware (Open Firmware) thinks that
device is. The firmware view is bus-centered and it would be pretty
easy to provide some additional entries in driverfs that give the
OF fullpath of a given device. But then, the link between the actual
driver in driverfs and the "device" as used by, for example, the
filesystem isn't trivial.

Ben.



