Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVLTUzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVLTUzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVLTUzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:55:47 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:64351 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932103AbVLTUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:55:46 -0500
Date: Tue, 20 Dec 2005 15:55:36 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH] block: Better CDROMEJECT
In-reply-to: <1135111300.27117.41.camel@cog.beaverton.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Message-id: <1135112136.16754.31.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1135047119.8407.24.camel@leatherman>
 <20051220074652.GW3734@suse.de>
 <1135082490.16754.0.camel@localhost.localdomain>
 <20051220132821.GH3734@suse.de>
 <1135085557.16754.2.camel@localhost.localdomain>
 <20051220133939.GI3734@suse.de>
 <1135087637.16754.12.camel@localhost.localdomain>
 <1135111300.27117.41.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 12:41 -0800, john stultz wrote:
> On Tue, 2005-12-20 at 09:07 -0500, Ben Collins wrote:
> > On Tue, 2005-12-20 at 14:39 +0100, Jens Axboe wrote:
> > > > Should be an easy check to add. In fact, I'll resend both patches with
> > > > that in place if you want.
> > > 
> > > There's still the quirky problem of forcing a locked tray out. In some
> > > cases this is what you want, if things get stuck for some reason or
> > > another. But usually the tray is locked for a good reason, because there
> > > are active users of the device.
> > > 
> > > Say two processes has the cdrom open, one of them doing io (maybe even
> > > writing!), the other could do a CDROMEJECT now and force the ejection of
> > > a busy drive.
> > 
> > But that's possible now with "eject -s" as long as you have write access
> > to it. Most users are using "eject -s" anyway.
> > 
> > You can't stop this from happening. However, the fact is that a lot of
> > devices (iPod's being the most popular) require this to work.
> 
> I'm a little confused. Eject has a number of different ways it
> interfaces with the kernel (scsi, cdrom, floppy, tape), which I assume
> map to different ioctl commands. In the case I'm familiar with (my usb
> ipod, and my firewire disk), the scsi method (via eject -s) is used
> which sends a ALLOW_MEDIUM_REMOVAL.
> 
> Now I know without passing a specific method, eject will try different
> methods until one works, but it seems that the patch below is overriding
> the CDROMEJECT ioctl so that it then sends an ALLOW_MEDIUM_REMOVAL as
> well as the normal GPCMD_START_STOP_UNIT.

These are MMC commands, not specific to the bus it is sitting on (be it
scsi, IDE, USB, or firewire).

The "scsi" method in eject has been using pretty much the same code path
in the kernel as CDROMEJECT for some time (probably since Linus did the
whole SG_IO thing to make burning to IDE devices without ide-scsi
possible).

In fact, one user affected by the bug I was trying to fix had an IDE
CDROM drive that would only eject with "eject -s". The "eject -s" being
"Scsi Eject" in the eject program is a misnomer really.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

