Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSFQFUO>; Mon, 17 Jun 2002 01:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSFQFUO>; Mon, 17 Jun 2002 01:20:14 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:43239 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316721AbSFQFUM> convert rfc822-to-8bit; Mon, 17 Jun 2002 01:20:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map
Date: Mon, 17 Jun 2002 07:19:52 +0200
User-Agent: KMail/1.4.1
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       David Brownell <david-b@pacbell.net>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
References: <200206162314.g5GNEYf03058@localhost.localdomain>
In-Reply-To: <200206162314.g5GNEYf03058@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206170719.52136.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. Juni 2002 01:14 schrieb James Bottomley:
> oliver@neukum.name said:
> > But the drivers already know, or would have to be taught to know about
> > it. Somewhence that information has to come. You cannot avoid that
> > effort.
>
> Not necessarily: consider the SCSI WWN, which is supported by most
> modern SCSI devices.  The driver never probes for or asks for this. 
> Nowhere in the current SCSI code do we ask for this.  However user level
> commands (like sg_inq) can formulate the 0x83 page inquiry to get this
> and return the output. This works today with the current driver.

These may be an exception. You usually want to get drivers involved
even if only for synchronisation. Failing to do so has already let to
problems with usb storage.

> > That is wrong. You'd need a common method to determine device type and
> > several methods of passing guid. You are better off in implementing
> > one common way of getting at that information, which shouldn't be too
> > hard, as all the generic layer would have to do is pass up that
> > information.
>
> but the complexity is in the "common method to determine device type and
> several methods of passing guid".  Even for a simple SCSI disk, there's
> no one universal way of getting a unique id (let alone when we add the
> usb devices masquerading as scsi disks into the mix).  That will lead us

That is the point. The driver knows best what kind of devices it works on.
You can forget about the whole identification method business, if you
go for the driver. In case of usb storage and firewire that data is already
sitting there ready for taking. I suspect the same for fibrechannel.

	Regards
		Oliver

