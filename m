Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTDSHz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 03:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTDSHz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 03:55:26 -0400
Received: from tmi.comex.ru ([217.10.33.92]:36284 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263365AbTDSHzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 03:55:25 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: bash-shared-mapping oops'es on 2.5.66-mm1
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Sat, 19 Apr 2003 12:06:01 +0400
Message-ID: <m37k9qrjx2.fsf@tmi.comex.ru>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

[root@proto db2]# /root/tools/bash-shared-mapping -n 5 -t 3 foo 300000000

on serial console:

------------[ cut here ]------------
kernel BUG at mm/rmap.c:408!
invalid operand: 0000 [#1]

Program received signal SIGTRAP, Trace/breakpoint trap.
page_remove_rmap (page=0xc1345580, ptep=0xc1345580) at mm/rmap.c:408
408                             BUG();
(gdb) bt
#0  page_remove_rmap (page=0xc1345580, ptep=0xc1345580) at mm/rmap.c:408
#1  0xc0143c63 in zap_pte_range (tlb=0xc03d957c, pmd=0xc9c3a478, address=1199570944, size=4194304)
    at mm/memory.c:426
#2  0xc0143d45 in zap_pmd_range (tlb=0xc03d957c, dir=0xc9c3a478, address=1199570944, size=208994304)
    at mm/memory.c:458
#3  0xc0143da0 in unmap_page_range (tlb=0xc03d957c, vma=0xd3cf0ee0, address=1130024960, end=1408565248)
    at mm/memory.c:479
#4  0xc0143e94 in unmap_vmas (tlbp=0xcf64de74, mm=0xdf657220, vma=0xd3cf0ee0, start_addr=1130024960, 
    end_addr=1408565248, nr_accounted=0xcf64de78) at mm/memory.c:573
#5  0xc01441ac in zap_page_range (vma=0xd3cf0ee0, address=1130024960, size=278540288)
    at mm/memory.c:618
#6  0xc0144d58 in vmtruncate_list (head=0xda8d3db0, pgoff=5240) at mm/memory.c:1065
#7  0xc0144e2f in vmtruncate (inode=0xda8d3ccc, offset=21460646) at mm/memory.c:1094
#8  0xc016d5b9 in inode_setattr (inode=0xda8d3ccc, attr=0xcf64df60) at fs/attr.c:72
#9  0xc018dab2 in ext3_setattr (dentry=0xdfcc2da0, attr=0xcf64df60) at fs/ext3/inode.c:2536
#10 0xc016d8bb in notify_change (dentry=0xdfcc2da0, attr=0xcf64df60) at fs/attr.c:163
#11 0xc0151de8 in do_truncate (dentry=0xdfcc2da0, length=21460646) at fs/open.c:90
#12 0xc0152343 in sys_ftruncate64 (fd=3, length=21460646) at fs/open.c:197
(gdb) 


