Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291862AbSBHWA6>; Fri, 8 Feb 2002 17:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291869AbSBHWAu>; Fri, 8 Feb 2002 17:00:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4358 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291862AbSBHWAa>; Fri, 8 Feb 2002 17:00:30 -0500
Date: Fri, 8 Feb 2002 13:50:50 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Alexander Viro <viro@math.psu.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warning, 2.5.3 eats filesystems
In-Reply-To: <20020208111457.GA117@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10202081349550.15165-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> > > > > 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> > > > > beware.
> > > 
> > > > I can confirm that there are filesystem corruption issues with 2.5.3;
> > > > after this message I rebooted and did a forced fsck which turned up
> > > > around a half dozen inodes where the block count in the inode itself was
> > > > too high.
> > > 
> > > Exactly the same thing here, and I bet it _is_ 2.5.3 and not a relict from
> > > a 2.5.3-pre patch because I switched directly from 2.4.17 to 2.5.3
> > > without ever using any pre patch at this machine.
> > 
> > Very interesting.  Which filesystems are mounted (other than ext2) and
> > are you been able to reproduce it on 2.5.3-pre6?
> 
> Mounted filesystems:
> 
> /dev/hda2 on / type ext2 (rw)
> none on /proc type proc (rw)
> ...
> none on /proc type proc (rw)
> /dev/hda3 on /suse type ext2 (rw)
> none on /proc type proc (rw)
> none on /proc/bus/usb type usbdevfs (rw)
> /dev/cfs0 on /overlay type coda (rw)
> 
> (I wander what is responsible for mounting /proc hundred times?)
> 
> But... you should know that I'm strongly suspecting ide subsystem:
> 
> Feb  8 12:08:02 amd kernel: hda: status timeout: status=0xd0 { Busy }
> Feb  8 12:08:02 amd kernel: hda: drive not ready for command
> Feb  8 12:08:02 amd kernel: ide0: reset: success
> Feb  8 12:09:26 amd kernel: hda: status timeout: status=0xd0 { Busy }
> Feb  8 12:09:26 amd kernel: hda: drive not ready for command
> Feb  8 12:09:26 amd kernel: ide0: reset: success
> Feb  8 12:12:27 amd kernel: hda: status timeout: status=0xd0 { Busy }
> Feb  8 12:12:27 amd kernel: hda: drive not ready for command
> Feb  8 12:12:27 amd kernel: ide0: reset: success
> 
> I'm trying to test it with md5sum, but so far it behaves ok. [I wonder
> what directory I'll loose this time ... :-(]
> 									Pavel
> 
> -- 
> (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Yep I warned about multmode pio.
I think I finally have a fix which does not use a copy of the request.


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

