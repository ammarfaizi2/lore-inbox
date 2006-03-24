Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWCXByu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWCXByu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWCXByu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:54:50 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:22195 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751513AbWCXBys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:54:48 -0500
Message-ID: <008701c64ee5$e9c16200$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Badari Pulavarty" <pbadari@us.ibm.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>,
       "ext2-devel" <Ext2-devel@lists.sourceforge.net>
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp> <1142630359.15257.30.camel@dyn9047017100.beaverton.ibm.com> <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp> <1143071143.6086.70.camel@dyn9047017100.beaverton.ibm.com> <1143137788.6086.97.camel@dyn9047017100.beaverton.ibm.com>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Date: Fri, 24 Mar 2006 10:54:35 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I'm very busy this week, so I'll look into it next week.


>> Okay. I tested your patches and mkfs changes.
>> 
>> I am able to create a >8TB filesystem and was able to
>> mount it :)
>> 
>> elm3b29:~ # df
>> Filesystem           1K-blocks      Used Available Use% Mounted on
>> /dev/hda2             79366980  76545536   2821444  97% /
>> tmpfs                  3574032         8   3574024   1% /dev/shm
>> /dev/md0             9833697924    131228 9677640816   1% /mnt
>> 
>> I run single "fsx" tests and quickly ran into issues. fsx complained
>> about data mismatch :(
>> 
>> Here is the "dmesg" output:
>> 
>> EXT3 FS on md0, internal journal
>> EXT3-fs: mounted filesystem with ordered data mode.
>> EXT3-fs error (device md0): ext3_new_block: Allocating block in system
>> zone - block = 131072
>> Aborting journal on device md0.
>> ext3_abort called.
>> EXT3-fs error (device md0): ext3_journal_start_sb: Detected aborted
>> journal
>> Remounting filesystem read-only
>> fsx-linux[15668]: segfault at fffffffffffffffb rip 00002b33b3eddda0 rsp
>> 00007fffffef1e38 error 4
>> fsx-linux[15667]: segfault at fffffffffffffffb rip 00002b7736f5dda0 rsp
>> 00007fffffb70da8 error 4
>> ext3_new_block: block was unexpectedly set in b_committed_data
>> EXT3-fs error (device md0) in ext3_reserve_inode_write: Journal has
>> aborted
>> fsx-linux[15666]: segfault at fffffffffffffffb rip 00002b0582de6da0 rsp
>> 00007fffffd24f18 error 4
>> fsx-linux[15669]: segfault at 00000000ffffffff rip 00002ad94d283da0 rsp
>> 00007fffff95aa28 error 4
>> __journal_remove_journal_head: freeing b_committed_data
>> __journal_remove_journal_head: freeing b_committed_data
>> __journal_remove_journal_head: freeing b_committed_data
> 
> More information. I ran the test with "-onoreservation" thinking that
> the patch didn't address "reservation code" issues and I still ran
> into block allocation problems. Hope this helps.
> 
> EXT3 FS on md0, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> EXT3-fs error (device md0): ext3_new_block: block(3304604584) >= blocks
> count(2497616320) - block_group = 4, es == ffff8101dee44400
> Aborting journal on device md0.
> ext3_abort called.
> EXT3-fs error (device md0): ext3_journal_start_sb: Detected aborted
> journal
> Remounting filesystem read-only
> fsx-linux[18270]: segfault at fffffffffffffffb rip 00002b9eae932da0 rsp
> 00007fffffbf73d8 error 4
> fsx-linux[18271]: segfault at fffffffffffffffb rip 00002aafb6ebada0 rsp
> 00007fffffaf0e58 error 4
> fsx-linux[18272]: segfault at fffffffffffffffb rip 00002abcc19b7da0 rsp
> 00007fffffde6348 error 4
> EXT3-fs error (device md0) in ext3_prepare_write: IO failure
> __journal_remove_journal_head: freeing b_committed_data
> journal commit I/O error
> fsx-linux[18273]: segfault at fffffffffffffffb rip 00002b6b16724da0 rsp
> 00007ffffff8f5e8 error 4
> 
> 
> Thanks,
> Badari
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel
