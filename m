Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUA1Cxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUA1Cxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:53:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:10 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265810AbUA1Cxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:53:46 -0500
Date: Wed, 28 Jan 2004 03:53:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <20040128021719.GV21151@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401280336120.7851@serv>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
 <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <Pine.LNX.4.58.0401261435160.7855@serv>
 <20040127202944.GE27240@kroah.com> <Pine.LNX.4.58.0401280252120.7851@serv>
 <20040128021719.GV21151@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> > Recovery of the scsi core is IMO one the smallest problems, but how do you
> > recover at the block layer? The point is that you have here theoretically
> > more one recovery strategy, but simply pulling out the module leaves you
> > not much room for a controlled recovery.
>
> Block layer is not too big issue.  We have almost everything in the tree
> already - the main problem is to get check_disk_change() use regularized.
> Now, sound and character devices in general...

Hmm, I more meant "user controlled recovery", the simplest strategy is of
course to throw everything away and that should be indeed not too
difficult, but I don't really think that this is user prefered strategy if
he accidentally unplugs/plugs a device. OTOH that the simple strategy
works reliably is of course a prerequisite to even think about an any more
advanced recovery.
But with the current module infrastructure the user has not much choice
anyway, without any indication of module usage state the user can only
guess what will happen when he tries to unload a module, so that currently
the best advice is indeed: don't do it.

bye, Roman
