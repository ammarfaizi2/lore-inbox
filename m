Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSFPXOw>; Sun, 16 Jun 2002 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSFPXOq>; Sun, 16 Jun 2002 19:14:46 -0400
Received: from host194.steeleye.com ([216.33.1.194]:65289 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316614AbSFPXOo>; Sun, 16 Jun 2002 19:14:44 -0400
Message-Id: <200206162314.g5GNEYf03058@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Oliver Neukum <oliver@neukum.name>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       David Brownell <david-b@pacbell.net>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map 
In-Reply-To: Message from Oliver Neukum <oliver@neukum.name> 
   of "Mon, 17 Jun 2002 00:38:51 +0200." <200206170038.51403.oliver@neukum.name> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Jun 2002 18:14:33 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oliver@neukum.name said:
> But the drivers already know, or would have to be taught to know about
> it. Somewhence that information has to come. You cannot avoid that
> effort. 

Not necessarily: consider the SCSI WWN, which is supported by most modern SCSI 
devices.  The driver never probes for or asks for this.  Nowhere in the 
current SCSI code do we ask for this.  However user level commands (like 
sg_inq) can formulate the 0x83 page inquiry to get this and return the output. 
 This works today with the current driver.

> That is wrong. You'd need a common method to determine device type and
> several methods of passing guid. You are better off in implementing
> one common way of getting at that information, which shouldn't be too
> hard, as all the generic layer would have to do is pass up that
> information. 

but the complexity is in the "common method to determine device type and 
several methods of passing guid".  Even for a simple SCSI disk, there's no one 
universal way of getting a unique id (let alone when we add the usb devices 
masquerading as scsi disks into the mix).  That will lead us to scanning a 
list of inquiry strings to see what the disk is and determine what globally 
unique ID it supports.  Since we have to implement a lookup table just to 
determine how to get the unqiue id, it's far better off being done outside the 
kernel.

James



