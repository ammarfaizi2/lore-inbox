Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTJIOEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbTJIOEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:04:37 -0400
Received: from users.linvision.com ([62.58.92.114]:12509 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262127AbTJIOEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:04:32 -0400
Date: Thu, 9 Oct 2003 16:04:30 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Xose Vazquez Perez <xose@wanadoo.es>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
Message-ID: <20031009140430.GI11525@bitwizard.nl>
References: <3F84AF3C.9050408@wanadoo.es> <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet> <20031009122428.GF11525@bitwizard.nl> <20031009123857.GC27861@parcelfarce.linux.theplanet.co.uk> <20031009131152.GG11525@bitwizard.nl> <20031009132141.GF27861@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009132141.GF27861@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 02:21:41PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 09, 2003 at 03:11:52PM +0200, Erik Mouw wrote:
> > Yes it is. The _2 driver supports newer hardware (or better: can do
> > faster speeds on newer hardware), while the old driver doesn't. The old
> > driver, however, is more reliable in case of hardware errors. It's very
> > nice to be able to change drivers on the fly without having to figure
> > out the full path to the correct module.
> 
> No, that's not the point.  For people who are already using either driver,
> there's no need to change anything between 2.4 and 2.6.  It's only the
> foolish people who compile both as modules that have a problem.

It's not foolish to compile both modules. The 53c895 works faster with
the sym538cxxx_2 driver, the 53c810 can do with the sym53cxxx driver.
For otherwise the same machines, it's nice to compile a single kernel
for all of them and have the sym58cxxx drivers as modules, so you can
specify in modules.conf which driver to use. (also think about fully
modular distribution kernels).

> If you change the sym2 driver to have a different module name, now people
> have to change when they switch between 2.4 and 2.6.  That's bad.

Upgrading major kernel versions usually breaks things. That has never
been a problem in the past, so I don't see why it should be one in this
particular case. There were other modules with completely different
names, like usb-uhci --> uhci-hcd.

> We've had this problem all through 2.4 and it's never been an issue
> until now.  I really think this is one problem which shouldn't be fixed.

It hasn't been an issue until now simply because nobody has actually
seen it going wrong. If you load sym53cxxx, you get the old driver, and
hey, it works well with all sym53cxxx SCSI cards. The old driver simply
masks the new driver and I think the new driver didn't get as much
real-life testing as it should have had.

Selecting everything as a module never was a problem in Linux, you can
load any driver just by name. The sym53cxxx is an exception to this:
the old driver masks the new one. It's a namespace collision. That's
bad and it should be fixed.

> > I haven't figured out what it could be yet, scsiinfo works perfectly
> > well with the old sym58xxx driver (and the aic7xxx driver, FWIW).
> 
> It works perfectly fine with the drives I have access to under 2.6 ...

I know (I think you even told me). The fact that I only recently
figured out about this bug proves my point: in linux-2.4 the sym53cxx_2
driver didn't get as much testing as it should have had. Apply my
patch, and the driver might even get real use.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
