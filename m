Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVCAWaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVCAWaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVCAWaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:30:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:62658 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262094AbVCAW3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:29:52 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20050301183333.GB1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
	 <200503010910.29460.jbarnes@engr.sgi.com>
	 <20050301183333.GB1220@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:27:27 +1100
Message-Id: <1109716047.5679.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 12:33 -0600, Linas Vepstas wrote:

> The current proposal (and prototype) has a "master recovery thread"
> to handle the coordinated reset of the pci controller.  This master
> recovery thyread makes three calls in struct pci_driver:
> 
>    void (*frozen) (struct pci_dev *);  /* called when dev is first frozen */
>    void (*thawed) (struct pci_dev *);  /* called after card is reset */
>    void (*perm_failure) (struct pci_dev *);  /* called if card is dead */

See my other emails. I think only one callback is enough, and I think we
need more parameters.

> The master recovery thread runs in the kernel.  Earlier suggestions said
> "run it in user space, use pci hotplug, use udev, etc." However, if
> you get a pci error on a scsi card, you can't shell script 
> "umount /dev/sdX; rmmod scsi; clear_pci_error; insmod scsi; mount /dev/sdX"
> beacuse you can't umount an open filesystem, and you can't really close
> it (I fiddled with prototyping some of this, but its ugly and painful
> and bizarre and outside my area of expertise :)
> 
> FWIW, the current prototype tries to do a pci hotplug if the above
> routines aren't implemented in struct pci_driver.  It can recover 
> from pci errors on ethernet cards, and I have one scsi driver that
> successfully recovers with above API, and am working on adding recovery
> to the symbios driver.
> 
> --linas
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

