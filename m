Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWHIRJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWHIRJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWHIRJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:09:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34994 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751271AbWHIRJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:09:52 -0400
Subject: Merging libata PATA support into the base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 18:29:59 +0100
Message-Id: <1155144599.5729.226.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff (rightly) thinks the plan should be discussed publically, so here
is the plan

For 2.6.19 to move the libata drivers to drivers/ata
Add a subset of the new PATA drivers living in -mm to the base kernel

Many of the new libata drivers are already more stable and functional
than the drivers/ide ones. 


What does this mean for end users selecting the existing IDE layer
- Zilch, Nada, Nothing
- No changes in behaviour, no different code paths

For the more adventurous
- Better SATA/PATA integration
- Support for some chipsets not supported by drivers/ide
	(jmicron, newer VIA, mpiix, netcell, efar, etc)
- Active maintainance and updates
- Better quality drivers and error handling
- Inevitably more interesting bugs to find and help fix
- A chance to knock out any bugs and assumptions with other platforms

The new libata PATA support has some caveats at the moment
- No support for certain old serialized devices
- No support for prehistoric CMD640 controllers
- No support for host-protected-area yet
- Drives appear as /dev/sda /dev/sr0 etc along with the libata SATA
devices (and since you can't tell SATA from PATA at times its hard to
avoid). That means people with some older distros wanting to try it
might need to change their fstab or rootdev. People not trying it won't
be affected.

At this point in time it is premature to discuss or plan the point at
which the old IDE layer would go away. That discussion can start at the
point where everyone is happy that the new libata based layer is
providing better quality and coverage than the old one. Even then there
would be no need to hurry.

Alan

