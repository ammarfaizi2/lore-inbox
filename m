Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTFKVjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTFKVjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:39:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264478AbTFKVjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:39:21 -0400
Date: Wed, 11 Jun 2003 14:54:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Greg KH <greg@kroah.com>
cc: Alan Stern <stern@rowland.harvard.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: BUG in driver model class.c
In-Reply-To: <20030611215147.GA27029@kroah.com>
Message-ID: <Pine.LNX.4.44.0306111454280.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jun 2003, Greg KH wrote:

> On Wed, Jun 11, 2003 at 01:12:47PM -0400, Alan Stern wrote:
> > Greg:
> > 
> > There is a bug in drivers/base/class.c in 2.5.70.  Near the start of the
> > routine class_device_add() are the lines
> > 
> >         if (class_dev->dev)
> >                 get_device(class_dev->dev);
> > 
> > But there's nothing to undo this get_device, either in the error return 
> > part of class_device_add() or in class_device_del().
> > 
> > I assume that either this get_device() doesn't belong there or else there
> > should be corresponding put_device() calls in the other two spots.  
> > Whichever is the case, it should be easy for you to fix.
> 
> You are correct.  I took out the other put_device() in the -bk tree in
> class_device_del() but forgot to remove this one.  Good catch.
> 
> Pat, here's a patch to fix this up, against the latest -bk tree.

Applied, thanks,


	-pat

