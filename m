Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315914AbSEGR1U>; Tue, 7 May 2002 13:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315915AbSEGR1T>; Tue, 7 May 2002 13:27:19 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:62434 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S315914AbSEGR1R>; Tue, 7 May 2002 13:27:17 -0400
Date: Tue, 7 May 2002 10:27:16 -0700 (PDT)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: benh@kernel.crashing.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <20020507171946.29430@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.44.0205071025060.24481-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.44 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben, what you are proposing is fairly similar to what Solaris does today.
There is a /devices directory that contains the real path while /dev
contains the legacy stuff. Seems to work fine and given the proper docs,
you can decipher what the /devices path points to fairly easily. So I
certainly wouldnt mind seeing this happen for Linux eventually.

--Jauder

On Tue, 7 May 2002 benh@kernel.crashing.org wrote:

> >	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> >
> >and it wouldn't be impossible (or even necessarily very hard) to make an
> >IDE controller export the "IDE device tree" the same way a USB controller
> >now exports the "USB device tree".
> >
> >For things like hotplug etc, I think driverfs is eventually the only way
> >to go, simply because it gives you the full (and unambiguous) path to
> >_any_ device, and is completely bus-agnostic.
> >
> >But there is definitely a potential backwards-compatibility-issue.
>
> One interesting thing here would be to have some optional link between
> the bus-oriented device tree and the function-oriented tree (ie. devfs
> or simply /dev). For example, an IDE node in driverfs could eventually
> hold symlinks to the entries it provides in /dev when using devfs (or
> just provide major/minor when not using devfs).
>
> What do you think ?
>
> One problem I've been faced with on ppc is to be able to match
> a linux device with what the firmware (Open Firmware) thinks that
> device is. The firmware view is bus-centered and it would be pretty
> easy to provide some additional entries in driverfs that give the
> OF fullpath of a given device. But then, the link between the actual
> driver in driverfs and the "device" as used by, for example, the
> filesystem isn't trivial.
>
> Ben.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

