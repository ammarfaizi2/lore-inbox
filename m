Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVITE6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVITE6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVITE6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:58:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32143 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932538AbVITE6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:58:38 -0400
Date: Tue, 20 Sep 2005 05:58:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920045835.GE7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org> <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org> <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org> <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127191992.19093.3.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:53:12AM -0400, John McCutchan wrote:
> DELETE_SELF WD=X
> 
> The path you requested a watch on (inotify_add_watch(path,mask) returned
> X) has been deleted.

Then why the devil do we have IN_DELETE and IN_DELETE_SELF generated
in different places?  The only difference is in who receives the
event - you send IN_DELETE to watchers on parent and IN_DELETE_SELF
on watchers on victim.  Event itself is the same, judging by your
description...
