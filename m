Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUA1CRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUA1CRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:17:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21437 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265334AbUA1CRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:17:22 -0500
Date: Wed, 28 Jan 2004 02:17:19 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040128021719.GV21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <Pine.LNX.4.58.0401261435160.7855@serv> <20040127202944.GE27240@kroah.com> <Pine.LNX.4.58.0401280252120.7851@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401280252120.7851@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 03:03:31AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Tue, 27 Jan 2004, Greg KH wrote:
> 
> > > All this is done without a module count, this means that
> > > pci_unregister_driver() cannot return before the last reference is gone.
> > > For network devices this is not that much of a problem, as they can be
> > > rather easily deconfigured automatically, but that's not that easy for
> > > mounted block devices, so one has to be damned careful when to call the
> > > exit function.
> >
> > Um, not anymore.  I can yank out a mounted block device and watch the
> > scsi core recover just fine.  The need to make everything hotpluggable
> > has fixed up a lot of issues like this (as well as made more
> > problems...)
> 
> Recovery of the scsi core is IMO one the smallest problems, but how do you
> recover at the block layer? The point is that you have here theoretically
> more one recovery strategy, but simply pulling out the module leaves you
> not much room for a controlled recovery.

Block layer is not too big issue.  We have almost everything in the tree
already - the main problem is to get check_disk_change() use regularized.
Now, sound and character devices in general...
