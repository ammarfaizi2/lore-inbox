Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVDZKNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDZKNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDZKNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:13:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58250 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261465AbVDZKLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:11:50 -0400
Date: Tue, 26 Apr 2005 12:11:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426101112.GE1824@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz> <20050425210014.GA25247@kroah.com> <1114486915.7112.17.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114486915.7112.17.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Actually this patch should be in the queue somewhere... We had it in
> > > suse trees for a long time, and IMO it can solve problem easily.
> > > 
> > > 								Pavel
> > > 
> > > --- clean-git/kernel/sys.c	2005-04-23 23:21:55.000000000 +0200
> > > +++ linux/kernel/sys.c	2005-04-24 00:20:47.000000000 +0200
> > > @@ -404,6 +404,7 @@
> > >  	case LINUX_REBOOT_CMD_HALT:
> > >  		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
> > >  		system_state = SYSTEM_HALT;
> > > +		device_suspend(PMSG_SUSPEND);
> > >  		device_shutdown();
> > 
> > Again, why keep device_shutdown() around at all then?
> 
> I've argued for folding shutdown and suspend for some time now, though
> some drivers who rely on shutdown today will need fixing I suppose.
> 
> Also, I think kexec shouldn't use "shutdown" but a different message.
> There are some conceptual differences, things like stopping the platters
> on disk etc... things you want to do on one and not the other. In a way,
> kexec needs are very similar to suspend-to-disk "freeze" state. I'd
> rather call PMSG_FREEZE there.

Agreed. If hardware is going to be physically powered down, we need
PMSG_SUSPEND. If it is not (kexec), PMSG_FREEZE should be enough.

Now, if we want separate PMSG_SHUTDOWN. ... I think it is similar
enough to PMSG_SUSPEND that we can keep them same "major" value and
just use different flags. I do not think many drivers will
care.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
