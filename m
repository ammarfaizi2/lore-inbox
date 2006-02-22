Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWBVRvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWBVRvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWBVRvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:51:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20936 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161000AbWBVRvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:51:04 -0500
Date: Wed, 22 Feb 2006 11:50:30 -0600
From: Robin Holt <holt@sgi.com>
To: John McCutchan <john@johnmccutchan.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org, rml@novell.com,
       arnd@arndb.de, hch@lst.de, akpm@osdl.org
Subject: Re: udevd is killing file write performance.
Message-ID: <20060222175030.GB30556@lnx-holt.americas.sgi.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com> <1140626903.13461.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140626903.13461.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:48:23AM -0500, John McCutchan wrote:
> On Wed, 2006-22-02 at 07:42 -0600, Robin Holt wrote:
> > 
> > I know _VERY_ little about filesystems.  udevd appears to be looking
> > at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
> > being written is on an xfs filesystem mounted at a different mountpoint.
> > Could the inotify flag be moved from a global to a sb (or something
> > finer) point and therefore avoid taking the dentry->d_lock when there
> > is no possibility of a watch event being queued.
> 
> We could do this, and avoid the problem, but only in this specific
> scenario. The file being written is on a different mountpoint but whats
> to stop a different app from running inotify on that mount point?
> Perhaps the program could be altered instead? 

Looking at fsnotify_access() I think we could hit the same scenario.
Are you proposing we alter any appliction where multiple threads read
a single data file to first make a hard link to that data file and each
read from their private copy?  I don't think that is a very reasonable
suggestion.

Let me reiterate, I know _VERY_ little about filesystems.  Can the
dentry->d_lock be changed to a read/write lock?

Thanks,
Robin
