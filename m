Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTBXVqP>; Mon, 24 Feb 2003 16:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTBXVqP>; Mon, 24 Feb 2003 16:46:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:34524 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267581AbTBXVqN>;
	Mon, 24 Feb 2003 16:46:13 -0500
Date: Mon, 24 Feb 2003 13:53:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
Message-Id: <20030224135323.28bb2018.akpm@digeo.com>
In-Reply-To: <20030224120304.A29472@beaverton.ibm.com>
References: <20030224120304.A29472@beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2003 21:56:20.0240 (UTC) FILETIME=[905DF900:01C2DC4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patmans@us.ibm.com> wrote:
>
> Hi -
> 
> Running 2.5.62-mm2, I was trying to get multiple commands queued to
> different scsi disks via writes to multiple file systems (each fs
> on its own disk), but got rather low performance.
> 
> Are there any config options or settings I should change to improve the
> performance?
> 
> Is this expected behaviour for now?
> 
> I'm mounting 10 disks using ext2 with noatime, starting 10 dd's in
> parallel, with if=/dev/zero bs=128k count=1000, then umount-ing after each
> dd completes.

Could be that concurrent umount isn't a good way of getting scalable
writeout; I can't say that I've ever looked...

Could you try putting a `sync' in there somewhere?

Or even better, throw away dd and use write-and-fsync from ext3 CVS.  Give it
the -f flag to force an fsync against each file as it is closed.

http://www.zip.com.au/~akpm/linux/ext3/


