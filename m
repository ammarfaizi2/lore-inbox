Return-Path: <linux-kernel-owner+w=401wt.eu-S1751440AbXAFSCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbXAFSCl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXAFSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:02:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:55283 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbXAFSCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:02:40 -0500
Subject: Re: how to get serial_no from usb HD disk (HDIO_GET_IDENTITY
	ioctl, hdparm -i)
From: Kay Sievers <kay.sievers@vrfy.org>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Greg KH <greg@kroah.com>, Yakov Lerner <iler.ml@gmail.com>,
       Kernel Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <459FD585.70400@seclark.us>
References: <f36b08ee0701041427u7aee90b7j46b06c3b7dd252bd@mail.gmail.com>
	 <20070106045147.GA6081@kroah.com>
	 <3ae72650701060715q4f036274xb6f8b664ab3233c@mail.gmail.com>
	 <459FD585.70400@seclark.us>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 19:02:39 +0100
Message-Id: <1168106559.23539.25.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 11:59 -0500, Stephen Clark wrote:
> Kay Sievers wrote:
> >On 1/6/07, Greg KH <greg@kroah.com> wrote:
> >>On Fri, Jan 05, 2007 at 12:27:34AM +0200, Yakov Lerner wrote:
> >>    
> >>>How can I get serial_no from usb-attached HD drive ?
> >>>
> >>use the *_id programs that come with udev, they show you how to properly
> >>do that.
> >
> >Only "advanced" ATA-USB bridges will offer you the serial number the
> >adapter reads from the disk on power-up. The usual id-tools will just
> >work fine on theses bridges.
> >
> >There is no way to reach that information with most of the cheap USB
> >storage-adapters.

> I am looking to buy a usb to ata adapter can you name some of the 
> advanced adapters?

I have a nice working bridge, in a no-name 2.5" disk-enclosure:
  $ lsusb
  Bus 005 Device 007: ID 04b4:6830 Cypress Semiconductor Corp. USB-2.0 IDE Adapter

  $ scsi_id -x -g -p0x80 -s/block/sdb -d/dev/sdb
  ID_VENDOR=TOSHIBA
  ID_MODEL=MK1017GAP
  ID_REVISION=0000
  ID_SERIAL=STOSHIBA_MK1017GAP_144M6603
  ID_SERIAL_SHORT=144M6603
  ID_TYPE=disk
  ID_BUS=scsi

  $ /lib/udev/usb_id -x /block/sdb
  ID_VENDOR=TOSHIBA
  ID_MODEL=MK1017GAP
  ID_REVISION=0000
  ID_SERIAL=TOSHIBA_MK1017GAP_DEF107727402
  ID_TYPE=disk
  ID_BUS=usb

Another one just shows for exactly the same disk put behind the bridge:
  $ lsusb
  Bus 005 Device 012: ID 0402:5621 ALi Corp. USB 2.0 Storage Device

  $ scsi_id -x -g -p0x80 -s/block/sdb -d/dev/sdb

  $ /lib/udev/usb_id -x /block/sdb
  ID_VENDOR=USB_2.0
  ID_MODEL=Storage_Device
  ID_REVISION=0100
  ID_SERIAL=USB_2.0_Storage_Device
  ID_TYPE=disk
  ID_BUS=usb


Kay

