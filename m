Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWCJRL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCJRL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWCJRL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:11:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55220 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751945AbWCJRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:11:58 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Doug Thompson <dthompson@lnxi.com>
Cc: tim@buttersideup.com, greg@kroah.com,
       bluesmoke-devel@lists.sourceforge.net, dsp@llnl.gov,
       linux-kernel@vger.kernel.org
In-Reply-To: <44114D5702000036000014DE@zoot.lnxi.com>
References: <44114D5702000036000014DE@zoot.lnxi.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 18:11:51 +0100
Message-Id: <1142010711.2876.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > and maybe even something as funky as firmware version.
> > So it for sure is a per device (not per ID) property, and something that
> > needs a global quirk table kind of thing with the option to do per
> > driver overrides
> 
> Very definitely, this non-conforming misfeature of PCI compliance is a
> per PCI device attribute. At the very least it is tied to VENDOR:DEVICE
> tuple, and probably a subsystem vendor/device tuple as well. As to
> firmware, that is also likely. Mellanox promised a new firmware update
> to their board that supposely fixes this issue. Yet, I find no firmware
> value in the PCI spec, just the Revision ID, which could be used as
> firmware identifier. THis is up to the vendor.

exactly. So this is why a device driver needs to be able to override.
Eg for such device turn it off with a global quirk, and then let the
driver say "eh it's ok for THIS case"


> So in order to be sure I understand, if this PARITY Non-Conformance
> attribute was "moved" to the per device directory of sysfs
> (/sys/devices/pci0000:00/0000:00:06.0 for an example), then we would
> need a userland attribute file created here and then stored in the
> 'pci_dev' structure 

yes. Well to some degree I'm not even sure it needs to be exposed to
userland like this. At least normally the kernel should know this
internally and automatically. (after all the kernel has the job to
abstract the hardware for the rest of the system; dealing with broken
hardware is part of that)


> or the mentioned quirk structure. This field then
> could be set by userland script(s), then EDAC-PCI could example that
> data in its iteration of pci devices.  Is that correct?

that sounds way way way too complex. If this is "just" a field in the
pci device... why would userland need to get involved? Your kernel side
should be able to see that directly just fine.



> If the above is correct, then who would we need to contact for said
> modification or approval for such? Is that you Greg KH, since you are
> listed as the PCI SUBSYSTEM maintainer?

Greg needs to OK the addition to the pci struct, but I don't forsee a
problem personally since this is a more or less obvious and logical
thing to add, and useful for more than one architecture


