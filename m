Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUIPQsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUIPQsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUIPQsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:48:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33722 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268474AbUIPQqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:46:23 -0400
Date: Thu, 16 Sep 2004 18:46:22 +0200
From: Jan Kara <jack@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] inotify 0.9
Message-ID: <20040916164622.GA28276@atrey.karlin.mff.cuni.cz>
References: <1095263565.19906.19.camel@vertex> <cic9os$ibd$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cic9os$ibd$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> John McCutchan wrote:
> >Hello,
> >
> >I am releasing a new version of inotify. Attached is a patch for
> >2.6.8.1.
<snip>

> >--MEMORY USAGE--
> >
> >The inotify data structures are light weight:
> >
> >inotify watch is 40 bytes
> >inotify device is 68 bytes
> >inotify event is 272 bytes
> >
> >So assuming a device has 8192 watches, the structures are only going
> >to consume 320KB of memory. With a maximum number of 8 devices allowed
> >to exist at a time, this is still only 2.5 MB
> >
> >Each device can also have 256 events queued at a time, which sums to
> >68KB per device. And only .5 MB if all devices are opened and have
> >a full event queue.
> >
> >So approximately 3 MB of memory are used in the rare case of 
> >everything open and full.
> >
> >Each inotify watch pins the inode of a directory/file in memory,
> >the size of an inode is different per file system but lets assume
> >that it is 512 byes. 
> >
> >So assuming the maximum number of global watches are active, this would
> >pin down 32 MB of inodes in the inode cache. Again not a problem
> >on a modern system. 
> 
> Did you work for Microsoft? Bloat doesn't count? And is this going to be 
>  low memory you pin? And is every file create or delete (or update of 
> atime) going to blast this mess through cache looking for people to notify?
> >
> >On smaller systems, the maximum watches / events could be lowered
> >to provide a smaller foot print.
> 
> Let's rethink this and say the max is by default and by use of proc or 
> sys or whatever's in vogue today you can enable the feature by setting a 
> non-zero value.
  As I understand the patch it won't have any nontrivial memory
footprint in case you won't use inotify. Only in case someone wants to
watch inode, appropriate structure is allocated, inode pined etc. The
numbers above are in the case you watch maximum possible number of
inodes etc...
  Maybe you should not be so fast in using your flamethrower;)

								Bye
									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
