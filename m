Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160996AbWBVQsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbWBVQsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWBVQsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:48:24 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:19642 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1160996AbWBVQsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:48:23 -0500
Subject: Re: udevd is killing file write performance.
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org, rml@novell.com, arnd@arndb.de, hch@lst.de,
       akpm@osdl.org
In-Reply-To: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Feb 2006 11:48:23 -0500
Message-Id: <1140626903.13461.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-22-02 at 07:42 -0600, Robin Holt wrote:
> 
> I know _VERY_ little about filesystems.  udevd appears to be looking
> at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
> being written is on an xfs filesystem mounted at a different mountpoint.
> Could the inotify flag be moved from a global to a sb (or something
> finer) point and therefore avoid taking the dentry->d_lock when there
> is no possibility of a watch event being queued.

We could do this, and avoid the problem, but only in this specific
scenario. The file being written is on a different mountpoint but whats
to stop a different app from running inotify on that mount point?
Perhaps the program could be altered instead? 

-- 
John McCutchan <john@johnmccutchan.com>
