Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTDMUci (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTDMUci (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:32:38 -0400
Received: from [12.47.58.73] ([12.47.58.73]:1028 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261907AbTDMUch (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 16:32:37 -0400
Date: Sun, 13 Apr 2003 13:44:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67: ppa driver & preempt == oops
Message-Id: <20030413134426.6767b0b0.akpm@digeo.com>
In-Reply-To: <3E994DEE.5000009@hccnet.nl>
References: <3E982AAC.3060606@hccnet.nl>
	<20030412141248.47a487b0.akpm@digeo.com>
	<3E994DEE.5000009@hccnet.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 20:44:18.0277 (UTC) FILETIME=[741AC150:01C301FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Vervoort <gert.vervoort@hccnet.nl> wrote:
>
> Andrew Morton wrote:
> 
> >This patch should make the warnings go away.
> >  
> >
> The warnings are still there:
> 
> ppa: Version 2.07 (for Linux 2.4.x)
> ppa: Found device at ID 6, Attempting to use EPP 16 bit
> ppa: Communication established with ID 6 using EPP 16 bit
> scsi0 : Iomega VPI0 (ppa) interface
> bad: scheduling while atomic!
> Call Trace:
>  [<c0117064>] schedule+0x3a4/0x3b0
>  [<c0117349>] wait_for_completion+0x99/0xe0

OK, that seems to be a different bug.  The patch actually fixes
a null pointer deref.

> error in initcall at 0xc0391ad0: returned with preemption imbalance

ick.

> When trying to mount a zip disk, the mount process gets stuck:
> 
> [root@viper root]# mount -t ext2 /dev/sda1 /mnt/zip
> SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
> sda: Write Protect is off
> sda: cache data unavailable
> sda: assuming drive cache: write through
> SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
> sda: Write Protect is off
> sda: cache data unavailable
> sda: assuming drive cache: write through
> 
> At this point the mount process is unkillable.
> Also strange is that the messages are printed twice.

The number of broken drivers in 2.5 continues to be depressing.

