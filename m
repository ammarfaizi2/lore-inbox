Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWGGWq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWGGWq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWGGWq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:46:26 -0400
Received: from bay0-omc1-s20.bay0.hotmail.com ([65.54.246.92]:1494 "EHLO
	bay0-omc1-s20.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932205AbWGGWqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:46:25 -0400
Message-ID: <BAY101-F36134FF75230018F6F09A8B4740@phx.gbl>
X-Originating-IP: [69.28.99.209]
X-Originating-Email: [whothevella@hotmail.com]
From: "Who Dunnit" <whothevella@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Upgrading kernel modules with a flash filesystem
Date: Fri, 07 Jul 2006 15:46:23 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Jul 2006 22:46:25.0213 (UTC) FILETIME=[2D2736D0:01C6A217]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if it is possible to have your kernel modules be stored in a 
partition different from the one on which the kernel is. The intent is to 
simply have /lib/modules/`uname -r` be a symbolic link to a directory on 
another disk.

I am using a 2.6 kernel and the /etc/inittab file seems to invoke 
/etc/init.d/rc.udev before it mounts all the other partitions (say on other 
disks). This leads to a case where udevstart (invoked from rc.udev) tries to 
probe for modules that exist in a partition that hasn't been mounted yet 
leading to a whole bunch of error messages.

Having the partition containing these modules be mounted before 
/etc/init.d/rc.udev is invoked is not an option either since /dev hasn't 
been populated yet.

Being able to point /lib/modules/`uname -r` to a directory in another 
partition seems to be an easy way to "upgrade" modules in flash based 
filesystems where you might not be comfortable erasing existing module files 
before installing new ones for the reason that the whole process takes time 
and any power failure during this time can be catastrophic. Being able to 
download all your modules to a new partition and simply flip 
/lib/modules/`uname -r` to point to a different directory in a new partition 
for the upgrade to automatically happen seems like a nifty feature to have.

Is it possible, using /etc/init.d/rc.udev to be able to only create a subset 
of the final /dev tree so that this model can be made to work?

Or maybe there is a whole different strategy on module upgrades for flash 
based filesystems which, being a Linux novice, I am not aware of.

Cheers!
Vella

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement

