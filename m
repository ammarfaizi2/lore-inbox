Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVBVG6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVBVG6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBVG6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:58:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:22231 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262225AbVBVG6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:58:33 -0500
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <9e47339105022122526338b2c9@mail.gmail.com>
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
	 <1109049217.5412.79.camel@gaston>
	 <9e4733910502212203671eec73@mail.gmail.com>
	 <1109053960.5326.91.camel@gaston>
	 <9e47339105022122526338b2c9@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 17:57:46 +1100
Message-Id: <1109055466.5326.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 01:52 -0500, Jon Smirl wrote:
> Does the kernel need to keep a bit that says the device has been
> posted, don't do it again?

No. The kernel have no idea about what POSTing means in fact. That is
also driver specific.

> Should removing/inserting a driver cause a repost?

The driver should be able to determine that looking at the state of the
device. Things like vgacon may need some massaging, but that is not
something we need to care too much about :)

> I was going to add bit in pci_dev that tracks the reset status
> so that it will persist across unloads. Do we have code to tell if
> hardware needs a reset without the tracking bit?

That doesn't have room in pci_dev, that only concerns a minority of HW
and I don't think we need to track it accross load/unload.

> On the x86 DRM will run without fbdev loaded. So DRM needs to also be
> able to do the post and well as fbdev. Or we can just leave the old
> drivers alone and only implement this in a merged fbdev/drm driver?

I think we need _at_least_ to make a common "stub" driver for fbdev/drm,
and if possible, only implement that in the merged driver when that
happens. We are talking about the future here. Existing users already
have X happily POST'ing their cards.

> When current X loads it's going to reset the cards again, that may
> stomp anything the driver has set up.

Yes, and X need to be fixed for that, this is _WRONG_, one of the
numerous x86-centric assumptions in X. Note that the fbdev driver is
currently aware that anything can happen to the card when in KD_GRAPHICS
mode (and thus, the driver loses ownership). I restore as much as I need
hopefully when coming back. So we may end up having a non-issue there.
Once we have an Xgl on top of mesa solo, the problem will not happen.

Ben.




