Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbSACLU6>; Thu, 3 Jan 2002 06:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285472AbSACLUt>; Thu, 3 Jan 2002 06:20:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49419
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285482AbSACLUh>; Thu, 3 Jan 2002 06:20:37 -0500
Date: Thu, 3 Jan 2002 03:17:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: Sync and reboot (was: Re: system.map)
In-Reply-To: <20020103115913.A23530@cistron.nl>
Message-ID: <Pine.LNX.4.10.10201030313190.14215-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry but if the patch of mine gets accepted there is a notifier hook that
first flushes_cache and holds for the return, then spins down the disks.

The cache_flushes are called always in addition if you were to look
closely at the new driver, each time you unmount a partition the disk is
flushed.  Overkill sure, but you will always have at least one flush cache
on a drive that has never been mounted.  You will have a min of 3 flush
cache calls on a drive which is mounted.

1 for each partition mounted.
1 of dec the usage counter to 0.
1 for deregistering the device.

Regards,

On Thu, 3 Jan 2002, Miquel van Smoorenburg wrote:

> According to vda:
> > However, then my shutdown script waits 5 secs before hard rebooting the box: 
> > there is no way to be sure that IDE drives flushed their cache, except for 
> > large pause.
> 
> There is, and sysvinit-2.83 implements it ;)
> 
> > (There may be some IDE command to do it, but who said each and every drive 
> > will implement it? (and will do it correctly, i.e. would not lie to us that 
> > cache is written back) :-)
> 
> There's supposed to be an IDE command but it depends on task files and
> what not according to Andre Hedrick.
> 
> However there is another way. Putting the drive in standby mode also
> flushes the write cache, and reboot/halt from sysvinit 2.83 and up
> look for all IDE drives and put them in standby mode just before calling
> the kernel's hard reboot/halt.
> 
> Ofcourse the kernel should do that itself, the IDE driver should
> register a reboot handler that does this - but it doesn't, so I
> put it in sysvinit for now.
> 
> Mike.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

