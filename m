Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTDQSBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTDQSBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:01:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261842AbTDQSBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:01:12 -0400
Date: Thu, 17 Apr 2003 11:13:03 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Recent changes broke mkinitrd?
Message-Id: <20030417111303.706d7246.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent (post 2.5.67) versions of the kernel break the creation
of the initial ram disk. This is on RH 8.0 but probably is more
wide spread.

The failure mode is:
# mkinitrd /tmp/initrd.2.5.67 2.5.67
tar: ./bin: Cannot mkdir: No space left on device
tar: ./bin/nash: Cannot open: No such file or directory
tar: ./bin/insmod: Cannot open: No such file or directory
tar: ./bin/modprobe: Cannot open: No such file or directory
tar: ./etc: Cannot mkdir: No space left on device
tar: ./dev: Cannot mkdir: No space left on device
tar: ./dev/console: Cannot mknod: No such file or directory
tar: ./dev/null: Cannot mknod: No such file or directory
tar: ./dev/ram: Cannot mknod: No such file or directory
tar: ./dev/systty: Cannot mknod: No such file or directory
tar: ./dev/tty1: Cannot mknod: No such file or directory
tar: ./dev/tty2: Cannot mknod: No such file or directory
tar: ./dev/tty3: Cannot mknod: No such file or directory
tar: ./dev/tty4: Cannot mknod: No such file or directory
tar: ./loopfs: Cannot mkdir: No space left on device
tar: ./proc: Cannot mkdir: No space left on device
tar: ./sysroot: Cannot mkdir: No space left on device
tar: Error exit delayed from previous errors

The problem is not the increase size of modules but instead something
changed with ext2/ext3? 

                 Running kernel
                 2.5.67-bk  2.4.18
                 *-------*------*
	  2.5.67 | Fails |  Ok  |
mkinitrd         *-------*------*
          2.4.18 | Fails |  Ok  |
                 *-------*------*

2.5.67 is okay, but the latest kernel from bk is not.


	
