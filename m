Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266746AbUGLHvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266746AbUGLHvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266750AbUGLHvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:51:18 -0400
Received: from havoc.gtf.org ([216.162.42.101]:60613 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266746AbUGLHvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:51:16 -0400
Date: Mon, 12 Jul 2004 03:51:14 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: pmac oops: devfs versus power management - fight!
Message-ID: <20040712075113.GB19875@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running on an Apple TiBook.

With the most recent bk (=2.6.8-rc1) devfs and power management hate
each other.  I was able to get an Oops message once, but sometimes I don't
even get that.

[ I still use devfs because without it, the vt system freaks on boot since
  /dev/console doesn't exist yet, so I don't get any gentoo boot messages
  till the login: prompt ]

Here's what I've could copy down:

Oops: kernel access of bad area, sig: 11 [#1]
NIP C001C8B0  LR C02B1F38 ...
TASK = 'pbbuttonsd' ... Last syscall: 54
NIP [c001c8b0] add_wait_queue_exclusive+0x28/0x38
LR [c02b1f38] __down+0x54/0xe8
Call trace:
  [c016d6f8] pmz_suspend+0x200/0x21c
  [c0192e48] macio_device_suspend+0x4c/0x54
  [c09727f8] suspend_device+0x78/0x158
  [c03ea6c0] c03ea6c0
  [c03eabd0] c03eabd0
  [c03eb5dc] c03eb5dc
  [c006dfb4] sys_ioctl+0xdc/0x2fc
  [c0007f30] ret_from_syscall+0x0/0x4c
  
Oops: kernel access of bad area, sig: 11 [#2]
NIP C00EF8DC LR C00EF910
TASK = 'devfsd' ... Last syscall: 83
NIP [c00ef8dc] _devfs_search_dir+0x64/0xa4
LR [c00ef910] _devfs_search_dir+0x98/0xa4
Call trace:
  [c00f1614] devfs_lookup
  ...        __lookup_hash
  ...
  ...        return_from_syscall


-dte
