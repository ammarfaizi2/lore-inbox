Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVFVAfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVFVAfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVFVAfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:35:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61113 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262384AbVFVAe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:34:57 -0400
Subject: Re: 2.6.12-mm1 & 2K lun testing  (JFS problem ?)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, shaggy@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20050617141331.078e5f8f.akpm@osdl.org>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	 <20050616002451.01f7e9ed.akpm@osdl.org>
	 <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
	 <20050616133730.1924fca3.akpm@osdl.org>
	 <1118965381.4301.488.camel@dyn9047017072.beaverton.ibm.com>
	 <20050616175130.22572451.akpm@osdl.org> <42B2E7D2.9080705@us.ibm.com>
	 <20050617141331.078e5f8f.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 17:34:54 -0700
Message-Id: <1119400494.4620.33.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Shaggy,

Here is the summary of 2K lun testing on 2.6.12-mm1.

When I tune dirty ratios and CFQ queue depths, things
seems to be running fine.

	echo 20 > /proc/sys/vm/dirty_ratio
	echo 20 > /proc/sys/vm/overcommit_ratio
	echo 4 > /sys/block/<device>/queue/nr_requests
	

But, I am running into JFS problem. I can't kill my
"dd" process. They all get stuck in:

(I am going to try ext3).

dd            D 0000000000000000     0 12943      1               12939
(NOTLB)
ffff81010612d8f8 0000000000000086 ffff81019677a380 000000000003ffff
       00000000d5b95298 ffff81010612d918 0000000000000003
ffff810169f63880
       00000076d9f1ea00 0000000000000001
Call Trace:<ffffffff802fb31f>{submit_bio+223} <ffffffff8026a8e1>{txBegin
+625}
       <ffffffff80130540>{default_wake_function+0}
<ffffffff80130540>{default_wake_function+0}
       <ffffffff80250a8b>{jfs_commit_inode+155}
<ffffffff80250daa>{jfs_write_inode+58}
       <ffffffff801a8857>{__writeback_single_inode+551}
<ffffffff80250929>{jfs_get_blocks+521}
       <ffffffff8015dd4c>{find_get_page+92}
<ffffffff80185555>{__find_get_block_slow+85}
       <ffffffff801a8e7c>{generic_sync_sb_inodes+524}
<ffffffff801a91cd>{writeback_inodes+125}
       <ffffffff80164aa4>{balance_dirty_pages_ratelimited+228}
       <ffffffff8015eb65>{generic_file_buffered_write+1221}
       <ffffffff8013b3a5>{current_fs_time+85}
<ffffffff801a9254>{__mark_inode_dirty+52}
       <ffffffff8019e4ac>{inode_update_time+188}
<ffffffff8015effa>{__generic_file_aio_write_nolock+938}
       <ffffffff8016efa5>{unmap_vmas+965}
<ffffffff8015f1de>{__generic_file_write_nolock+158}
       <ffffffff8017149e>{zeromap_page_range+990}
<ffffffff8014d0c0>{autoremove_wake_function+0}
       <ffffffff802941b1>{__up_read+33}
<ffffffff8015f345>{generic_file_write+101}
       <ffffffff80183b39>{vfs_write+233} <ffffffff80183ce3>{sys_write
+83}
       <ffffffff8010dc8e>{system_call+126}

# ps -alx 

...
0     0 12923     1  18   0   2900   512 txBegi D    pts/1      0:01 dd
if /dev/zero of /mnt2030/0     0 12925     1  18   0   2896   512 txBegi
D    pts/1      0:02 dd if /dev/zero of /mnt2029/0     0 12927     1  18
0   2896   512 txBegi D    pts/1      0:01 dd if /dev/zero of /mnt2032/0
0 12928     1  18   0   2900   512 txBegi D    pts/1      0:02 dd
if /dev/zero of /mnt2034/0     0 12930     1  18   0   2900   512 txBegi
D    pts/1      0:02 dd if /dev/zero of /mnt2035/0     0 12932     1  18
0   2896   508 txBegi D    pts/1      0:02 dd if /dev/zero of /mnt2037/0
0 12933     1  18   0   2896   512 txBegi D    pts/1      0:02 dd
if /dev/zero of /mnt2038/0     0 12935     1  18   0   2900   512 txBegi
D    pts/1      0:03 dd if /dev/zero of /mnt2040/


Thanks,
Badari

