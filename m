Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUAGKAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUAGKAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:00:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36500 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266172AbUAGJ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:59:28 -0500
Date: Wed, 7 Jan 2004 10:59:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107095922.GY3483@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de> <200401031905.31806.arvidjaar@mail.ru> <20040103175414.GX5523@suse.de> <20040107094321.GC21059@suse.de> <20040107095029.GX3483@suse.de> <20040107095632.GA22213@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107095632.GA22213@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Olaf Hering wrote:
>  On Wed, Jan 07, Jens Axboe wrote:
> 
> > No need to put it in the kernel, user space fits the bil nicely. I don't
> > see how this would lead to IO errors?
> 
> Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI ZIP
> with 2.4 behaves like that:
> 
> 
> nectarine:~ # blockdev --rereadpt /dev/hdd
> /dev/hdd: Eingabe-/Ausgabefehler
> nectarine:~ # dmesg | tail
> nfs: server Hilbert2 OK
> nfs: server Hilbert3 not responding, still trying
> nfs: server Hilbert3 OK
> nfs: server Hilbert3 not responding, still trying
> nfs: server Hilbert3 OK
> nfs: server Hilbert2 not responding, still trying
> nfs: server Hilbert2 OK
> ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
> ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
> hdd: No disk in drive
> nectarine:~ # cat /proc/ide/hdd/model 
> IOMEGA ZIP 100 ATAPI

Two problems here. First, ide-floppy should not verbosely fail these
commands (2/3a/00 is 'medium not present'). Second, you are not using
the proper mechanism to detect media events.

> I have not checked 2.6, but I doubt it is smarter.

I doubt ide-floppy behaves any differently. But at least you can send
packet commands generically to any atapi/scsi device in 2.6, so the code
has a chance to work a bit more generically (without tons of ugly and
different ioctls for each device type).

-- 
Jens Axboe

