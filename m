Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbSJFQNX>; Sun, 6 Oct 2002 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJFQNB>; Sun, 6 Oct 2002 12:13:01 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:10151 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S261658AbSJFQM4>; Sun, 6 Oct 2002 12:12:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Robson <slarty2@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Using initrd loaded from syslinux causes oops during boot
Date: Sun, 6 Oct 2002 17:18:33 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021006161834.WOWM27697.mta05-svc.ntlworld.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]  Booting from floppy with syslinux and loading a ramdisk image causes an 
oops during boot
[2.] 
I'm testing kernel 2.5.40 for a single floppy mini-distro which uses initrd.

I get an oops happening on boot, just after
RAMDISK: Compressed image found at block 0

[3.] ramdisk initrd syslinux

[4.] stock kernel version 2.5.40 (cannot boot the system to cat /proc/version)

[5.] Output of Oops.. message 

I can't copy the entire oops message here because it's a lot of typing. 
Needless to say, the message is

Unable to handle NULL pointer deference at address 00000000

eip = c0107b8d <__down+5d/e0>

call stack
c0113210 <default_wake_function+0/40>
c0107d5c <__down_failed+8/c>
c016a7cd <.text.lock.util+7d/90>
c0157ffe <devfs_remove_partitions+8e/a0>
c015841d <del_gendisk+1d/40>
c0195149 <initrd_release+19/50>
c013632b <__fput+2b/e0>
c0108c37 <syscall_call+7/b>
c0134dfd <filp_close+4d/60>
c0134e55 <sys_close+45/60>
c0108c37 <syscall_call+7/b>
c0105341 <prepare_namespace+b1/130>
c0105030 <init+0/160>
c0105056 etc
c0105030 etc
c0107025 etc

I've resolved most of the symbols so I hope it's clear where the error is 
occuring (I'm not an expert at kernel debugging)

[6.] A small shell script or example program which triggers the problem:

Booting triggers the problem.

The syslinux config is:

KERNEL linux
APPEND initrd=rdimage vga=1 rw

[7.1.] Software (add the output of the ver_linux script here)
Can't boot to run ver_linux

syslinux 1.63 if that makes a difference.

[7.2.] Processor information (from /proc/cpuinfo):
Can't boot to cat /proc/cpuinfo (could go back to an old kernel, I know). 
It's a Pentium-classic 133Mhz

[7.3.] Module information (from /proc/modules):
Modules not enabled in the kernel config

I hope this offers sufficient information to be useful.

Regards,
	Mark
