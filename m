Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbREPSVS>; Wed, 16 May 2001 14:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREPSVI>; Wed, 16 May 2001 14:21:08 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:29703 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S261802AbREPSVF>; Wed, 16 May 2001 14:21:05 -0400
Date: Wed, 16 May 2001 14:02:12 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Massimo Dal Zotto <dz@cs.unitn.it>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: wrong /dev/sd... order with multiple adapters in kernel 2.4.4
Message-ID: <20010516140212.C16609@munchkin.spectacle-pond.org>
In-Reply-To: <200105161138.NAA11330@nikita.dz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105161138.NAA11330@nikita.dz.net>; from dz@cs.unitn.it on Wed, May 16, 2001 at 01:38:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 01:38:37PM +0200, Massimo Dal Zotto wrote:
> Hi,
> 
> I have recently upgraded the kernel from 2.2.19 to 2.4.4 and discovered
> that it assigns the /dev/sd... devices in the wrong order with respect both
> to the behavior of kernel 2.2.19 and to the `scsihosts' boot option which I
> specified at the boot prompt.
> 
> I have a scsi-only machine with an Adaptec 7890 and an old Symbios 53c875.
> The Adaptec mounts an LVD disk with the root and home partitions while the
> Symbios mounts two additional disks used for other purposes:

	...

> The only way to solve my problem was to modify the makefiles and link the
> aic7xxx driver before the sym53c8xx, but this is a solution only for my
> specific case. With my patch the Adaptec is initialized first and I get
> a more consistent order of the scsi devices: 
> 
>     /dev/scsi/host0/bus0/target0/lun0   /dev/sda
>     /dev/scsi/host1/bus0/target0/lun0	/dev/sdb
>     /dev/scsi/host1/bus0/target4/lun0   /dev/sdc

I had the same problem.  The fix that I use is to compile the Symbios
driver as a module, and add:

	alias scsi_hostadapter1 sym53c8xx

to my /etc/modules.conf.  That way, when the kernel boots, it will only see the
Adaptec driver.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
