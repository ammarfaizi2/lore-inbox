Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUAGPsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUAGPsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:48:46 -0500
Received: from ida.rowland.org ([192.131.102.52]:12548 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266221AbUAGPsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:48:45 -0500
Date: Wed, 7 Jan 2004 10:48:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Inconsistency in sysfs behavior?
Message-ID: <Pine.LNX.4.44L0.0401071039150.850-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following appears to be an inconsistency in the way sysfs behaves.  
Tell me what you think...

When a user process parks its CWD in a kobject's sysfs directory and then
the kobject is unregistered, of course the directory is forced to remain
in existence (albeit unlinked) because of the reference held by the
process.  But it does not in turn hold a reference to the kobject; the
kobject will be deleted immediately if nothing else refers to it.

On the other hand, if a user process opens a sysfs attribute file and then
sysfs_remove_file() is called, again the file is forced to remain in
existence (albeit unlinked) because of the reference held by the process.  
But now it _does_ hold a reference to the kobject; if the kobject is
unregistered it will not be deleted until the user process closes the
attribute file.

Why this non-parallel behavior?

Alan Stern

