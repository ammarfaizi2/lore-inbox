Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTCFI1h>; Thu, 6 Mar 2003 03:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTCFI1h>; Thu, 6 Mar 2003 03:27:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:29006
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267937AbTCFI1e>; Thu, 6 Mar 2003 03:27:34 -0500
Date: Thu, 6 Mar 2003 03:35:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mike Anderson <andmike@us.ibm.com>
cc: Andries.Brouwer@cwi.nl, "" <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
In-Reply-To: <20030306083054.GB1503@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
 <20030306064921.GA1425@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
 <20030306083054.GB1503@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Mike Anderson wrote:

> Zwane Mwaikambo [zwane@linuxpower.ca] wrote:
> > scsi1 : QLogic ISP1020 SCSI on PCI bus 04 device 70 irq 89 MEM base 0xf8a18000
> > scsi: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 0 lun 0
> > scsi: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 1 lun 0
> > 
> 
> Did this work in 2.5.62? The qlogicisp driver does have any error
> handlers. Any error will cause a device offline state. You
> should see a message at boot like:
> ERROR: This is not a safe way to run your SCSI host            
> ERROR: The error handling must be added to this driver

That error was from a booting 2.5.62 and i do get the warnings about 
missing error handling.

> This does not explain what is causing the error handler to start up or
> do anything to help your problem.

I'm not concerned about that, that was peripheral damage from another 
patch (affected irq handling), the difference being is that with 2.5.62 it boots 
after printing those errors a couple of times, but with 2.5.63 it doesn't.
 
> We have been switching to the feral driver to handle the qlogic isp
> card. This driver contains error handling routines. I believe the 2.5
> versions of the driver is in the -mm tree. I also believe Andrew has it
> as a separate patch. 
> 
> I did try running the qlogicisp driver and it appears to be loading for
> me, but I do not have any non-disk devices on the system at the moment.

I'm currently using it with the following devices and survives general 
usage.

scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 70 irq 41 MEM base 0xf8a16000
  Vendor: IBM       Model: DRHS36V           Rev: 0270
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DRHS36V           Rev: 0270
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: PLEXTOR   Model: CD-ROM PX-32CS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 72170879 512-byte hdwr sectors (36951 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72170879 512-byte hdwr sectors (36951 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sr0: scsi-1 drive

	Zwane
-- 
function.linuxpower.ca
