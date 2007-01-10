Return-Path: <linux-kernel-owner+w=401wt.eu-S965038AbXAJTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbXAJTym (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXAJTym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 14:54:42 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:57703 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbXAJTyl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 14:54:41 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
Date: Wed, 10 Jan 2007 20:54:56 +0100
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0701101230390.3289-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701101230390.3289-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701102054.57303.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2007 18:31 schrieb Alan Stern:
> > Regarding the bug this device uncovers, it seems to me that this in drivers/base/core.c
> >       if (parent)
> >               klist_add_tail(&dev->knode_parent, &parent->klist_children);
> > should make knode_parent a valid node under all circumstances.
> > Hm.
> 
> I haven't seen the original bug report.  Where does the NULL pointer deref 
> occur?

Apparently here: drivers/base/core.c:

void device_del(struct device * dev)
{
	struct device * parent = dev->parent;
	struct class_interface *class_intf;

	if (parent)
		klist_del(&dev->knode_parent);

The obvious change with this device is that usb_set_configuration() is never
called, but that should not matter.

	Regards
		Oliver
