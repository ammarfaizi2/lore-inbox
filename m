Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUDEQcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbUDEQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:32:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24723 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262936AbUDEQc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:32:29 -0400
Date: Mon, 5 Apr 2004 18:32:28 +0200
From: Jan Kara <jack@suse.cz>
To: =?iso-8859-2?Q?Vladim=EDr_T=F8ebick=FD?= <druid@mail.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem strangeness (ext3)
Message-ID: <20040405163228.GF22380@atrey.karlin.mff.cuni.cz>
References: <1014938126.20040405120812@xhost.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014938126.20040405120812@xhost.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> yesterday I discovered a bunch of corrupted files. When I try to stat()
> it, I get "Value too large for defined data type" or "Input/output
> error" when it is a symlink to those files. These were normal files
> (some readmes etc.) not accessed by any daemons or any applications at
> all. Midnight marks them with "?" at beginning and shows something
> about 3GB size. When I try to unlink() them, I get "Operation not
> permitted" even though I'm root. Kernel log shows these two kinds of
> errors:
> 
> Apr  5 11:33:47 master kernel: init_special_inode: bogus imode (113315)
> 
> and
> 
> Apr  5 11:33:49 master kernel: attempt to access beyond end of device
> Apr  5 11:33:49 master kernel: 09:01: rw=0, want=587173332, limit=38539776
  It seems like something trashed part of your disk...

> When I try to e2fsck -nf (I tried only ro test on mounted partition) I
> get some of these:
> 
> Illegal block #10 (2236192626) in inode 523442.  IGNORED.
  I suggest at least remounting the partition ro and then run the ro-test.

> and:
> 
> Error while iterating over blocks in inode 523442: Illegal triply indirect block found
> Segmentation fault
  Bug in e2fsck - you probably want to download latest version of e2fsck. If
there is still this bug report to e2fsck authors.

> It confuses me a little bit and I don't know wheter I should try to do
> rw e2fsck on unmounted partition, especially when e2fsck segfaults. My
  You should definitely backup the partition before you run fsck on it.

> system:
> 
> Linux master 2.4.22 #1 Sat Sep 20 14:26:11 CEST 2003 i686 unknown
> e2fsck 1.27 (8-Mar-2002)
>         Using EXT2FS Library version 1.27, 8-Mar-2002
> The device is /dev/md1:
> 
> [dev   9,   1] /dev/md1         889E3491.06B38BDD.B6F3803F.BCE40C0E online
> [dev   3,   7] /dev/hda7        889E3491.06B38BDD.B6F3803F.BCE40C0E good
> [dev   3,  71] /dev/hdb7        889E3491.06B38BDD.B6F3803F.BCE40C0E good
> 
> smartctl shows no errors on those physical disks.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
