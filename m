Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265088AbTFCQic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTFCQic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:38:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:65208 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265088AbTFCQia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:38:30 -0400
Message-ID: <3EDCD20A.1070407@us.ibm.com>
Date: Tue, 03 Jun 2003 09:51:22 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm3
References: <20030531013716.07d90773.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm3/
> 
Re run 50 fsx tests overnight again on mm3.  The tests are all 
unresponsetive after running a while.  There are lots of disk errors and 
one call back trace:

Any idea?


SCSI disk error : <2 0 4 0> return code = 0x6000000
end_request: I/O error, dev sdf, sector 14030152
SCSI disk error : <2 0 0 0> return code = 0x6000000
end_request: I/O error, dev sdb, sector 10526936
SCSI disk error : <2 0 0 0> return code = 0x6000000
end_request: I/O error, dev sdb, sector 10533048
SCSI disk error : <2 0 0 0> return code = 0x6000000
end_request: I/O error, dev sdb, sector 10536376
SCSI disk error : <2 0 0 0> return code = 0x6000000
end_request: I/O error, dev sdb, sector 10538544
SCSI disk error : <2 0 0 0> return code = 0x6000000
end_request: I/O error, dev sdb, sector 10538688
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 10533024
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 10533088
SCSI disk error : <2 0 2 0> return code = 0x6000000
end_request: I/O error, dev sdd, sector 10540928
SCSI disk error : <2 0 4 0> return code = 0x6000000
end_request: I/O error, dev sdf, sector 10526936
SCSI disk error : <2 0 1 0> return code = 0x6000000
end_request: I/O error, dev sdc, sector 88488
SCSI disk error : <2 0 1 0> return code = 0x6000000
end_request: I/O error, dev sdc, sector 89176
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 10533776
SCSI disk error : <2 0 6 0> return code = 0x6000000
end_request: I/O error, dev sdh, sector 3566984
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 10533808
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 10533936
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 14005320
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 14022904
SCSI disk error : <2 0 4 0> return code = 0x6000000
end_request: I/O error, dev sdf, sector 10537240
SCSI disk error : <2 0 5 0> return code = 0x6000000
end_request: I/O error, dev sdg, sector 14023128
SCSI disk error : <2 0 4 0> return code = 0x6000000
buffer layer error at fs/buffer.c:2835
Call Trace:
  [<c015a760>] drop_buffers+0xc0/0xd0
  [<c015a7bb>] try_to_free_buffers+0x4b/0xb0
  [<c01a22ef>] journal_invalidatepage+0xdf/0x130
  [<c0193123>] ext3_invalidatepage+0x43/0x50
  [<c0141bb7>] do_invalidatepage+0x27/0x30
  [<c0141c4e>] truncate_complete_page+0x8e/0x90
  [<c0141dd4>] truncate_inode_pages+0xd4/0x2f0
  [<c01468fb>] vmtruncate+0x6b/0x100
  [<c01712f4>] inode_setattr+0x134/0x150
  [<c0194d5a>] ext3_setattr+0x7a/0x1a0
  [<c01603be>] cp_new_stat64+0xfe/0x110
  [<c01714e0>] notify_change+0x160/0x19d
  [<c015339a>] do_truncate+0x6a/0x90
  [<c0160487>] sys_fstat64+0x37/0x40
  [<c0153688>] sys_ftruncate+0x118/0x1b0
  [<c0154d50>] generic_file_llseek+0x0/0xf0
  [<c0155089>] sys_lseek+0x69/0xb0
  [<c010943f>] syscall_call+0x7/0xb


