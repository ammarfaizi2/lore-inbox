Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSKIEpD>; Fri, 8 Nov 2002 23:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSKIEpD>; Fri, 8 Nov 2002 23:45:03 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:36015 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262314AbSKIEpC>; Fri, 8 Nov 2002 23:45:02 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 8 Nov 2002 20:51:28 -0800
Message-Id: <200211090451.UAA26160@baldur.yggdrasil.com>
To: willy@debian.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Cc: andmike@us.ibm.com, hch@lst.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
>Actually I think the generic device model is crap. [...]

My patch is a net deletion of 57 lines and will allow simplification
of parisc DMA allocation.

Although I agree with most of your criticisms about the generic device
model, most of the problems with it are the way people use it (the
first thing everyone wants to do is a driverfs file system) and some
conventions that I disagree with, such as the idea that drivers that
embed struct device and struct device_driver should not initialize
those fields directly, but should have xxx_register_device copy them
in.  parisc can use the generic driver API without getting fat.

Problems specific to the generic device API can be incrementally
improved and nobody is treating it as set in stone.  I think the
generic device API is close enough already so that it's worth porting
to, even if future clean-ups will then require some small changes to
the code that is ported to it.

Please do not throw the baby out with the bath water.  The generic
driver interface in its present form really can make parisc smaller
and cleaner.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
