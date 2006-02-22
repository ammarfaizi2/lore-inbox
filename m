Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWBVWwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWBVWwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWBVWwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:52:51 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:23429 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751592AbWBVWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:52:51 -0500
Subject: Re: udevd is killing file write performance.
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de, hch@lst.de,
       akpm@osdl.org
In-Reply-To: <20060222175030.GB30556@lnx-holt.americas.sgi.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	 <1140626903.13461.5.camel@localhost.localdomain>
	 <20060222175030.GB30556@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Feb 2006 17:52:56 -0500
Message-Id: <1140648776.1729.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-22-02 at 11:50 -0600, Robin Holt wrote:
> On Wed, Feb 22, 2006 at 11:48:23AM -0500, John McCutchan wrote:
> > On Wed, 2006-22-02 at 07:42 -0600, Robin Holt wrote:
> > > 
> > > I know _VERY_ little about filesystems.  udevd appears to be looking
> > > at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
> > > being written is on an xfs filesystem mounted at a different mountpoint.
> > > Could the inotify flag be moved from a global to a sb (or something
> > > finer) point and therefore avoid taking the dentry->d_lock when there
> > > is no possibility of a watch event being queued.
> > 
> > We could do this, and avoid the problem, but only in this specific
> > scenario. The file being written is on a different mountpoint but whats
> > to stop a different app from running inotify on that mount point?
> > Perhaps the program could be altered instead? 
> 
> Looking at fsnotify_access() I think we could hit the same scenario.
> Are you proposing we alter any appliction where multiple threads read
> a single data file to first make a hard link to that data file and each
> read from their private copy?  I don't think that is a very reasonable
> suggestion.

Listen, what I'm saying is that your suggested change will only help in
one specific scenario, and simply having inotify used on the 'wrong'
mountpoint will get you back to square one. So, your suggestion isn't
really a solution, but a way of avoiding the real problem. What I *am*
suggesting is that a real fix be found, instead of your hack.

-- 
John McCutchan <john@johnmccutchan.com>
