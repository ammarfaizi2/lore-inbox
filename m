Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSGMOqx>; Sat, 13 Jul 2002 10:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSGMOqw>; Sat, 13 Jul 2002 10:46:52 -0400
Received: from host194.steeleye.com ([216.33.1.194]:1803 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314340AbSGMOqw>; Sat, 13 Jul 2002 10:46:52 -0400
Message-Id: <200207131449.g6DEnbk02977@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Thunder from the hill <thunder@ngforever.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: Further madness in fs/partitions/check.c?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jul 2002 09:49:37 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> struct device contains a void * driver_data. It should certainly point
> to  a couple of bytes where the driver data was saved.

> In line 288, we have this:

> current_driverfs_dev->driver_data = (void *)__mkdev(hd->major,
> minor+part);

> What kind of pointer should we get here? ;-)

> Can the author please explain what was intented here?

This is transient code to save the device in the driver_data.  It is later 
picked back out at line 229.  It conforms to the old programmer principle that 
if you can always guarantee your data takes up less space than a pointer (on 
all archs), then you might as well just cast the data into the pointer instead 
of wasting a malloc for it.

The driverfs code is still in flux.  However, partition handling (if it 
belongs anywhere at all) will probably be in the unwritten class handlers and 
greatly tidied up.

The idea behind this code is to get a quick and dirty view of what partitions 
might be seen as in driverfs and thus to stimulate debate about how they 
should be done.

James


