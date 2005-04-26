Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVDZEcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVDZEcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDZEcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:32:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:54470 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261339AbVDZEbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:31:32 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425210631.GE3906@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	 <20050425182951.GA23209@kroah.com>
	 <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	 <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
	 <20050425204207.GA23724@elf.ucw.cz> <20050425205536.GF27771@neo.rr.com>
	 <20050425210631.GE3906@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 14:30:12 +1000
Message-Id: <1114489812.7111.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So if I understand this correctly, you'd like to manually turn off devices
> > during a power off.  I believe the ACPI spec recommends this for S4 (but also
> > to leave on wake devices), but not necessarily S5.  Still it may be a good
> > idea.  Comments?
> 
> It is neccessary for some machines (interrupt controller) or machine
> will not power down...

Additionally, some machines won't properly park/flush the disk, it's
necessary to send the proper suspend commands to IDE hard disks prior to
shutting down or we risk data loss.

> > > Actually this patch should be in the queue somewhere... We had it in
> > > suse trees for a long time, and IMO it can solve problem easily.
> > 
> > Yeah, that's what I had in mind when I mentioned PMSG_FREEZE.  It seems
> > to replace "shutdown" in many ways, is this correct?
> 
> Yes. (Actually I'm not sure if PMSG_FREEZE or PMSG_SUSPEND is right
> thing to do for suspend.)


I think FREEZE for kexec and SUSPEND for shutdown, though I suppose we
may want a separate one for the later eventually...

Ben.


