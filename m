Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318055AbSGLWpv>; Fri, 12 Jul 2002 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318050AbSGLWow>; Fri, 12 Jul 2002 18:44:52 -0400
Received: from pD952ACB5.dip.t-dialin.net ([217.82.172.181]:39559 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318051AbSGLWob>; Fri, 12 Jul 2002 18:44:31 -0400
Date: Fri, 12 Jul 2002 16:46:35 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Compile warning in fs/partitions/check.c
Message-ID: <Pine.LNX.4.44.0207121640180.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling fs/partitions/check.c, I get a couple of warnings of "pointer to 
integer of different size":


kdev is a kdev_t here, driverfs_dev is a struct device.

	kdev.value=(int)driverfs_dev->driver_data;

Is it okay to replace this with

	kdev.value=(unsigned short)driverfs_dev->driver_data;

to make the warnings go away?

Also, struct driver_file_entry->show gets initialized here:

	show: partition_device_kdev_read,

show being (ssize_t *)(struct device *driverfs_dev, char *page, size_t 
		       count, loff_t off);
but expecting (ssize_t *)(void *, char *page, size_t count, loff_t off);

Is it okay to ignore this one?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

