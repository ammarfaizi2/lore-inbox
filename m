Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbUKDJT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUKDJT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbUKDJT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:19:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62869 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262139AbUKDJTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:19:41 -0500
Date: Thu, 4 Nov 2004 10:19:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
Message-ID: <20041104091909.GD14993@suse.de>
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de> <41889EB5.3060304@tequila.co.jp> <20041103090550.GG10434@suse.de> <41896816.2090204@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41896816.2090204@tequila.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04 2004, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/03/2004 06:05 PM, Jens Axboe wrote:
> > On Wed, Nov 03 2004, Clemens Schwaighofer wrote:
> > 
> >>-----BEGIN PGP SIGNED MESSAGE-----
> >>Hash: SHA1
> >>
> >>On 11/03/2004 05:43 PM, Jens Axboe wrote:
> >>
> >>
> >>>It should work, are the permissions on your device file correct?
> >>
> >>that was the first thing I checked:
> >>
> >>gullevek@pluto:~$ ls -l /dev/scd3
> >>brw-rw----  1 root cdrom 11, 3 2004-04-30 09:28 /dev/scd3
> >>
> >>then I thought I am not in the right group:
> >>
> >>gullevek@pluto:~$ groups
> >>users disk cdrom audio operator video staff games
> >>
> >>but I am ...
> >>
> >>I haven't tried to write a CD, but DVD is definilty not possible,
> >>because the device is _not_ listed in k3b if started as user. The
> >>internal CD writer is, so probably I can write here, because before,
> >>this wasn't even listed ...
> > 
> > 
> > Try with this debug patch so we can see if it rejects command it should
> > not.
> 
> I added the patch again 2.6.9-ac6:
> 
> The strange thing is, this time I see a device, but its crippled:
> 
> k3b sees it as 7 0.62 1 /157 3474
> 
> But this device can not the DVD writer, because the dvd writer is on
> /dev/scd3, this strange device above is on /dev/scd0. But still acording
> to the settings, this device can burn dvds (Writes-DVD-R(W)s: yes).
> 
> So I tried again to start k3b as root, but this time the dvd writer
> didn't show up anymore ... Somehow I get here very confused.
> 
> this is my dmesg output when I turn on my DVD writer
> 
> drivers/usb/input/hid-input.c: event field not found
> ieee1394: Error parsing configrom for node 0-00:1023
> ieee1394: Error parsing configrom for node 0-01:1023
> ieee1394: Error parsing configrom for node 0-02:1023
> ieee1394: Error parsing configrom for node 0-03:1023
> ieee1394: The root node is not cycle master capable; selecting a new
> root node and resetting...
> ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00e03600500008f2]
> ieee1394: Node changed: 0-00:1023 -> 0-01:1023
> ieee1394: Node changed: 0-01:1023 -> 0-02:1023
> ieee1394: Node changed: 0-02:1023 -> 0-03:1023
> ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
> ieee1394: sbp2: Logged out of SBP-2 device
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
> ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
> ieee1394: sbp2: Logged out of SBP-2 device
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: Node 0-02:1023: Max speed [S400] - Max payload [2048]
> scsi3 : SCSI emulation for IEEE-1394 SBP-2 Devices
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
>   Vendor: PIONEER   Model: DVD-RW  DVR-105   Rev: 1.20
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> Attached scsi CD-ROM sr0 at scsi3, channel 0, id 0, lun 0
> Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 5

Probably talk to the firewire folks about this issue.

-- 
Jens Axboe

