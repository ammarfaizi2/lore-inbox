Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSFPRZU>; Sun, 16 Jun 2002 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFPRZT>; Sun, 16 Jun 2002 13:25:19 -0400
Received: from host194.steeleye.com ([216.33.1.194]:16903 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316446AbSFPRZS>; Sun, 16 Jun 2002 13:25:18 -0400
Message-Id: <200206161725.g5GHP6S23020@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: Andries.Brouwer@cwi.nl, garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Sun, 16 Jun 2002 10:05:49 PDT." <3D0CC56D.9050805@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Jun 2002 12:25:06 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already have a huge long list of different ways to identify different 
devices, I don't think coding any one or even a set of such methods into the 
kernel would satisfy everyone.

What about a different approach:

We already (nearly) have the scsimon patches to do hot plug events on SCSI 
devices incorporated.  Any identification could be done from the scsi device 
hotplug script (i.e. if you see it's USB, get the GID, if it's enterprise 
storage get the WWN, try the filesystem UUID etc).  Then all the hotplug 
script does is plug this device into some type of volume idenfication scheme 
like /dev/volume/<name>.

Any application needing to always know where the device is would refer to it 
by name, and since there's no prescription at all about what the <name> is, 
you could even alias horribly unfriendly things like the WWN to more palatable 
names using a user specified translation table.

This implementation doesn't even depend on SCSI, so it could potentially be 
used by any subsystem (IDE, block devices).

The only component that doesn't exist is the configurable /dev/volume piece.  
Since the name would be a property of the device node, it probably makes sense 
to place this into the new driverfs somehow.

James


