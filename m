Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131552AbRAQRHu>; Wed, 17 Jan 2001 12:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132129AbRAQRHa>; Wed, 17 Jan 2001 12:07:30 -0500
Received: from niwot.scd.ucar.edu ([128.117.8.223]:471 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP
	id <S131552AbRAQRHV>; Wed, 17 Jan 2001 12:07:21 -0500
Date: Wed, 17 Jan 2001 10:07:09 -0700
From: Craig Ruff <cruff@ucar.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117100709.A3247@bells.scd.ucar.edu>
In-Reply-To: <mike@UDel.Edu> <200101171616.LAA01194@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200101171616.LAA01194@localhost.localdomain>; from J.E.J.Bottomley@HansenPartnership.com on Wed, Jan 17, 2001 at 11:16:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 11:16:58AM -0500, James Bottomley wrote:
> One of the ways this could be solved would be to impose bus ordering on the 
> detection sequence.  
> ...

On Solaris and Irix, there is an auxillary file in /etc that maps
the hardware path to a controller to a controller instance number.
This lets you name a device based on the controller instance number,
and to possibly move to a different physical slot it if needed.

Some examples:

Irix /etc/ioconfig.conf:

2 /hw/module/1/slot/io9/fibre_channel/pci/0/scsi_ctlr/0

This says that SCSI controller 2 is really a Fibre Channel controller in
slot 9 (on an Origin 2000).

Solaris /etc/path_to_inst:
"/pci@4,4000/scsi@3" 0 "qla2200"

This says that the QLA2200 Fibre Channel controller in slot 3 of PCI bus
4,4000 is controller 0 (zero) for the qla2200 driver.

"/pci@4,4000/scsi@3/sd@0,3" 737 "sd"

This says that SCSI target 0 will be unit 737 for the sd driver.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
