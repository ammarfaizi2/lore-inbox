Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVDYTpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVDYTpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVDYTpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:45:50 -0400
Received: from mailfe09.tele2.se ([212.247.155.1]:29654 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262744AbVDYTpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:45:32 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Alexander Nyberg <alexn@dsv.su.se>
To: Greg KH <greg@kroah.com>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425190606.GA23763@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	 <20050425182951.GA23209@kroah.com>
	 <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	 <20050425185113.GC23209@kroah.com>  <20050425190606.GA23763@kroah.com>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 21:45:25 +0200
Message-Id: <1114458325.983.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well it seems that people are starting to want to hook the reboot
> notifier, or the device shutdown facility in order to properly shutdown
> pci drivers to make kexec work nicer.
> 
> So here's a patch for the PCI core that allows pci drivers to now just
> add a "shutdown" notifier function that will be called when the system
> is being shutdown.  It happens just after the reboot notifier happens,
> and it should happen in the proper device tree order, so everyone should
> be happy.
> 
> Any objections to this patch?

Not sure what you mean by "make kexec work nicer" but if it is because
some devices don't work after a kexec I have some objections.
What about the kexec-on-panic?

In the end at least every storage device should work after a
kexec-on-panic or else there might be cases where we cannot get dumps of
what happened. My guess is that having access to the network might come
in handy after a kexec-on-panic as well.

So if this patch is because some devices don't work across kexec I don't
think this is a good idea because the same devices won't work after a
kexec-on-panic.

