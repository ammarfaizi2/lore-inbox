Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUJ2BmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUJ2BmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUJ2Bjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:39:36 -0400
Received: from schiffbauer.net ([212.112.227.138]:28093 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id S263268AbUJ2B20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 21:28:26 -0400
Date: Fri, 29 Oct 2004 03:28:24 +0200
From: Marc Schiffbauer <marc@schiffbauer.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9: Badness in __vunmap at mm/vmalloc.c:315 and some following oopses...
Message-ID: <20041029012824.GD497@lisa>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.20-hpt i686
X-Editor: vim 6.1.018-1
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel folks,

i got some oopses while playing with my ipw2100 wireless card
(trying to load/unload driver)

are these oopses of any use to debug for you guys?
please tell we if I can provide further information to track this
down.


Full output is here (about 70k):
http://www.links2linux.de/tmp/2.6.9_oopses


It starts like this:
Oct 28 23:06:31 localhost kernel: Trying to vfree() nonexistent vm area (f8fa9000)
Oct 28 23:06:31 localhost kernel: Badness in __vunmap at mm/vmalloc.c:315
Oct 28 23:06:31 localhost kernel:  [vfree+39/53] vfree+0x27/0x35
Oct 28 23:06:31 localhost kernel:  [fw_realloc_buffer+154/202] fw_realloc_buffer+0x9a/0xca
Oct 28 23:06:31 localhost kernel:  [firmware_data_write+150/235] firmware_data_write+0x96/0xeb
Oct 28 23:06:31 localhost kernel:  [flush_write+58/66] flush_write+0x3a/0x42
Oct 28 23:06:31 localhost kernel:  [write+204/232] write+0xcc/0xe8
Oct 28 23:06:31 localhost kernel:  [write+0/232] write+0x0/0xe8
Oct 28 23:06:31 localhost kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
Oct 28 23:06:31 localhost kernel:  [sys_write+81/128] sys_write+0x51/0x80
Oct 28 23:06:31 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 28 23:06:31 localhost kernel: Badness in map_area_pte at mm/vmalloc.c:100
Oct 28 23:06:31 localhost kernel:  [map_area_pte+153/155] map_area_pte+0x99/0x9b
Oct 28 23:06:31 localhost kernel:  [map_area_pmd+111/151] map_area_pmd+0x6f/0x97
Oct 28 23:06:31 localhost kernel:  [map_vm_area+97/171] map_vm_area+0x61/0xab
Oct 28 23:06:31 localhost kernel:  [__vmalloc+225/279] __vmalloc+0xe1/0x117
Oct 28 23:06:31 localhost kernel:  [vmalloc+32/36] vmalloc+0x20/0x24
Oct 28 23:06:31 localhost kernel:  [fw_realloc_buffer+69/202] fw_realloc_buffer+0x45/0xca
Oct 28 23:06:31 localhost kernel:  [firmware_data_write+150/235] firmware_data_write+0x96/0xeb
Oct 28 23:06:31 localhost kernel:  [flush_write+58/66] flush_write+0x3a/0x42
Oct 28 23:06:31 localhost kernel:  [write+204/232] write+0xcc/0xe8
Oct 28 23:06:31 localhost kernel:  [write+0/232] write+0x0/0xe8
Oct 28 23:06:31 localhost kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
Oct 28 23:06:31 localhost kernel:  [sys_write+81/128] sys_write+0x51/0x80
Oct 28 23:06:31 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 28 23:06:31 localhost kernel: Badness in map_area_pte at mm/vmalloc.c:100
Oct 28 23:06:31 localhost kernel:  [map_area_pte+153/155] map_area_pte+0x99/0x9b
Oct 28 23:06:31 localhost kernel:  [map_area_pmd+111/151] map_area_pmd+0x6f/0x97
Oct 28 23:06:31 localhost kernel:  [map_vm_area+97/171] map_vm_area+0x61/0xab
Oct 28 23:06:31 localhost kernel:  [__vmalloc+225/279] __vmalloc+0xe1/0x117
Oct 28 23:06:31 localhost kernel:  [vmalloc+32/36] vmalloc+0x20/0x24
Oct 28 23:06:31 localhost kernel:  [fw_realloc_buffer+69/202] fw_realloc_buffer+0x45/0xca
Oct 28 23:06:31 localhost kernel:  [firmware_data_write+150/235] firmware_data_write+0x96/0xeb
Oct 28 23:06:31 localhost kernel:  [flush_write+58/66] flush_write+0x3a/0x42
Oct 28 23:06:31 localhost kernel:  [write+204/232] write+0xcc/0xe8
Oct 28 23:06:31 localhost kernel:  [write+0/232] write+0x0/0xe8
Oct 28 23:06:31 localhost kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
Oct 28 23:06:31 localhost kernel:  [sys_write+81/128] sys_write+0x51/0x80
Oct 28 23:06:31 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 28 23:06:31 localhost kernel: Unable to handle kernel paging request at virtual address 00100100
Oct 28 23:06:31 localhost kernel:  printing eip:
Oct 28 23:06:31 localhost kernel: c015aefa
Oct 28 23:06:31 localhost kernel: *pde = 00000000
Oct 28 23:06:31 localhost kernel: Oops: 0000 [#1]

-marc
-- 
+------------------------------------------------------------------+
|              --> http://www.links2linux.de <--                   |
|                                                                  |
+---Registered-Linux-User-#136487------------http://counter.li.org +
