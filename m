Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUFUXo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUFUXo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUFUXo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:44:28 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:22704 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266527AbUFUXo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:44:27 -0400
Date: Mon, 21 Jun 2004 19:44:25 -0400
From: Tom Vier <tmv@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7: preempt + sysfs = BUG on ppc
Message-ID: <20040621234425.GA24935@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040620153922.GA20103@zero> <20040620144906.095a4f93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620144906.095a4f93.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 02:49:06PM -0700, Andrew Morton wrote:
> >  kernel BUG in fill_read_buffer at fs/sysfs/file.c:92!
> 
> Please add this patch, then retest:
> 
> --- 25/fs/sysfs/file.c~sysfs-overflow-debug	2004-06-20 14:44:44.272707136 -0700
> +++ 25-akpm/fs/sysfs/file.c	2004-06-20 14:48:23.580367304 -0700

here ya go. it's /sys/class/net/eth1/wireless/beacon. that's for my airport
card (apple branded lucent chip). i would look at its sysfs code, but i'm
not familiar with it at all (and i'm busy).


fill_read_buffer: show handler overrun
->show handler: 0xc010e38c (class_device_attr_show+0x0/0x48)
kernel BUG in fill_read_buffer at fs/sysfs/file.c:99!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT 
NIP: C00968EC LR: C00968EC SP: D19A7EA0 REGS: d19a7df0 TRAP: 0700    Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d1366d80[878] 'rsync' THREAD: d19a6000Last syscall: 3 
GPR00: C00968EC D19A7EA0 D1366D80 00000001 00001AE3 FFFFFFFF C02D9674 C02D970C 
GPR08: 0019377F C0290000 00000000 D19A6000 80008424 1004CFE4 00000000 00000004 
GPR16: 10057B08 10040000 10057880 00000000 00001000 FFFFFFFF 00001000 00000000 
GPR24: 00001000 00000000 00000000 00000000 C025DFCC CB2598FC C079F1A8 FFFFFFEA 
NIP [c00968ec] fill_read_buffer+0xe0/0xf8
LR [c00968ec] fill_read_buffer+0xe0/0xf8
Call trace:
 [c0096a6c] sysfs_read_file+0x5c/0x78
 [c005ad68] vfs_read+0xdc/0x128
 [c005afd8] sys_read+0x40/0x74
 [c0005b20] ret_from_syscall+0x0/0x44

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
