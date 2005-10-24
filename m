Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVJXBvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVJXBvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 21:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVJXBvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 21:51:52 -0400
Received: from ns1.nict.go.jp ([133.243.3.1]:53969 "EHLO ns1.nict.go.jp")
	by vger.kernel.org with ESMTP id S1750904AbVJXBvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 21:51:52 -0400
Date: Mon, 24 Oct 2005 10:51:34 +0900
From: CHIKAMA masaki <masaki-c@nict.go.jp>
To: linux-kernel@vger.kernel.org
Subject: The fasync_cache grows.  Possible leak in kernel 2.6.13.4.
Message-Id: <20051024105134.35825d59.masaki-c@nict.go.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have trouble with latest stable kernel (2.6.13.4).
I set up samba server on reiserfs and begin to copy a huge number of file.
After one day, the system is very slow and almost not usable.

The slabtop output is here.

 Active / Total Objects (% used)    : 1548119 / 1609222 (96.2%)
 Active / Total Slabs (% used)      : 36327 / 36329 (100.0%)
 Active / Total Caches (% used)     : 93 / 138 (67.4%)
 Active / Total Size (% used)       : 120135.47K / 136560.17K (88.0%)
 Minimum / Average / Maximum Object : 0.01K / 0.08K / 128.00K
                                                                                
  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
1150566 1150564  99%    0.02K   5091      226     20364K fasync_cache
                                                                                
134358 130080  96%    0.27K   9597       14     38388K radix_tree_node
104678  84053  80%    0.54K  14954        7     59816K ext3_inode_cache
 98874  74548  75%    0.14K   3662       27     14648K dentry_cache
 86925  83430  95%    0.05K   1159       75      4636K buffer_head
  6893   4976  72%    0.06K    113       61       452K size-64
  5712   3646  63%    0.03K     48      119       192K size-32
  3072   3057  99%    0.04K     32       96       128K sysfs_dir_cache
  2193   1667  76%    0.09K     51       43       204K vm_area_struct
  1333   1260  94%    0.12K     43       31       172K size-128
  1130    724  64%    0.02K      5      226        20K anon_vma
  1130   1024  90%    0.02K      5      226        20K dm_io
  1130   1024  90%    0.02K      5      226        20K dm_tio
  1070    828  77%    0.38K    107       10       428K inode_cache
   825    675  81%    0.25K     55       15       220K filp
   470    470 100%    0.39K     47       10       188K proc_inode_cache
   452    272  60%    0.02K      2      226         8K biovec-1


I can find the same problem on ext3 fs.
The FC3 latest kernel(2.6.12-1.1378_FC3smp) also.
It seems no difference between UP and SMP.
The problem is not solved even if I stop and restart the samba server.

Please give me your help.
Thanks.

PS. Please Cc: me. I'm not on the list. 

-- 
CHIKAMA Masaki @ NICT

