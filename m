Return-Path: <linux-kernel-owner+w=401wt.eu-S964955AbXAJRAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbXAJRAu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbXAJRAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:00:50 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:36874 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964955AbXAJRAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:00:50 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
Date: Wed, 10 Jan 2007 18:01:04 +0100
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0701101112210.3289-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701101112210.3289-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701101801.04525.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2007 17:14 schrieb Alan Stern:
> On Wed, 10 Jan 2007, Oliver Neukum wrote:
> 
> > Am Mittwoch, 10. Januar 2007 11:49 schrieb Pavel Machek:
> > > usb 2-1: new full speed USB device using uhci_hcd and address 68
> > > usb 2-1: USB disconnect, address 68
> > > usb 2-1: unable to read config index 0 descriptor/start
> > > usb 2-1: chopping to 0 config(s)
> > 
> > Does anybody know a legitimate reasons a device should have
> > 0 configurations? Independent of the reason of this bug, should we disallow
> > such devices and error out?
> 
> About the only reason to allow such devices is so that the user can run 
> lsusb to try and get more information about the problem.  With no 
> configurations, the device won't be useful for anything.

Regarding the bug this device uncovers, it seems to me that this in drivers/base/core.c
	if (parent)
		klist_add_tail(&dev->knode_parent, &parent->klist_children);
should make knode_parent a valid node under all circumstances.
Hm.

	Regards
		Oliver
