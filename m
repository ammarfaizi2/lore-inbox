Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264155AbTCXLjj>; Mon, 24 Mar 2003 06:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264160AbTCXLjj>; Mon, 24 Mar 2003 06:39:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49580 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264155AbTCXLji>;
	Mon, 24 Mar 2003 06:39:38 -0500
Date: Mon, 24 Mar 2003 12:50:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: current BK boot failure, d_alloc()
Message-ID: <20030324115048.GA2371@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0

Program received signal SIGSEGV, Segmentation fault.
0xc016da64 in d_alloc (parent=0x0, name=0xdff8fea8) at
include/asm/string.h:196
196     __asm__ __volatile__(
(gdb) bt
#0  0xc016da64 in d_alloc (parent=0x0, name=0xdff8fea8)
    at include/asm/string.h:196
#1  0xc016dd16 in d_alloc_root (root_inode=0xc176ddc4) at
fs/dcache.c:787
#2  0xc014f46b in shmem_fill_super (sb=0xc176ddc4, data=0x1, silent=0)
    at mm/shmem.c:1738
#3  0xc015cabf in get_sb_nodev (fs_type=0x1, flags=-1049174588,
data=0x1, 
    fill_super=0xc014f330 <shmem_fill_super>) at fs/super.c:586
#4  0xc015cc16 in do_kern_mount (fstype=0x1 <Address 0x1 out of bounds>, 
    flags=1, name=0xc02c3547 "tmpfs", data=0x1) at fs/super.c:639
#5  0xc015ccb7 in kern_mount (type=0x1) at fs/super.c:665
#6  0xc0346620 in init_tmpfs () at mm/shmem.c:1887
#7  0xc0338992 in do_initcalls () at init/main.c:486
#8  0xc01050f5 in init (unused=0x0) at init/main.c:551
(gdb) print *(struct qstr *) name
$1 = {name = 0x0, len = 1, hash = 0, name_str = 0xdff8feb4 "\230µÿß\200µÿß"}

craps out in memcpy() due to name->name == NULL

-- 
Jens Axboe

