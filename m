Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVITDd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVITDd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVITDd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:33:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12526 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964861AbVITDd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:33:56 -0400
Date: Tue, 20 Sep 2005 04:33:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920033355.GB7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org> <1127181641.16372.10.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127181641.16372.10.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 10:00:41PM -0400, John McCutchan wrote:
> To quote you:
> 
> Instead of the broken fsnotify_unlink/fsnotify_rmdir functions, you can 
> split this into two logically _different_ functions:
> 
>  - fsnotify_nameremove(dentry) - called when the dentry goes away
>  - fsnotify_inoderemove(dentry) - called when the inode goes away
> 
> ...
> 
> The fsnotify_inoderemove() is called from dentry_iput(), and that's the 
> one that specifies that an actual inode no longer exists.
> 
> 
> ;)

That was wrong.  Just have *one* function (on link removal) and stuff
i_mode and i_nlink of victim into event.
