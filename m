Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSFQQmV>; Mon, 17 Jun 2002 12:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSFQQmU>; Mon, 17 Jun 2002 12:42:20 -0400
Received: from host194.steeleye.com ([216.33.1.194]:10771 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314811AbSFQQmS>; Mon, 17 Jun 2002 12:42:18 -0400
Message-Id: <200206171642.g5HGg5b03044@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Oliver Neukum <oliver@neukum.name>,
       David Brownell <david-b@pacbell.net>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Mon, 17 Jun 2002 09:09:58 PDT." <20020617090958.A19843@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jun 2002 11:42:05 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> I agree it would be nice to get the ID via user space, but it is not
> that hard to get the ID, and trying the various SCSI INQUIRY pages
> that supply  the ID is not complicated.

OK, how about some hardware scenarios:

I've a scsi array (an LSI 6298) which has no WWN page (0x83) but does have a 
serial number in the VPD page.  However, the VPD serial number is an 
identifier for the array *controller* and thus is the *same* for all the LUNs. 
 For this beast I have to add in the LUN number to the VPD serial number to 
get a unique identifier per device.  Worse, the LSI 6298 is multi path.  Now I 
get a different "unique" identifier depending on path (because different 
controllers give different VPD serial numbers), so if I want to identify it 
uniquely, I have to use some property of the LUN, like partion UUID.

Or, what about an old 8 bit EMC symmetrix.  They have no WWN page and they 
embed both a LUN and a *path* identifier in the VPD serial number.  To get the 
globally unique ID for this one, I have to strip off the path part.

> FYI the various SCSI ID pages and such are described in the SCSI
> primaray command for example the following:

> ftp://ftp.t10.org/t10/drafts/spc3/spc3r07.pdf 

Ah, but that's the scsi-3 spec which (finally) cleaned up this unique name 
business.  However, for SCSI-2 and before, it was an unholy mess, as the two 
examples above illustrate.  I agree that for all modern devices which are 
SCSI-3 SPC compliant, then just asking for the WWN page probably works.  The 
question is what to do about all the legacy hardware out there?

James


