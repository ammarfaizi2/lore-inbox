Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRBDODk>; Sun, 4 Feb 2001 09:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRBDODa>; Sun, 4 Feb 2001 09:03:30 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:36612 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S131363AbRBDODY> convert rfc822-to-8bit; Sun, 4 Feb 2001 09:03:24 -0500
Date: Sun, 4 Feb 2001 21:59:24 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: <huma@roku.redroom.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with ide-scsi in 2.4.1
In-Reply-To: <Pine.LNX.4.21.0102040353390.917-100000@roku.redroom.com>
Message-ID: <Pine.LNX.4.32.0102042158150.4454-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try to add the following to /etc/modules.conf ...

pre-install sg modprobe -k sr_mod
pre-install sr_mod modprobe -k ide-scsi
pre-install ide-scsi modprobe -k ide-cd
pre-install ide-cd modprobe -k ide-probe-mod
options ide-cd ignore="hdc"


... that's assuming you want to use hdc as the ide cdrw


Jeff


On Sun, 4 Feb 2001 huma@roku.redroom.com wrote:

>
> Hi all,
>
> System: kernel 2.4.1 util-linux-2.10r cdrecord-1.9 modutils-2.3.21
>
> I have a cd writer and a cdrom in the same pc. When the kernel has SCSI
> support compiled as a module, cdrecord doesn't find anything (hdb=ide-scsi
> is passed with lilo). When is compiled with built-in scsi support, the
> writer is detected, but here comes the strange problem: if i try to mount
> any disc in the cdrom, mount spits that:
>
> isofs_read_super: bread failed, dev=16:40, iso_blknum=16, block=32
> mount: wrong fs type, bad option, bad superblock on /dev/dvd,
>        or too many mounted file systems
>        (could this be the IDE device where you in fact use
>        ide-scsi so that sr0 or sda or so is needed?)
>
> Then if I unload the ide-scsi.o mod, mount works fine. I don't know why
> ide-scsi module is detecting my ide cdrom as a scsi device if the only
> parameter passed to the kernel is "hdb=ide-scsi" (cd writer).
> And why doesn't work cdrecord when scsi support is loaded as a module?
>
> None of these problems happens when using 2.2.18. Both drives work fine
> together, with all the scsi modules and stuff.
>
>
>
> David Gómez
>
> "The question of whether computers can think is just like the question of
>  whether submarines can swim." -- Edsger W. Dijkstra
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
