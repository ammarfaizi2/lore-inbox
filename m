Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVEDRoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVEDRoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEDRoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:44:00 -0400
Received: from mail.artstyle.ru ([193.192.129.1]:22144 "EHLO mail.artstyle.ru")
	by vger.kernel.org with ESMTP id S261209AbVEDRny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:43:54 -0400
Date: Wed, 4 May 2005 21:43:50 +0400
From: cron <cron@artstyle.ru>
To: linux-kernel@vger.kernel.org
Subject: Assertion failure in log_do_checkpoint(): "drop_count != 0 || cleanup_ret != 0"
Message-ID: <20050504174350.GA2498@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a 2.6.12-rc3 spontaneous reboot on i386 SMP after about 20h of 
moderate web serving. 2.6.11-rc1-bk6 works well for a week or more but
leaks memory at about 16 Mb/day and needs reboot thereafter. :(

Can you please give advice how to interpret this log:

Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:365: "drop_count != 0 || cleanup_ret != 0"
------------[ cut here ]------------
kernel BUG at <bad filename>:49643!
invalid operand: 0000 [#1]
SMP 
Modules linked in: iptable_mangle iptable_nat ip_conntrack fan button ac battery iptable_filter ip_tables ipmi_si ipmi_devintf ipmi_msghandler w83627hf_wdt adm1021 eeprom w83781d i2c_sensor i2c_isa i2c_i801 i2c_dev i2c_core e1000 e100 mii
CPU:    1
EIP:    0060:[log_do_checkpoint+331/384]    Not tainted VLI
EFLAGS: 00010296   (2.6.12-rc3) 
EIP is at log_do_checkpoint+0x14b/0x180
eax: 00000071   ebx: e1130d48   ecx: c03c2990   edx: 00000286
esi: 00000000   edi: e1130d48   ebp: c19cfe00   esp: f513db18
ds: 007b   es: 007b   ss: 0068
Process exim4 (pid: 15677, threadinfo=f513c000 task=dd287530)
Stack: c036f480 c0346f36 c036d689 0000016d c0372980 00c5a049 e1130d48 f7771900 
       c19cfec0 00000000 00000000 000003e7 c02966e5 c02962c3 00000000 00000004 
       c048defc 00000000 00000000 f513dba8 c01175a6 c01efcf9 00000000 00000118 
Call Trace:
 [ata_check_status+21/32] ata_check_status+0x15/0x20
 [ata_tf_load_pio+275/416] ata_tf_load_pio+0x113/0x1a0
 [find_busiest_group+214/752] find_busiest_group+0xd6/0x2f0
 [__delay+9/16] __delay+0x9/0x10
 [load_balance_newidle+48/144] load_balance_newidle+0x30/0x90
 [schedule+955/3200] schedule+0x3bb/0xc80
 [schedule+1007/3200] schedule+0x3ef/0xc80
 [as_next_request+47/64] as_next_request+0x2f/0x40
 [elv_next_request+26/320] elv_next_request+0x1a/0x140
 [scsi_request_fn+78/944] scsi_request_fn+0x4e/0x3b0
 [__mod_timer+244/304] __mod_timer+0xf4/0x130
 [__log_wait_for_space+158/192] __log_wait_for_space+0x9e/0xc0
 [start_this_handle+271/944] start_this_handle+0x10f/0x3b0
 [sync_buffer+0/64] sync_buffer+0x0/0x40
 [out_of_line_wait_on_bit+147/160] out_of_line_wait_on_bit+0x93/0xa0
 [wake_bit_function+0/96] wake_bit_function+0x0/0x60
 [wake_bit_function+0/96] wake_bit_function+0x0/0x60
 [__wait_on_buffer+47/64] __wait_on_buffer+0x2f/0x40
 [sync_dirty_buffer+93/224] sync_dirty_buffer+0x5d/0xe0
 [__journal_remove_journal_head+190/464] __journal_remove_journal_head+0xbe/0x1d0
 [journal_start+157/192] journal_start+0x9d/0xc0
 [cleanup_journal_tail+156/272] cleanup_journal_tail+0x9c/0x110
 [ext3_prepare_write+63/320] ext3_prepare_write+0x3f/0x140
 [generic_file_buffered_write+416/1520] generic_file_buffered_write+0x1a0/0x5f0
 [current_fs_time+97/128] current_fs_time+0x61/0x80
 [inode_update_time+75/192] inode_update_time+0x4b/0xc0
 [__generic_file_aio_write_nolock+811/1360] __generic_file_aio_write_nolock+0x32b/0x550
 [avc_has_perm+90/112] avc_has_perm+0x5a/0x70
 [generic_file_aio_write+92/192] generic_file_aio_write+0x5c/0xc0
 [ext3_file_write+48/192] ext3_file_write+0x30/0xc0
 [do_sync_write+154/208] do_sync_write+0x9a/0xd0
 [selinux_file_permission+254/320] selinux_file_permission+0xfe/0x140
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [vfs_write+195/288] vfs_write+0xc3/0x120
 [sys_write+71/128] sys_write+0x47/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 36 c0 b8 80 29 37 c0 89 44 24 10 b8 6d 01 00 00 89 44 24 0c b8 89 d6 36 c0 89 44 24 08 b8 36 6f 34 c0 89 44 24 04 e8 f5 22 f7 ff <0f> 0b eb c1 90 8d 4c 24 24 89 e8 8d 54 24 2c e8 e1 fc ff ff e9 

Please CC me in reply,
Thanx!

-- 
/cron
