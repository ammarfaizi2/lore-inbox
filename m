Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUBUFRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 00:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbUBUFRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 00:17:23 -0500
Received: from 200-207-51-215.dsl.telesp.net.br ([200.207.51.215]:896 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261467AbUBUFRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 00:17:17 -0500
Date: Sat, 21 Feb 2004 02:17:08 -0300
From: Lucas Gadani <lgadani@terra.com.br>
To: linux-kernel@vger.kernel.org
Subject: bad: scheduling while atomic!
Message-ID: <20040221051708.GA1100@127.0.0.1>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linux kernel version is vanilla 2.6.3. System is Debian/unstable.

Got the attached trace while I was removing a file from an ext3 fs.

Don't know if this is related, but system was doing a smart long
self-test while got this trace. So, I also attached a dump of "smartctl
-a".

-- 
Lucas

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="error.txt"

EXT3-fs error (device hdb5): ext3_free_blocks: bit already cleared for block 8457254
Aborting journal on device hdb5.
bad: scheduling while atomic!
Call Trace:
 [<c0118c48>] schedule+0x568/0x580
 [<c01d2851>] do_ide_request+0x11/0x20
 [<c01c18df>] generic_unplug_device+0x5f/0x80
 [<c0119b4e>] io_schedule+0xe/0x20
 [<c014dffb>] __wait_on_buffer+0xbb/0xc0
 [<c011a280>] autoremove_wake_function+0x0/0x40
 [<c01c2d35>] submit_bio+0x35/0x80
 [<c011a280>] autoremove_wake_function+0x0/0x40
 [<c015135a>] sync_dirty_buffer+0x3a/0xa0
 [<c018e84c>] journal_update_superblock+0x6c/0xc0
 [<c0185a88>] ext3_handle_error+0x48/0xa0
 [<c0185b18>] ext3_error+0x38/0x40
 [<c017bf37>] ext3_free_blocks+0x3d7/0x480
 [<c0180bbb>] ext3_free_data+0xbb/0x120
 [<c0180ceb>] ext3_free_branches+0xcb/0x1e0
 [<c0180ceb>] ext3_free_branches+0xcb/0x1e0
 [<c0181206>] ext3_truncate+0x406/0x520
 [<c018899f>] journal_start+0x7f/0xc0
 [<c017e9f5>] start_transaction+0x15/0x60
 [<c017eb59>] ext3_delete_inode+0x99/0xe0
 [<c017eac0>] ext3_delete_inode+0x0/0xe0
 [<c0164d41>] generic_delete_inode+0x61/0x100
 [<c0164f78>] iput+0x58/0x80
 [<c015b89d>] sys_unlink+0xdd/0x120
 [<c015d8c9>] sys_ioctl+0xc9/0x260
 [<c010a8a7>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118c48>] schedule+0x568/0x580
 [<c01d2851>] do_ide_request+0x11/0x20
 [<c01c18df>] generic_unplug_device+0x5f/0x80
 [<c01c1a2e>] blk_run_queues+0x6e/0xc0
 [<c0119b4e>] io_schedule+0xe/0x20
 [<c014dffb>] __wait_on_buffer+0xbb/0xc0
 [<c011a280>] autoremove_wake_function+0x0/0x40
 [<c01c2d35>] submit_bio+0x35/0x80
 [<c011a280>] autoremove_wake_function+0x0/0x40
 [<c015135a>] sync_dirty_buffer+0x3a/0xa0
 [<c0185a93>] ext3_handle_error+0x53/0xa0
 [<c0185b18>] ext3_error+0x38/0x40
 [<c017bf37>] ext3_free_blocks+0x3d7/0x480
 [<c0180bbb>] ext3_free_data+0xbb/0x120
 [<c0180ceb>] ext3_free_branches+0xcb/0x1e0
 [<c0180ceb>] ext3_free_branches+0xcb/0x1e0
 [<c0181206>] ext3_truncate+0x406/0x520
 [<c018899f>] journal_start+0x7f/0xc0
 [<c017e9f5>] start_transaction+0x15/0x60
 [<c017eb59>] ext3_delete_inode+0x99/0xe0
 [<c017eac0>] ext3_delete_inode+0x0/0xe0
 [<c0164d41>] generic_delete_inode+0x61/0x100
 [<c0164f78>] iput+0x58/0x80
 [<c015b89d>] sys_unlink+0xdd/0x120
 [<c015d8c9>] sys_ioctl+0xc9/0x260
 [<c010a8a7>] syscall_call+0x7/0xb

ext3_abort called.
EXT3-fs abort (device hdb5): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hdb5) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdb5) in ext3_truncate: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hdb5) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdb5) in ext3_orphan_del: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hdb5) in ext3_reserve_inode_write: Journal has aborted
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
EXT3-fs error (device hdb5) in ext3_delete_inode: Journal has aborted

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smartctl.txt"

smartctl version 5.26 Copyright (C) 2002-3 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     QUANTUM FIREBALLlct20 40
Serial Number:    754036117443
Firmware Version: APL.0900
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   5
ATA Standard is:  ATA/ATAPI-5 T13 1321D revision 1
Local Time is:    Sat Feb 21 01:58:11 2004 BRT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x05)	Offline data collection activity was
					aborted by an interrupting command from host.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (  32)	The self-test routine was interrupted
					by the host with a hard or soft reset.
Total time to complete Offline 
data collection: 		 (  51) seconds.
Offline data collection
capabilities: 			 (0x1b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					No Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  47) minutes.

SMART Attributes Data Structure revision number: 11
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x0029   100   253   020    Pre-fail  Offline      -       0
  3 Spin_Up_Time            0x0027   078   078   020    Pre-fail  Always       -       2791
  4 Start_Stop_Count        0x0032   097   097   008    Old_age   Always       -       2452
  5 Reallocated_Sector_Ct   0x0033   100   100   020    Pre-fail  Always       -       1
  7 Seek_Error_Rate         0x000b   100   093   023    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0012   087   087   001    Old_age   Always       -       8705
 10 Spin_Retry_Count        0x0026   100   095   000    Old_age   Always       -       0
 11 Calibration_Retry_Count 0x0013   100   100   020    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   097   097   008    Old_age   Always       -       2365
 13 Read_Soft_Error_Rate    0x000b   100   093   023    Pre-fail  Always       -       0
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always       -       31292
196 Reallocated_Event_Count 0x0010   100   100   020    Old_age   Offline      -       0
197 Current_Pending_Sector  0x0032   100   100   020    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x001a   200   020   000    Old_age   Always       -       4866

SMART Error Log Version: 0
No Errors Logged

SMART Self-test log structure revision number 0
Warning: ATA Specification requires self-test log structure revision number = 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Interrupted (host reset)      10%      8704         -
# 2  Short offline       Completed without error       00%      8681         -
# 3  Short offline       Completed without error       00%      8657         -
# 4  Short offline       Completed without error       00%      8633         -
# 5  Short offline       Completed without error       00%      8609         -
# 6  Extended offline    Completed without error       00%      8587         -


--82I3+IH0IqGh5yIs--
