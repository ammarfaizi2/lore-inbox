Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWA0DZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWA0DZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWA0DZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:25:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3500 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030277AbWA0DZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:25:14 -0500
Date: Thu, 26 Jan 2006 19:25:13 -0800
From: Greg KH <gregkh@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060127032513.GA12559@suse.de>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 03:11:42PM +0100, Heiko Carstens wrote:
> There seems to be a bug in debugfs: it seems it doesn't get the hard link
> count right. See the output below. This happened on s390x with git tree
> of today. Any ideas?

What code were you using that called debugfs?  Is it in the mainline
tree?

This works just fine for me right now:

$ uname -r
2.6.16-rc1-git4

$ mount | grep debug
none on /sys/kernel/debug type debugfs (rw)

$ cd /sys/kernel/debug/
$ find .
.
./uhci
./uhci/0000:00:1d.3
./uhci/0000:00:1d.2
./uhci/0000:00:1d.1
./uhci/0000:00:1d.0

$ find --version
GNU find version 4.3.0
Features enabled: D_TYPE O_NOFOLLOW(enabled) LEAF_OPTIMISATION FTS 

$ stat .
  File: `.'
  Size: 0               Blocks: 0          IO Block: 4096   directory
Device: eh/14d  Inode: 15528       Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/ root)
Access: 2006-01-26 19:23:28.442337216 -0800
Modify: 2006-01-24 13:14:03.487515504 -0800
Change: 2006-01-24 13:14:03.487515504 -0800


thanks,

greg k-h
