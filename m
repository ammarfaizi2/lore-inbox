Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUIHUOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUIHUOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268671AbUIHUOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:14:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11140 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268304AbUIHUOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:14:46 -0400
Subject: Re: 2.6.9-rc1-mm4
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
References: <20040907020831.62390588.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1094674577.22026.4.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 15:16:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 04:08, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/

When running a moderate load and running top, I get:

kernel BUG in next_thread at kernel/exit.c:852!
cpu 0x2: Vector: 700 (Program Check) at [c00000027bcf3770]
    pc: c000000000058454: .next_thread+0x14/0x48
    lr: c0000000000f1a84: .do_task_stat+0x238/0x53c
    sp: c00000027bcf39f0
   msr: 8000000000029032
  current = 0xc000000270033380
  paca    = 0xc000000000474000
    pid   = 6627, comm = top
enter ? for help
2:mon> t
[link register   ] c0000000000f1a84 .do_task_stat+0x238/0x53c
[c00000027bcf39f0] c0000000000f1998 .do_task_stat+0x14c/0x53c
(unreliable)
[c00000027bcf3c50] c0000000000edc30 .proc_info_read+0x94/0x100
[c00000027bcf3cf0] c0000000000aa780 .vfs_read+0x10c/0x164
[c00000027bcf3d90] c0000000000aaa94 .sys_read+0x58/0xa4
[c00000027bcf3e30] c000000000011e00 syscall_exit+0x0/0x18
--- Exception: c01 (System Call) at 000000800021c944
SP (1ffffffeda0) is in userspace


> +show-aggregate-per-process-counters-in-proc-pid-stat.patch
> 
>  /proc/pid/stat enhancements

This seems the likely suspect to me, but I haven't the time at the
moment to try backing it out.

Nathan


