Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756177AbWKVRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbWKVRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbWKVRz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:55:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:49537 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1756177AbWKVRz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:55:28 -0500
Date: Tue, 21 Nov 2006 21:27:30 -0800
From: Greg KH <greg@kroah.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: Debugfs : inotify, multiple calls to debugfs_create_file, remove
Message-ID: <20061122052730.GD20836@kroah.com>
References: <20061120181838.GB7328@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120181838.GB7328@Krystal>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 01:18:38PM -0500, Mathieu Desnoyers wrote:
> Hi Greg,
> 
> I just had to add inotify support to my LTTng consumer so I could inform it
> of the presence of new CPUs (for CPU hotplug). I noticed that no
> notification event was being sent when a debugfs file is created from within
> the kernel through debugfs_create. There are probably other notifications
> missing, but here is the patch adding the one I care about. Should it be added
> in libfs or in debugfs ?

So does this fix the inotify issue?

> A second problem I noticed is when a caller calls debugfs_create_file more than
> once : the result is that the debugfs_remove will fail. I guess the second call
> to debugfs_create_file increments the reference counts (there is not fix for
> this issue in my patch).
> 
> Third problem : a failing call to debugfs_remove keeps the filesystem pinned.
> (fixed by calling simple_release_fs in the error path).
> 
> The third problem : When a process is in a directory, the call to simple_rmdir
> will fail. Debugfs does not use its return value. I noticed that calling
> simple_unlink on a directory when simple_rmdir fails removes the directory that
> would otherwise be left there. I am not sure if this approach is correct
> through.
> 
> This patch is against Linux 2.6.18.

Care to split this into 4 different patches (you seem to have 4 issues
here), so that it's easier to see them, and it will follow the
1-patch-per-issue rule?

thanks,

greg k-h
