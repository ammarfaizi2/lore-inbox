Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTDCXcd (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTDCXcd (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:32:33 -0500
Received: from [12.47.58.55] ([12.47.58.55]:12704 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263573AbTDCXcc (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 18:32:32 -0500
Date: Thu, 3 Apr 2003 15:43:14 -0800
From: Andrew Morton <akpm@digeo.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mounting 4000 disks
Message-Id: <20030403154314.7b8604c9.akpm@digeo.com>
In-Reply-To: <200304031520.52138.pbadari@us.ibm.com>
References: <200304031520.52138.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 23:43:55.0761 (UTC) FILETIME=[E3DACE10:01C2FA3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi,
> 
> I have been playing with testing 4000 disk support. (using 32bit dev_t).
> 
> I created 4000 disks using scsi_debug and mounted them.
> We consumed 84MB of low memory by just mouting 4000 filesystems.
> Out of 84MB lowmem 48MB is in slabs. 33 MB is used by buffers.

20 kbytes per disk+filesystem seems reasonable.

The "Buffers" will be the superblock (4k) and the group descriptor blocks
(256 bytes per gigabyte of disk).  These are pinned memory.

And the ext2 superblock got bigger in -mm due to the recent scalability
patches.

What is using the "size-8192" allocation there?  It could be the ext2 superblock
if you have NR_CPUS=32.
