Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWBRJmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWBRJmb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 04:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWBRJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 04:42:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751096AbWBRJma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 04:42:30 -0500
Date: Sat, 18 Feb 2006 01:41:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Kaindl <bk@suse.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PCI/Cardbus cards hidden, needs pci=assign-busses to
 fix
Message-Id: <20060218014102.0647c0ce.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602162054020.13089@jbgna.fhfr.qr>
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
	<1136555288.30498.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0602162054020.13089@jbgna.fhfr.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Kaindl <bk@suse.de> wrote:
>
> "In some cases, especially on modern laptops with a lot of PCI and cardbus
>  bridges, we're unable to assign correct secondary/subordinate bus numbers
>  to all cardbus bridges due to BIOS limitations unless we are using
>  "pci=assign-busses" boot option." -- Ivan Kokshaysky (from a patch comment)
> 
>  Without it, Cardbus cards inserted are never seen by PCI because the
>  parent PCI-PCI Bridge of the Cardbus bridge will not pass and translate
>  Type 1 PCI configuration cycles correctly and the system will fail to
>  find and initialise the PCI devices in the system.
> 
>  Reference: PCI-PCI Bridges: PCI Configuration Cycles and PCI Bus Numbering:
>  http://www.science.unitn.it/~fiorella/guidelinux/tlk/node72.html
> 
>  The reason for this is that:
>   ``All PCI busses located behind a PCI-PCI bridge must reside between the
>  secondary bus number and the subordinate bus number (inclusive).''
> 
>  "pci=assign-busses" makes pcibios_assign_all_busses return 1 and this
>  turns on PCI renumbering during PCI probing.
> 
>  Alan suggested to use DMI to make that function cause that on problem systems:
>
> [ snip patch which uses a DMI table to auto-set "pci=assign-busses" ]
>

I guess if this is the only way in which we can do this, and nobody has any
better solutions then sure, it'll get people's machines going.  We'll be
forever patching that table though.

But _does_ anyone have any better solutions?


(Minor squawks: please avoid the running-dialogue-mixed-up-with-patch-segments,
please prepare patches in `patch -p1' form and please send me a Signed-off-by:
for this work, as per section 11 of Documentation/SubmittingPatches, thanks).
