Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVFRXUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVFRXUp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 19:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFRXUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 19:20:45 -0400
Received: from bay104-f29.bay104.hotmail.com ([65.54.175.39]:64043 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262198AbVFRXUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 19:20:04 -0400
Message-ID: <BAY104-F295AF1E9F80CC64DDEF85784F70@phx.gbl>
X-Originating-IP: [65.54.175.204]
X-Originating-Email: [idht4n@hotmail.com]
In-Reply-To: <20050618225238.GB23688@devserv.devel.redhat.com>
From: "David L" <idht4n@hotmail.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad: scheduling while atomic!: how bad?
Date: Sat, 18 Jun 2005 16:19:58 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2005 23:19:58.0861 (UTC) FILETIME=[3EC183D0:01C5745C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >On Sat, 2005-06-18 at 14:59 -0700, David L wrote:
> > >> I'm seeing the message:
> > >>
> > >> bad: scheduling while atomic!
> > >>
> > >> I see this dozens of times when I'm writing to a nand flash device 
>using
> > >a
> > >> vendor-provided driver from Compulab in 2.6.8.1.  Does this mean the
> > >driver
> > >> has a bug or is incompatible with the preemptive configuration 
>option?
> > >How
> > >> bad is "bad"?  Should I turn of the preemption option, ignore the
> > >message,
> > >> or what?
> > >
> > >can you post the sourcecode of the driver? it needs fixing...
> > It's on-line at:
> >
> > http://www.compulab.co.il/686-developer.htm
> >
> > under "Linux - kernel, drivers and patches".
> >
> > After unzipping, it's in:
> >
> > Drivers & Patches 2.6/Flash Disk/cl_fdrv.tgz
>
>that's only part of the source though... can you point at the full one ?

I'm pretty sure that's all the source... there was some documentation that 
told how to edit the drivers/block/Kconfig and Makefile to actually build 
it... below are the instructions.  With just what was in that directory, I 
was able to use their driver.

Cheers...

                   David

Copy the file cl_fdrv.tar.gz into the directory <kernel_src>/drivers/block
Then run
cd <kernel_src>/drivers/block
tar xfz  cl_fdrv.tar.gz
Then open the file <kernel_source>/drivers/block/Kconfig
and, after line menu "Block devices"
add 3 following lines

config 686CORE_FLASH
	tristate "686CORE flash drivers"
	source "drivers/block/cl_fdrv/Kconfig"

and save the file.

Then open the file
<kernel_source>/drivers/block/Makefile
and, after line

  obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o

add 3 following lines

  # ifdef CONFIG_686CORE_FLASH
        obj-y   += cl_fdrv/
  # endif

and save the file.

Run make gconfig (or any other configuration option) and the selection of 
the flash driver will be available at “Device Drivers” >> “Block Devices”.

Run make bzImage from the directory <kernel_source> to finish building the 
kernel.

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

