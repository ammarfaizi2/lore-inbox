Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUHKIlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUHKIlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHKIlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:41:21 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:6926 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267993AbUHKIlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:41:18 -0400
Message-ID: <4119DC86.2050507@hist.no>
Date: Wed, 11 Aug 2004 10:44:54 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] zero downtime upgrades to the kernel.
References: <41195339.9080500@superbug.demon.co.uk>
In-Reply-To: <41195339.9080500@superbug.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> Has anyone investigated how one might be able to upgrade the linux 
> kernel without rebooting?
>
> We could maybe start with just being able to upgrade kernel modules 
> while the modules were still in use.
>
> E.g. There is a bug in the hard disc driver, and we have a fix, but 
> don't want to reboot the machine.
> Could we replace the hard disc driver while it was still being used, 
> and keep mounted partitions?

You can only upgrade a module that isn't in use.  So, umount everything 
using that
driver (keeping linux running from some other drive (or ramdisk)) 
replace module,
reload module, remount filesystems.  This can be quite fast, but you do 
have to
umount (and stop all the processes running from those disks.)


There are some trick you can use with disks:
1. Have root on a initial ramdisk, and never remount to a real disk.  
This way,
    all disks can be umounted so any disk device driver can be 
replaced.  You'll
    tie up a fair amount of memory in that big initial ramdisk though.

2. Consider using multipath and different scsi adapters using different 
drivers.
   Perhaps this will let you unload adapter drivers one at a time while you
   reload the other one, and keeps disks & processes running troughout.

3. Have two identical pc's sharing a set of scsi equipment.  When you 
want to upgrade
the base kernel on one, set your IP addressses so traffic goes to the other.
This should work with protocols that allows server reboot, such as nfs.

You simply won't get a linux kernel (or module) that can be replaced 
while running,
but redundant hardware may give some of the same benefits.

Helge Hafting
