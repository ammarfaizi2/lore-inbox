Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbTIESkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTIESkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:40:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1922 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265250AbTIESkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:40:08 -0400
Date: Fri, 5 Sep 2003 14:42:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Stern <stern@rowland.harvard.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.44L0.0309051331230.678-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.53.0309051435230.23800@chaos>
References: <Pine.LNX.4.44L0.0309051331230.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Alan Stern wrote:

> My kernel module for Linux-2.6 needs to be able to verify that the media
> on which a file resides actually is readable.  How can I do that?
>
> It would certainly suffice to use the normal VFS read routines, if there
> was some way to force the system to actually read from the device rather
> than just returning data already in the cache.  So I guess it would be
> enough to perform an fdatasync for the file and then invalidate the file's
> cache entries.  How does one invalidate a file's cache entries?  Does
> filemap_flush() perform both these operations for you?
>
> TIA,
>
> Alan Stern

Force a read() before some write data was flushed to the disk??
Well, if you insist, just do a raw read of the device after
you find the inode, then offset, that your data is on. You
can walk the same fs structure(s) as the active file-system
to get all meta-data information.

...but... The most current data is probably in the kernel
buffers. I don't think you really want what you are asking
for. If you did a fdatasync(), you get the current data your
process wrote to go to the disk. However, there may be
other writers. This, too, may not be what you want. Also,
Just because the data was queued to go to a (SCSI) disk,
doesn't mean it actually got to the platters.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


