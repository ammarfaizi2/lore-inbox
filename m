Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270012AbSISGiL>; Thu, 19 Sep 2002 02:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270014AbSISGiL>; Thu, 19 Sep 2002 02:38:11 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:8349 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S270012AbSISGiK> convert rfc822-to-8bit; Thu, 19 Sep 2002 02:38:10 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: sct@redhat.com, akpm@digeo.com
Subject: [BENCHMARK] EXT2 vs EXT3 System calls via oprofile using contest 0.34
Date: Thu, 19 Sep 2002 01:42:58 -0400
User-Agent: KMail/1.4.6
Cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200209190142.58122.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Each test ran for about 15 seconds:

EXT2 kernel calls
==========
c022e080 6533     2.96616     __make_request         /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c013df50 6592     2.99295     __block_prepare_write   /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c012e880 7765     3.52552     generic_file_write_nolock /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c0175020 8588     3.89919     ext2_get_branch         /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux

Top 3:

c013cf70 8678     3.94005     get_hash_table          /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c01752e0 10185    4.62427     ext2_get_block          /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c022f8c0 14293    6.48941     elevator_linus_merge    /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux

EXT3 kernel calls
==========

c015f1c0 10928    3.00962     ext3_new_block          /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c016bb40 11863    3.26713     journal_dirty_metadata  /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c016fac0 12292    3.38527     journal_cancel_revoke   /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c022f8c0 15519    4.27401     elevator_linus_merge    /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux

Top 3:

c013cf70 16380    4.51113     get_hash_table          /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c016b090 22883    6.30209     do_get_write_access     /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
c0164910 26375    7.2638      ext3_do_update_inode    /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux


Test preformed
=========

part of the contest package:

2) launch oprofile (if you use gui oprof_start &)

1) prepare commands
export tmpfile=foobar.log

before youn run io_halfmem click on "start profiler"
run io_halfmem

wait 15 seconds

op_time -l  which will dump the calls and time.
