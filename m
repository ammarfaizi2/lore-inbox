Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130595AbRBAPqk>; Thu, 1 Feb 2001 10:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130597AbRBAPqb>; Thu, 1 Feb 2001 10:46:31 -0500
Received: from datafoundation.com ([209.150.125.194]:21770 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S130595AbRBAPqQ>; Thu, 1 Feb 2001 10:46:16 -0500
Date: Thu, 1 Feb 2001 10:46:12 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 not fully sane on Alpha - file systems
In-Reply-To: <20010131234925.A14300@ellpspace.math.ualberta.ca>
Message-ID: <Pine.LNX.4.30.0102011039180.31149-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Michal Jaegermann wrote:

> I just tried to boot 2.4.1 kernel on Alpha UP1100.  This machine
> happens to have two SCSI disks on sym53c875 controller and two IDE
> drives hooked to a builtin "Acer Laboratories Inc. [ALi] M5229 IDE".

ALI M1535D pci-ide bridge, isn't it? That's what the specs on
API's webpage seem to indicate.

> It boots and in the first moment makes even a pretty good impression
> of beeing healthy.  But an attempt to compile something causes the
> whole setup to start behaving weird, with a compiler obviously unable
> to find both itself and the right sources, and the whole thing ends in
> a silent lockup.

Try this for fun: dd if=/dev/hda of=/dev/null bs=4096, and see if it
cronks out.

In my case, any serious I/O on the IDE drives quickly results in pretty
technicolor on the VGA screen, and then a hard lockup.

Furthermore, after power-reset, 2.4.x, x=0 or 1, cannot successfully fsck
the drives.  It hangs after about the 2nd-3rd partition, again in a hard
lockup.

I have to boot into 2.2.x to fsck the drives, make changes, and reboot to
hang the system.

My WAG is that there are problems in the ALI driver.

> On the second boot I tried to copy kernel sources from a SCSI to an
> IDE drive.  This time I got something in my logs and the same stuff
> was printed on my screen before everything lockded up really tight
> again (no sysrq).  Here it is:
>
>  kernel: attempt to access beyond end of device
>  kernel: 08:05: rw=0, want=198500353, limit=5779456
>  kernel: attempt to access beyond end of device
>  kernel: 08:05: rw=0, want=4294934529, limit=5779456
>  kernel: attempt to access beyond end of device
>  kernel: 08:05: rw=0, want=198500353, limit=5779456
>  kernel: EXT2-fs error (device sd(8,5)): ext2_readdir: bad entry in
>  directory #250255: directory entry across blocks - offset=0,
>  inode=198505472, rec_len=32768, name_len=255
>
> (and the machine dies at this point).

AIC7xxx controller, just recently started spewing errors very similar to
this -- amongst a host of others, as I was trying to get the UP1100 to use
a generic IDE interface rather than the ALI 15x3.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
