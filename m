Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSEHJai>; Wed, 8 May 2002 05:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSEHJah>; Wed, 8 May 2002 05:30:37 -0400
Received: from grisu.bik-gmbh.de ([194.233.237.82]:5637 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S312581AbSEHJaf>; Wed, 8 May 2002 05:30:35 -0400
Date: Wed, 8 May 2002 11:32:23 +0200
To: linux-kernel@vger.kernel.org
Subject: [Ext3] kernel assertion failed
Message-ID: <20020508093222.GA358@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Florian Hars <hars@bik-gmbh.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whom it may concern:

My system just became unuseable during a rm -rf of three rather small
directories on an ext3-volume (some seconds after a rmdir failed because
they were not empty) with an assertion failure in the file revoke.c,
line 330: J_ASSERT_BH(bh, !test_bit(BH_Revoked, &bh->b_state));
The rm got a SIGSEGV.

After that, I could continue to do something, but all processes
accessing the problematic filesystem (/var) started to hang, so I
had to do a hard reboot after a while.

I use a 2.4.18-pre9 with the via-driver from 2.5.2 with assorted fixes
(to have support for my rather new southbridge), and the filesystem
resides on a lvm volume.

This happens reliably when I install and immediately purge a debian
package cyrus21-common.

After some fighting with kernel-recompiles and mount options, I have
been lucky to be able to copy and paste some output from xconsole
(/var/log was of course dead by the time this happened) to a file on a
clean filesystem, here it is:


May  8 11:11:58 prony kernel:      b_jbd:0 b_frozen_data:00000000 b_committed_data:00000000
May  8 11:11:58 prony kernel:      b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
May  8 11:11:58 prony kernel:      b_trans_is_comitting:0 b_jcount:0 
May  8 11:11:58 prony kernel:  ext3_forget() [inode.c:81] call ext3_journal_revoke
May  8 11:11:58 prony kernel:      b_state:0x3011 b_list:BUF_CLEAN b_jlist:BJ_None on_lru:0
May  8 11:11:58 prony kernel:      cpu:0 on_hash:1 b_count:1 b_blocknr:30403
May  8 11:11:58 prony kernel:      b_jbd:0 b_frozen_data:00000000 b_committed_data:00000000
May  8 11:11:58 prony kernel:      b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
May  8 11:11:58 prony kernel:      b_trans_is_comitting:0 b_jcount:0 
May  8 11:11:58 prony kernel:  journal_revoke() [revoke.c:286] enter
May  8 11:11:58 prony kernel:      b_state:0x3011 b_list:BUF_CLEAN b_jlist:BJ_None on_lru:0
May  8 11:11:58 prony kernel:      cpu:0 on_hash:1 b_count:1 b_blocknr:30403
May  8 11:11:58 prony kernel:      b_jbd:0 b_frozen_data:00000000 b_committed_data:00000000
May  8 11:11:58 prony kernel:      b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
May  8 11:11:58 prony kernel:      b_trans_is_comitting:0 b_jcount:0 
May  8 11:11:58 prony kernel:  __brelse() [buffer.c:1163] entry
May  8 11:11:58 prony kernel:      b_state:0x3011 b_list:BUF_CLEAN b_jlist:BJ_None on_lru:0
May  8 11:11:58 prony kernel:      cpu:0 on_hash:1 b_count:2 b_blocknr:30403
May  8 11:11:58 prony kernel:      b_jbd:0 b_frozen_data:00000000 b_committed_data:00000000
May  8 11:11:58 prony kernel:      b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
May  8 11:11:58 prony kernel:      b_trans_is_comitting:0 b_jcount:0 
May  8 11:11:58 prony kernel:  print_buffer_trace() [jbd-kernel.c:260] 
May  8 11:11:58 prony kernel:      b_state:0x3011 b_list:BUF_CLEAN b_jlist:BJ_None on_lru:0
May  8 11:11:58 prony kernel:      cpu:0 on_hash:1 b_count:1 b_blocknr:30403
May  8 11:11:58 prony kernel:      b_jbd:0 b_frozen_data:00000000 b_committed_data:00000000
May  8 11:11:58 prony kernel:      b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
May  8 11:11:58 prony kernel:      b_trans_is_comitting:0 b_jcount:0 
May  8 11:11:58 prony kernel: b_next:00000000, b_blocknr:30403 b_count:1 b_flushtime:14565
May  8 11:11:58 prony kernel: b_next_free:00000000 b_prev_free:00000000 b_this_page:da862c00 b_reqnext:00000000
May  8 11:11:58 prony kernel: b_pprev:dffcc06c b_data:da8e8000 b_page:c16a3a00 b_inode:00000000 b_list:0
May  8 11:11:58 prony kernel: daea7d08 da862c00 da862c00 da862c00 df918800 c014638f da862c00 c01603ff 
May  8 11:11:58 prony kernel:        da862c00 da862c00 00000000 d953a480 d98acbc0 c015249b d98acbc0 000076c3 
May  8 11:11:58 prony kernel:        da862c00 000076c3 da86b000 d98acbc0 d953a480 80008800 000076c3 da86b000 
May  8 11:11:58 prony kernel: Call Trace: [buffer_assertion_failure+15/32] [journal_revoke+319/608] [ext3_forget+251/400] [ext3_clear_blocks+319/368] [journal_get_write_access+64/96] 
May  8 11:11:58 prony kernel:    [ext3_free_data+236/416] [ext3_free_branches+616/640] [ext3_free_branches+230/640] [ext3_free_branches+230/640] [ext3_truncate+200/976] [ext3_truncate+743/976] 
May  8 11:11:58 prony kernel:    [journal_start+166/208] [start_transaction+92/144] [ext3_delete_inode+0/288] [ext3_delete_inode+163/288] [ext3_delete_inode+0/288] [iput+183/416] 
May  8 11:11:58 prony kernel:    [d_delete+76/112] [vfs_unlink+247/304] [sys_unlink+168/288] [system_call+51/56] 
May  8 11:11:58 prony kernel: 
May  8 11:11:58 prony kernel: invalid operand: 0000
May  8 11:11:58 prony kernel: CPU:    0
May  8 11:11:58 prony kernel: EIP:    0010:[journal_revoke+360/608]    Not tainted
May  8 11:11:58 prony kernel: EFLAGS: 00210286
May  8 11:11:58 prony kernel: eax: 000000c4   ebx: da862c00   ecx: df4d8000   edx: 00000001
May  8 11:11:58 prony kernel: esi: da862c00   edi: da862c00   ebp: df918800   esp: daea7d18
May  8 11:11:58 prony kernel: ds: 0018   es: 0018   ss: 0018
May  8 11:11:58 prony kernel: Process rm (pid: 636, stackpage=daea7000)
May  8 11:11:58 prony kernel: Stack: c0296e80 c0296f7f c0296dd3 0000014a c0297080 da862c00 00000000 d953a480 
May  8 11:11:58 prony kernel:        d98acbc0 c015249b d98acbc0 000076c3 da862c00 000076c3 da86b000 d98acbc0 
May  8 11:11:58 prony kernel:        d953a480 80008800 000076c3 da86b000 d98acbc0 c01544df d98acbc0 00000000 
May  8 11:11:58 prony kernel: Call Trace: [ext3_forget+251/400] [ext3_clear_blocks+319/368] [journal_get_write_access+64/96] [ext3_free_data+236/416] [ext3_free_branches+616/640] 
May  8 11:11:58 prony kernel:    [ext3_free_branches+230/640] [ext3_free_branches+230/640] [ext3_truncate+200/976] [ext3_truncate+743/976] [journal_start+166/208] [start_transaction+92/144] 
May  8 11:11:58 prony kernel:    [ext3_delete_inode+0/288] [ext3_delete_inode+163/288] [ext3_delete_inode+0/288] [iput+183/416] [d_delete+76/112] [vfs_unlink+247/304] 
May  8 11:11:58 prony kernel:    [sys_unlink+168/288] [system_call+51/56] 
May  8 11:11:58 prony kernel: 
May  8 11:11:58 prony kernel: Code: 0f 0b 83 c4 14 8d 76 00 b8 0c 00 00 00 0f ab 46 18 b8 0d 00 


I hope I have not reported something that was fixed between -pre9 and
-rc3, but the changelog doesn't mention any ext3 or journaling changes.

Yours, Florian Hars
