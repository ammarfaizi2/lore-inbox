Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268467AbTANBYy>; Mon, 13 Jan 2003 20:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268472AbTANBYy>; Mon, 13 Jan 2003 20:24:54 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:13771 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S268467AbTANBYw>;
	Mon, 13 Jan 2003 20:24:52 -0500
Date: Mon, 13 Jan 2003 17:30:51 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: greg@kroah.com, mdharm-usb@one-eyed-alien.net,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: sysfs
Message-ID: <20030113173051.A18731@beaverton.ibm.com>
References: <UTC200301140109.h0E196W01345.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200301140109.h0E196W01345.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, Jan 14, 2003 at 02:09:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 02:09:06AM +0100, Andries.Brouwer@cwi.nl wrote:
> > It looks like there is a missing scsi_set_device() call in scsiglue.c,
> 
> OK, added. Now rmmod usb-storage followed by insmod usb-storage
> resulted in an oops, as usual, but after a fresh reboot:
> Yes indeed, just like desired:
> 
> % ls -l /sysfs/block/sdb/device
> ... -> ../../devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.1/2:0:0:0
> 
> Good.
> Now that you removed this scsi device from /sysfs/devices, I suppose
> you'll also want to remove
> 
> /sysfs/devices/1:0:6:0
> 
> which is an Iomega ZIP drive on the parallel port, driver imm.c,
> device sda.
> (I can also do it but have no time now. Friday.)
> 
> All the best - Andries

I don't know and have not used the parport code, it needs to be ported to
sysfs before we could simply call scsi_set_device() call in imm.c, or
maybe have a /sysfs/scsi/pseudo added via scsi_add_host(shost, NULL) or a
/sysfs/scsi/unported, similiar to was discussed on the linux-scsi thread
"[PATCH] allow NULL dev argument to scsi_add_host":

http://marc.theaimsgroup.com/?t=104231385300005&r=1&w=2

-- Patrick Mansfield
