Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbUBXRwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUBXRv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:51:56 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:59774 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262330AbUBXRvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:51:44 -0500
Date: Tue, 24 Feb 2004 19:51:42 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, kai.makisara@kolumbus.fi
Subject: Re: [BK PATCH] SCSI update for 2.6.3
In-Reply-To: <20040224171629.GA31369@kroah.com>
Message-ID: <Pine.LNX.4.58.0402241937450.3713@kai.makisara.local>
References: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi>
 <20040224170412.GA31268@kroah.com> <1077642529.1804.170.camel@mulgrave>
 <20040224171629.GA31369@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Greg KH wrote:

> On Tue, Feb 24, 2004 at 11:08:48AM -0600, James Bottomley wrote:
> > On Tue, 2004-02-24 at 11:04, Greg KH wrote:
> > > Can you post it here so we can review it?
> > > 
> > > And yes, using class_simple should relieve you of Al flamage :)
> > 
> > The one in the tree is attached.  I did verify it myself, and tried it
> > out on some old QIC tapes I had lying around.
> 
> Can you print out the sysfs tree this patch creates?
> 
Here is a partial tree for the first tree (nearly identical entries from 
the middle trimmed):

/sys/class/scsi_tape/
|-- st0m0
|   |-- default_blksize
|   |-- default_compression
|   |-- default_density
|   |-- defined
|   |-- dev
|   |-- device -> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:01.1/host1/1:0:5:0
|   `-- driver -> ../../../bus/scsi/drivers/st
|-- st0m0n
|   |-- default_blksize
|   |-- default_compression
|   |-- default_density
|   |-- defined
|   |-- dev
|   |-- device -> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:01.1/host1/1:0:5:0
|   `-- driver -> ../../../bus/scsi/drivers/st
.
.
.
`-- st0m3n
    |-- default_blksize
    |-- default_compression
    |-- default_density
    |-- defined
    |-- dev
    |-- device -> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:01.1/host1/1:0:5:0
    `-- driver -> ../../../bus/scsi/drivers/st

> What's that "tape" symlink for?  Does it go from the scsi device in
> /sys/devices/... to the class device?  Or the other way around?
> 

The link is from the SCSI device to one of the scsi_tape directories:

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.1/host1/1:0:5:0
|-- delete
|-- detach_state
|-- device_blocked
|-- generic -> ../../../../../../class/scsi_generic/sg1
|-- model
|-- online
|-- power
|   `-- state
|-- queue_depth
|-- rescan
|-- rev
|-- scsi_level
|-- tape -> ../../../../../../class/scsi_tape/st0m0
|-- type
`-- vendor

The idea is to be able to follow the links from a generic scsi device to 
the tape device. The link 'generic' created by sg enables associating a 
tape with the corresponding sg device.

> Other than that question, the patch looks sane to me.
> 
Thanks for the review.

-- 
Kai
