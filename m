Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVHQNzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVHQNzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 09:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVHQNzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 09:55:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:4253 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751050AbVHQNzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 09:55:41 -0400
Date: Wed, 17 Aug 2005 09:55:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: dtor_core@ameritech.net
cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
In-Reply-To: <d120d5000508161534451ebd7a@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0508170945580.4862-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, Dmitry Torokhov wrote:

> Alan,
> 
> I am sorry I don't have time to properly review the patch at
> themoment, just a couple of comments about serio - I would not look at
> serio for examples of typical use as it was trying very hard to work
> around the original driver model limitation that prevented drivers to
> register childern on the same bus from their probe function. I think
> now that that limitation is lifted serio implemenation can be
> simplified.

Okay.  The same comments may apply to the other users of
device_bind_driver.  Apart from a couple in the USB stack that I can
handle already, those users are:

	drivers/pnp/card.c
	drivers/input/serio/serio.c
	drivers/input/gameport/gameport.c

Presumably the gameport code is very similar to the serio code.  
Interestingly, callers of device_release_driver include:

	drivers/pnp/card.c
	drivers/input/serio/serio.c
	drivers/input/gameport/gameport.c
	drivers/ide/ide-proc.c
	drivers/ieee1394/nodemgr.c

It's not obvious (to me) why ide-proc.c and nodemgr.c call one but not the 
other.

Anyway, I appreciate you taking the time to comment on this work.  When 
you've had a chance to read through that patch, let me know what you 
think.

Alan Stern

