Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSFEUkE>; Wed, 5 Jun 2002 16:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSFEUkD>; Wed, 5 Jun 2002 16:40:03 -0400
Received: from air-2.osdl.org ([65.201.151.6]:29833 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316309AbSFEUkB>;
	Wed, 5 Jun 2002 16:40:01 -0400
Date: Wed, 5 Jun 2002 13:35:59 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Simon Turvey <turveysp@ntlworld.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Devfs and driverfs
In-Reply-To: <000901c20ccf$00baa230$030ba8c0@mistral>
Message-ID: <Pine.LNX.4.33.0206051327000.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Simon Turvey wrote:

> I apologise if this is a trivial question but I was hoping someone could
> explain or point me in the direction of more info.
> 
> I understand the purpose and reason for devfs but I cannot find any info on
> driverfs.  What's it for?

There is some documentation in Documentation/filesystems/driverfs.txt. It 
is a bit outdated, but the general purpose of it should be in there. 

Basically, driverfs is a filesystem that maps onto the global device tree. 
Each device found in the system gets a directory in driverfs. In this 
directory, ascii-based files can be created that export device parameters 
(kind of an ascii-based ioctl). 

Files can be created by the bus the device resides on, by a driver that 
binds to the device, or by the class the device registers with. 

In addition to the global device tree, driverfs now exports a flat listing
of bus types in the system. Each bus type gets a directory, which it is 
free to create interface files in. It also a has a devices directory and a 
drivers directory. The former has symlinks for all the devices found on 
that bus type that point to each device's directory in the physical 
hierarchical layout. The drivers directory contains a directory for each 
driver for that bus type. In those directories, drivers may create files 
to export driver-specific parameters (that control the entire driver, not 
an individual device). 

	-pat

