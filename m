Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVDDUyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVDDUyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDDUx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:53:26 -0400
Received: from mail.velocity.net ([66.211.211.55]:37602 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S261390AbVDDUu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:50:58 -0400
X-AV-Checked: Mon Apr  4 16:50:58 2005 clean
Subject: Re: [patch] inotify 0.22
From: Dale Blount <linux-kernel@dale.us>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1112644936.6736.7.camel@betsy>
References: <1112644936.6736.7.camel@betsy>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:50:55 -0400
Message-Id: <1112647855.520.20.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> inotify is intended to correct the deficiencies of dnotify, particularly
> its inability to scale and its terrible user interface:
> 
>         * dnotify requires the opening of one fd per each directory
>           that you intend to watch. This quickly results in too many
>           open files and pins removable media, preventing unmount.
>         * dnotify is directory-based. You only learn about changes to
>           directories. Sure, a change to a file in a directory affects
>           the directory, but you are then forced to keep a cache of
>           stat structures.
>         * dnotify's interface to user-space is awful.  Signals?
> 
> inotify provides a more usable, simple, powerful solution to file change
> notification:
> 
>         * inotify's interface is a device node, not SIGIO.  You open a 
>           single fd to the device node, which is select()-able.
>         * inotify has an event that says "the filesystem that the item
>           you were watching is on was unmounted."
>         * inotify can watch directories or files.
> 

Robert and others,

Will inotify watch directories recursively?  A quick browse through the
source doesn't look like it, but I very well could be wrong.  Last I
checked, dnotify did not either.  I am looking for a way to synchronize
files in as-real-as-possible-time when they are modified.  The ideal
implementation would be a kernel "hook" like d/inotify and a client
application that watches changes and copies them to a remote server for
redundancy purposes.   A scheduled rsync works decently, but has a lag
time of 2-3 (or more) hours on certain files on a large filesystem.
Will inotify work for this, or does someone else have another
recommended solution to the problem?

Thanks,

Dale

