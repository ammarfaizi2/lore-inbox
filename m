Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbUAGVu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbUAGVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:50:28 -0500
Received: from ida.rowland.org ([192.131.102.52]:24836 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265624AbUAGVuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:50:24 -0500
Date: Wed, 7 Jan 2004 16:50:24 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Inconsistency in sysfs behavior?
In-Reply-To: <20040107172750.GC31177@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0401071644220.1589-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Greg KH wrote:

> Because it is very difficult to determine when a user goes into a
> directory because we are using the ramfs/libfs code.  It also does not
> cause any errors if the kobject is removed, as the vfs cleans up
> properly.
> 
> Only when a file is opened does a kobject need to be pinned, due to
> possible errors that could happen.

I had in mind approaching this the opposite way.  Instead of trying to 
make open directories also pin a kobject, why not make open attribute 
files not pin them?

It shouldn't be hard to avoid any errors; in fact I had a patch from some
time ago that would do the trick (although in a hacked-up kind of way).  
The main idea is to return -ENXIO instead of calling the show()/store()
routines once the attribute has been removed.

Alan Stern

