Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUAGWYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbUAGWYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:24:11 -0500
Received: from ida.rowland.org ([192.131.102.52]:28164 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265655AbUAGWYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:24:08 -0500
Date: Wed, 7 Jan 2004 17:24:08 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Inconsistency in sysfs behavior?
In-Reply-To: <20040107215624.GC1083@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0401071712550.1589-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Greg KH wrote:

> On Wed, Jan 07, 2004 at 04:50:24PM -0500, Alan Stern wrote:
> > 
> > I had in mind approaching this the opposite way.  Instead of trying to 
> > make open directories also pin a kobject, why not make open attribute 
> > files not pin them?
> > 
> > It shouldn't be hard to avoid any errors; in fact I had a patch from some
> > time ago that would do the trick (although in a hacked-up kind of way).  
> > The main idea is to return -ENXIO instead of calling the show()/store()
> > routines once the attribute has been removed.
> 
> And you can do this without adding another lock, race free?

I used dentry->d_inode->i_sem.  While I'm not very familiar with the ins
and outs of the filesystem code, that ought to be safe enough.

The real problem was finding a way to indicate that the file was
disconnected from its kobject.  I did that by setting
dentry->d_inode->i_mode to 0.  (I didn't want to erase dentry->d_fsdata
for fear that it might be needed somewhere else.)  That's definitely not a
good way; it was intended only for my proof-of-principle.  No doubt
someone else could do a much better job.

Alan Stern

