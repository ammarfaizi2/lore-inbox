Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVITEY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVITEY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVITEY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:24:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53986 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964875AbVITEY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:24:57 -0400
Date: Tue, 20 Sep 2005 05:24:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920042456.GC7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org> <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org> <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 09:03:36PM -0700, Linus Torvalds wrote:
> One possibility is to mark the dentry deleted in d_flags. That would mean 
> something like this (against the just-pushed-put v2.6.14-rc2, which has 
> my previous hack).
> 
> Untested. Al?
 
Uhh...  I still don't understand which behaviour do you want.

	* removal of this link, postponed to indefinite future (until we
do not have any users of that dentry) [ new behaviour ]
	* moment when the last link is gone _and_ nobody uses any dentries
pointing to object, with information taken from the last one still in use
[ old behaviour ]
	* actual destruction of file [ but we won't have any names to report ]
	* removal of this link, at the moment when it stops being accessible
[ none of the above, better done from vfs_...() ]
