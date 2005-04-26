Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVDZQLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVDZQLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVDZQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:11:19 -0400
Received: from colo.lackof.org ([198.49.126.79]:50139 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261643AbVDZQKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:10:36 -0400
Date: Tue, 26 Apr 2005 10:12:59 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426161259.GC2612@colo.lackof.org>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz> <20050425205536.GF27771@neo.rr.com> <20050425210631.GE3906@elf.ucw.cz> <1114489812.7111.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114489812.7111.42.camel@gaston>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 02:30:12PM +1000, Benjamin Herrenschmidt wrote:
> Additionally, some machines won't properly park/flush the disk, it's
> necessary to send the proper suspend commands to IDE hard disks prior to
> shutting down or we risk data loss.

That sounds like the disk is caching write data.

SCSI has a "Write Cache Enable" bit in the "caching mode page".
See "scsiinfo -c" output.

10 years ago I measured/compared performance of disabling WCE
(plus queue depth of 8) and enabling WCE (queue depth 1).
It's a wash for the workloads I was testing. I was told "stupid OSs"
that didn't know about tagged queueing needed WCE for benchmarks.
HP cared for exactly the same reasons: Bus Resets or Disk power failure
would cause data loss with WCE enabled.

Disabling WCE on current OSs would solve the above problem
IFF IDE/SATA also supports "cache mode" page.

grant
