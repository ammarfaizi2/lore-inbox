Return-Path: <linux-kernel-owner+w=401wt.eu-S965143AbXAJWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbXAJWfY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbXAJWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:35:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45082 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965143AbXAJWfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:35:23 -0500
Date: Wed, 10 Jan 2007 17:35:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
In-Reply-To: <200701102054.57303.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007, Oliver Neukum wrote:

> Am Mittwoch, 10. Januar 2007 18:31 schrieb Alan Stern:
> > > Regarding the bug this device uncovers, it seems to me that this in drivers/base/core.c
> > >       if (parent)
> > >               klist_add_tail(&dev->knode_parent, &parent->klist_children);
> > > should make knode_parent a valid node under all circumstances.
> > > Hm.
> > 
> > I haven't seen the original bug report.  Where does the NULL pointer deref 
> > occur?
> 
> Apparently here: drivers/base/core.c:
> 
> void device_del(struct device * dev)
> {
> 	struct device * parent = dev->parent;
> 	struct class_interface *class_intf;
> 
> 	if (parent)
> 		klist_del(&dev->knode_parent);
> 
> The obvious change with this device is that usb_set_configuration() is never
> called, but that should not matter.

No, I think you're barking up the wrong tree.

Pavel, did you have CONFIG_USB_MULTITHREAD_PROBE turned on?  I bet you did 
-- there's no other way to generate the messages in your syslog.

Don't use that kconfig option.  It's broken (as you saw) and needs to be
either removed or replaced.

Alan Stern

