Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTIVQqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTIVQqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:46:12 -0400
Received: from vena.lwn.net ([206.168.112.25]:3007 "HELO lwn.net")
	by vger.kernel.org with SMTP id S263227AbTIVQqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:46:10 -0400
Message-ID: <20030922164609.5929.qmail@lwn.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Sat, 20 Sep 2003 02:28:44 BST."
             <20030920012844.GD7665@parcelfarce.linux.theplanet.co.uk> 
Date: Mon, 22 Sep 2003 10:46:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have no idea whether this follows the original plan for /sys/cdev.
> 
> They are more of a side effect.

So...to be sure I have things straight.../sys/cdev isn't really meant to be
there, and char devices wanting to do things in sysfs should be working
under /sys/devices or /sys/class or /sys/somethingelse?

> 	* driver has embedded struct cdev in its data structures

> 	* ->open() can use ->i_cdev to get whatever data structure driver
> had intended and avoid any lookups of its own

I noticed there's no "private" member in the cdev structure.  So drivers
should embed the structure and use container_of to get their real structure
of interest?

[Forgive my ignorance here...] If I embed a struct cdev within my own
device structure, how do I know when I can safely free said device
structure?  Will there be a release method that gets exposed at the driver
level, or am I missing something obvious again?

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
