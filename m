Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTBFU1L>; Thu, 6 Feb 2003 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTBFU1L>; Thu, 6 Feb 2003 15:27:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:30925 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267624AbTBFU1K>;
	Thu, 6 Feb 2003 15:27:10 -0500
Date: Thu, 6 Feb 2003 12:36:31 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-Id: <20030206123631.617524f7.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302061351380.998-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0302061351380.998-200000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 20:36:42.0742 (UTC) FILETIME=[75522160:01C2CE1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cox.net> wrote:
>
> I have run into an apparent anomaly while compiling/testing 2.5.59-bk.  My 
> normal mode of operation is to do a daily bk pull to get the latest csets 
> and do a compile/boot run.  After yesterday's I started seeing problems on 
> reboot.  During the reboot I would get the OK booting the kernel followed 
> by a system freeze.  After a forced reboot into a stock RedHat 8.0 2.4 
> kernel I would see the system misidentify my boot partiton as an ext2 
> partition and the following messages would appear:
> 

Everything you describe is consistent with a kernel which does not have ext3
compiled into it.

> EXT2-fs: ide0(3,8): couldn't mount because of unsupported optional feature 
> (4).
> Kernel panic: VFS: Unable to mount root fs on 08:08
> 

That is an ext3 filesystem in the "needs journal recovery" state.  ext2
cannot mount that until either fsck or the ext3 kernel driver has run
recovery.

grep EXT3 .config ??

