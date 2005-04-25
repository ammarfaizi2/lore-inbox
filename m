Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVDYT1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVDYT1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDYT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:27:38 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:14263 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S262775AbVDYTXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:23:22 -0400
Message-ID: <426D439D.6080705@pobox.com>
Date: Mon, 25 Apr 2005 15:23:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
In-Reply-To: <20050425190606.GA23763@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
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

Traditionally the proper place -has- been
* the reboot notifier
* the ->remove hook (hot unplug, and module remove)

which covers all the cases.

Add a ->shutdown hook is more of a hack.  If you want to introduce this 
facility in a systematic way, introduce a 'kexec reboot' option which 
walks the device tree and shuts down hardware.

->shutdown is just a piecemeal, uncoordinated effort (uncoordinated in 
the sense that driver shutdowns occur in an undefined order).

	Jeff



