Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRC0UDK>; Tue, 27 Mar 2001 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRC0UCv>; Tue, 27 Mar 2001 15:02:51 -0500
Received: from james.kalifornia.com ([208.179.59.2]:45922 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131512AbRC0UCt>; Tue, 27 Mar 2001 15:02:49 -0500
Message-ID: <3AC0F1BB.8DA05E94@blue-labs.org>
Date: Tue, 27 Mar 2001 12:02:03 -0800
From: David Ford <david@blue-labs.org>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: sysrq-t followup to possible reiserfs bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the trace, this time it didn't die on me.

 mozilla-bin  D CDC1779C     0  6530      1        (NOTLB)          6533

 Call Trace: [<ff000000>] [<ff000000>] [<ff000000>] [<e0000000>]
[<e0000000>] [<e0000000>] [<e0000000>]
        [<e0000000>] [<e0000000>] [<e0000000>] [<e0000000>] [<e0000000>]
[<e0000000>] [<e0000000>] [<e0000000>]
        [<e0000000>] [<fff801a1>] [<f2a9a870>]
        [scsi_queue_next_request+62/248] [__scsi_end_request+327/340]
        [scsi_io_completion+394/880] [rw_intr+459/472]
[scsi_old_done+67/1416]
        [scsi_old_done+1399/1416] [is_tree_node+55/84]
[search_by_key+2059/3172]
        [is_tree_node+55/84] [search_by_key+2059/3172]
        [search_for_position_by_key+170/896]
[search_for_position_by_key+551/896]
        [make_cpu_key+57/64] [_get_block_create_0+133/1012]
        [pathrelse+28/44] [_get_block_create_0+413/1012] [<f0000000>]
        [__alloc_pages+222/720] [schedule+624/916] [get_cnode+17/112]
        [journal_mark_dirty+473/776] [<d1478044>]
[check_journal_end+531/572]
        [do_journal_end+177/2652] [journal_end+22/28]
[reiserfs_dirty_inode+75/92]
        [__mark_inode_dirty+46/112]
        [down_write_failed+89/120] [__down_write_failed+17/32]
        [stext_lock+95/8170] [system_call+51/56]

 mozilla-bin  D CDC1779C    12  6533      1        (NOTLB)    6530  1516

 Call Trace: [<ff000000>] [<ff000000>] [<ff000000>]
        [schedule+624/916] [get_cnode+17/112]
        [journal_mark_dirty+473/776] [<d1478044>]
        [check_journal_end+531/572] [do_journal_end+177/2652]
[journal_end+22/28]
        [reiserfs_dirty_inode+75/92] [__mark_inode_dirty+46/112]
        [down_write_failed+89/120] [__down_write_failed+17/32]
        [stext_lock+95/8170] [system_call+51/56]


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



