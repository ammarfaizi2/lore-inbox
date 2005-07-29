Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVG2U2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVG2U2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVG2U2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:28:24 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:27015 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262808AbVG2U1Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:27:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cSSQAvFRHS3pFj2+1C/ia+sm9RvlrL7VrHpD11Lw0WJW0rnGgu3Lqi4tVmfLaTN8cnyIFFkp+K+AUjfolbibWhxSP/etrPmbwbXXlx++F+XNJG0MA+vpWv3VzQokvwWLXoku7ruQd87/pdIkA9q2LI0AI4Rz/xpMUvX7vLnYzNw=
Message-ID: <4ae3c140507291327143a9d83@mail.gmail.com>
Date: Fri, 29 Jul 2005 16:27:16 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why dump_stack results different so much?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to use dump_stack to dump the calling trace in the kernel.
What I did is  adding a dump_stack() call in the sys_open function.

Below is the dump out result:
Jul 28 17:33:31 normal kernel:  [<c0151601>] sys_open+0xa6/0xb7
Jul 28 17:33:31 normal kernel:  [<c0108e2c>] syscall_call+0x7/0xb

However, if I insert a new kernel module which does nothing but
pointing the orignal sys_open to our_sys_open(), and in
our_system_open(), I simply do return sys_open();

I supprisely noticed that the dump_stack results are quite different!
Why did I get the calling traces below our_ssy_open() and above
syscall_call()?  Any thought on this? Many thanks!

Jul 28 17:33:42 normal kernel:  [<c0151601>] sys_open+0xa6/0xb7
Jul 28 17:33:42 normal kernel:  [<d080f02c>] our_sys_open+0x2c/0x33 [trace]
Jul 28 17:33:42 normal kernel:  [<c0114984>] __wake_up+0x41/0x81
Jul 28 17:33:42 normal kernel:  [<c02c5e44>] sbf_read+0x5a/0x6f
Jul 28 17:33:42 normal kernel:  [<c01c4e12>] journal_stop+0x159/0x279
Jul 28 17:33:42 normal kernel:  [<c01b7aff>] ext3_mark_iloc_dirty+0x25/0x2f
Jul 28 17:33:42 normal kernel:  [<c02c5e44>] sbf_read+0x5a/0x6f
Jul 28 17:33:42 normal kernel:  [<c01b7bef>] ext3_mark_inode_dirty+0x3d/0x44
Jul 28 17:33:42 normal kernel:  [<c02c5e44>] sbf_read+0x5a/0x6f
Jul 28 17:33:42 normal kernel:  [<c01c583a>] __journal_file_buffer+0xbb/0x282
Jul 28 17:33:42 normal kernel:  [<c01546ed>] bh_lru_install+0xc3/0xdf
Jul 28 17:33:42 normal kernel:  [<c01c4169>] do_get_write_access+0x36f/0x5ea
Jul 28 17:33:42 normal kernel:  [<c01c583a>] __journal_file_buffer+0xbb/0x282
Jul 28 17:33:42 normal kernel:  [<c01c4a39>] journal_dirty_metadata+0xf4/0x16d
Jul 28 17:33:42 normal kernel:  [<c0114984>] __wake_up+0x41/0x81
Jul 28 17:33:42 normal kernel:  [<c01c4e12>] journal_stop+0x159/0x279
Jul 28 17:33:42 normal kernel:  [<c01b7aff>] ext3_mark_iloc_dirty+0x25/0x2f
Jul 28 17:33:42 normal kernel:  [<c01b7bef>] ext3_mark_inode_dirty+0x3d/0x44
Jul 28 17:33:42 normal kernel:  [<c01bc111>] __ext3_journal_stop+0x1e/0x44
Jul 28 17:33:42 normal kernel:  [<c01b7c5c>] ext3_dirty_inode+0x66/0x7b
Jul 28 17:33:42 normal kernel:  [<c01736fc>] __mark_inode_dirty+0xec/0x1ce
Jul 28 17:33:42 normal kernel:  [<c011cbd4>] current_fs_time+0x4d/0x5b
Jul 28 17:33:42 normal kernel:  [<c0107606>] __switch_to+0x2a/0x365
Jul 28 17:33:42 normal kernel:  [<c0107606>] __switch_to+0x2a/0x365
Jul 28 17:33:42 normal kernel:  [<c0132c3d>] find_get_page+0x30/0x6a
Jul 28 17:33:42 normal kernel:  [<c015f35b>] do_lookup+0x24/0x89
Jul 28 17:33:42 normal kernel:  [<c01686fc>] dput+0x95/0x252
Jul 28 17:33:42 normal kernel:  [<c015ff9d>] link_path_walk+0xbdd/0xe86
Jul 28 17:33:42 normal kernel:  [<c0121778>] free_uid+0x1c/0x6d
Jul 28 17:33:42 normal kernel:  [<c01e63de>] copy_to_user+0x3c/0x4a
Jul 28 17:33:42 normal kernel:  [<c015b519>] cp_new_stat64+0xf5/0x105
Jul 28 17:33:42 normal kernel:  [<c015b55a>] sys_stat64+0x31/0x36
Jul 28 17:33:42 normal kernel:  [<c0108e2c>] syscall_call+0x7/0xb
