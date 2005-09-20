Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVITSMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVITSMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVITSMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:12:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964889AbVITSML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:12:11 -0400
Date: Tue, 20 Sep 2005 11:12:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ray Lee <ray@madrabbit.org>
cc: Al Viro <viro@ftp.linux.org.uk>, John McCutchan <ttb@tentacle.dhs.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <1127238257.9940.14.camel@localhost>
Message-ID: <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org>
References: <1127188015.17794.6.camel@vertex>  <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
  <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
  <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex>
  <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex>
  <20050920051729.GF7992@ftp.linux.org.uk>  <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
  <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Ray Lee wrote:
> 
> I can't even talk to that level, but perhaps it'd help to know that some
> (I think) are pinning their hopes on inotify as the foundation of a
> userspace negative dentry cache (i.e., samba trying to prove a set of
> filenames (case-insensitively) doesn't exist).

Note that than you should use the _name_ caching part, ie the 
fsnotify_nameremove() part of the equation. That part is unambiguous.

It's literally only the "inode" things (IN_DELETE_SELF) that are
questionable. And that's fundamentally because the "self" can live on for
_longer_ than the name that points to it.

I really think that the patch I sent out yesterday is as good as it gets.  
If you want immediate notification, you should ask for notification about
name changes in a particular directory. IN_DELETE_SELF notification on a
file simple is _not_ going to be immediate.

		Linus
