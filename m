Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTB0XAu>; Thu, 27 Feb 2003 18:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTB0XAu>; Thu, 27 Feb 2003 18:00:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:31111 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267365AbTB0XAt>;
	Thu, 27 Feb 2003 18:00:49 -0500
Date: Thu, 27 Feb 2003 15:07:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Paul B Schroeder <paulsch@haywired.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, girouard@us.ibm.com
Subject: Re: [PATCH][2.5] mwave updates
Message-Id: <20030227150738.54382b6c.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.33.0302271430390.18104-100000@snafu.haywired.net>
References: <Pine.LNX.4.33.0302271430390.18104-100000@snafu.haywired.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Feb 2003 23:11:02.0400 (UTC) FILETIME=[7F2E9000:01C2DEB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul B Schroeder <paulsch@haywired.net> wrote:
>
> The patch can be found here...
> 
> http://www.haywired.net/~paulsch/patches/mwave-2.5.63.patch
> 

I tested this patch on a machine which does not have mwave hardware.  The
driver was statically linked into the kernel.  It died...

smapi::smapi_init, ERROR invalid usSmapiID
mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
mwave: mwavedd::mwave_init: Error: Failed to initialize board data
mwave: mwavedd::mwave_init: Error: Failed to initialize

Program received signal SIGSEGV, Segmentation fault.
hash_and_remove (dir=0x0, name=0xc0338e70 "3780i_dma")
    at include/asm/semaphore.h:115
115     {
(gdb) bt
#0  hash_and_remove (dir=0x0, name=0xc0338e70 "3780i_dma")
    at include/asm/semaphore.h:115
#1  0xc0180295 in sysfs_remove_file (kobj=0xc04243d4, attr=0xc0377130)
    at fs/sysfs/inode.c:771
#2  0xc022f289 in device_remove_file (dev=0xc04243a0, attr=0xc0377130)
    at drivers/base/core.c:121
#3  0xc0247aa2 in mwave_exit () at drivers/char/mwave/mwavedd.c:520
#4  0xc03c6720 in mwave_init () at drivers/char/mwave/mwavedd.c:663
#5  0xc03b4804 in do_initcalls () at init/main.c:472
#6  0xc03b4833 in do_basic_setup () at init/main.c:497
#7  0xc01050f6 in init (unused=0x0) at init/main.c:535

(gdb) up
#1  0xc0180295 in sysfs_remove_file (kobj=0xc04243d4, attr=0xc0377130)
    at fs/sysfs/inode.c:771
771             hash_and_remove(kobj->dentry,attr->name);
(gdb) p kobj
$1 = (struct kobject *) 0xc04243d4
(gdb) p *kobj
$2 = {name = '\0' <repeats 15 times>, refcount = {counter = 0}, entry = {
    next = 0x0, prev = 0x0}, parent = 0x0, kset = 0x0, ktype = 0x0, 
  dentry = 0x0}
		
