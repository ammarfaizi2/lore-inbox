Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUAYRcT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUAYRcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:32:19 -0500
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264943AbUAYRcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:32:13 -0500
Date: Sun, 25 Jan 2004 12:32:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <Pine.LNX.4.58.0401231017030.2151@home.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Linus Torvalds wrote:

> HOWEVER - I do worry when people start exporting interfaces that are 
> basically _designed_ to deadlock. It's a bad interface. Don't export it. 
> There is possibly just _one_ place that can do it, and it's the module 
> unload part. Everything else would be a bug.

You know, this problem and other similar ones related to module unloading 
would go away if modules behaved more like other kernel objects:

	if they could be unregistered (rmmod) at any time, regardless
	of their refcount;

	if they would persist in an unregistered state, until they were
	released (unloaded from memory) when the refcount dropped to 0.

Then it wouldn't be necessary for a module's exit routine to wait when
unregistering devices.  A device could simply hold a reference to the
module; when the device was released and things were safe the module would
be unloaded.  The one exception would no longer exist.

Is there some reason why modules don't work like this?

Alan Stern

