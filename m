Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135978AbRD0FZW>; Fri, 27 Apr 2001 01:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135979AbRD0FZM>; Fri, 27 Apr 2001 01:25:12 -0400
Received: from geos.coastside.net ([207.213.212.4]:1483 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135978AbRD0FZA>; Fri, 27 Apr 2001 01:25:00 -0400
Mime-Version: 1.0
Message-Id: <p05100303b70eadd613b0@[207.213.214.37]>
In-Reply-To: <200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
 <200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
 <p05100313b70bb73ce962@[207.213.214.37]>
 <200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca>
Date: Thu, 26 Apr 2001 22:24:52 -0700
To: Richard Gooch <rgooch@ras.ucalgary.ca>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:31 PM -0600 2001-04-26, Richard Gooch wrote:
>BTW: please fix your mailer to do linewrap at 72 characters. Your
>lines are hundreds of characters long, and that's hard to read.

Sorry for the inconvenience. There are a lot of reasons why I believe 
it's properly a display function to wrap long lines, and that an MUA 
has no business altering outgoing messages (one on-topic reason being 
that patches get screwed up by inserted newlines), but I grant that 
there are broken clients out there that can't or won't or don't wrap 
at display time.

On the subject of the Subject, Jeff Garzik recently (21 March) 
suggested adding geographic information to the ethtool interface, 
pci_dev->slot_name in the case of a PCI-based interface. There's 
something to be said for having a uniform method of identifying the 
location of devices, or at least a uniform parsable format. (A 
potential shortcoming of Jeff's scheme, perhaps, is that it needs to 
identify the slot_name as a PCI slot_name, though I could be missing 
something there.)

Consider, instead of /dev/bus/pci0/dev1/fcn0/bus0/tgt1/lun2/part3 
something like

/dev/bus/pci0d1f0/scsi0t1l2p3
or
/dev/bus/pci0:d1:f0/scsi0:t1:l2:p3

Are there systems with more than one PCI bus numbering domain? I 
don't see why not, in principle (not an issue for SCSI, which doesn't 
have bus numbering). So perhaps:

/dev/bus/pci0:b0:d1:f0/scsi0:t1:l2:p3

which distinguishes between PCI domains and PCI bus numbers.

At 10:31 PM -0600 2001-04-26, Richard Gooch wrote:
>Sure. I haven't made a decision on the names yet. I was just sketching
>out the idea.

It's a good idea. Just feedback on the initial sketch.

A related idea would be the ability to translate from a logical PCI 
slot number, as above, and a physically meaningful description that 
the user could use to identify an actual slot. Unfortunately the 
proper place for such a translation function is in the 
(hardware-specific) BIOS.
-- 
/Jonathan Lundell.
