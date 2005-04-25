Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVDYVOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDYVOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVDYVNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:13:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8850 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261200AbVDYVKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:10:43 -0400
Date: Mon, 25 Apr 2005 23:06:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425210631.GE3906@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz> <20050425205536.GF27771@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425205536.GF27771@neo.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well it seems that people are starting to want to hook the reboot
> > > notifier, or the device shutdown facility in order to properly shutdown
> > > pci drivers to make kexec work nicer.
> > > 
> > > So here's a patch for the PCI core that allows pci drivers to now just
> > > add a "shutdown" notifier function that will be called when the system
> > > is being shutdown.  It happens just after the reboot notifier happens,
> > > and it should happen in the proper device tree order, so everyone should
> > > be happy.
> > > 
> > > Any objections to this patch?
> > 
> > Yes.
> > 
> > I believe it should just do suspend(PMSG_SUSPEND) before system
> > shutdown. If you think distintion between shutdown and suspend is
> > important (I am not 100% convinced it is), we can just add flag
> > saying "this is system shutdown".
> 
> So if I understand this correctly, you'd like to manually turn off devices
> during a power off.  I believe the ACPI spec recommends this for S4 (but also
> to leave on wake devices), but not necessarily S5.  Still it may be a good
> idea.  Comments?

It is neccessary for some machines (interrupt controller) or machine
will not power down...

> > Actually this patch should be in the queue somewhere... We had it in
> > suse trees for a long time, and IMO it can solve problem easily.
> 
> Yeah, that's what I had in mind when I mentioned PMSG_FREEZE.  It seems
> to replace "shutdown" in many ways, is this correct?

Yes. (Actually I'm not sure if PMSG_FREEZE or PMSG_SUSPEND is right
thing to do for suspend.)
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
