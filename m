Return-Path: <linux-kernel-owner+w=401wt.eu-S932630AbXAHIQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbXAHIQk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbXAHIQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:16:39 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:56630 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbXAHIQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:16:38 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 03:16:38 EST
Date: Mon, 08 Jan 2007 02:16:33 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.20-rc3-mm1 BUG: at arch/i386/mm/highmem.c:52
To: linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20070108071621.GA4308@pool-71-123-103-45.spfdma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine: Linux <...> 2.6.20-rc3-mm1 #2 Mon Jan 8 00:24:59 EST 2007 i686 unknown

In normal (light) use, I experienced a long (~20s?) freeze, and errors
regarding hdc appeared in dmesg, along with the BUG. SMART on hdc
doesn't report any errors except a bad SMART checksum (I think that
may have been there before). It may be a hardware problem, but I
figure the BUG is relevant anyway.

Anyway, here's the dmesg and SMART output:


hdc: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdc: no DRQ after issuing MULTWRITE_EXT
hda: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
BUG: at arch/i386/mm/highmem.c:52 kmap_atomic()
 [<c0114fff>] kmap_atomic+0xae/0x1b4
 [<c0316102>] ide_pio_sector+0x5e/0x11c
 [<c0316438>] pre_task_out_intr+0x9a/0xa5
 [<c0311b24>] ide_do_request+0x6d5/0x871
 [<c011f1e7>] getnstimeofday+0x2b/0xac
 [<c012c1ff>] do_clockevents_set_next_event+0x6f/0x76
 [<c012c333>] clockevents_set_next_event+0x70/0x7c
 [<c0312392>] ide_timer_expiry+0x223/0x230
 [<c012a4af>] hrtimer_interrupt+0x188/0x1b1
 [<c031216f>] ide_timer_expiry+0x0/0x230
 [<c011f535>] run_timer_softirq+0xe0/0x12f
 [<c011c238>] __do_softirq+0x35/0x75
 [<c011c29a>] do_softirq+0x22/0x26
 [<c011c4c7>] irq_exit+0x29/0x58
 [<c0106912>] do_IRQ+0x87/0x9d
 [<c0103b6d>] default_idle+0x0/0x39
 [<c0105543>] common_interrupt+0x23/0x28
 [<c0103b6d>] default_idle+0x0/0x39
 [<c0103b94>] default_idle+0x27/0x39
 [<c0103385>] cpu_idle+0x45/0x64
 [<c0664aaf>] start_kernel+0x303/0x307
 [<c066442b>] unknown_bootoption+0x0/0x20c
 =======================
ide1: reset: success
BUG: at arch/i386/mm/highmem.c:52 kmap_atomic()
 [<c0114fff>] kmap_atomic+0xae/0x1b4
 [<c0316102>] ide_pio_sector+0x5e/0x11c
 [<c0316438>] pre_task_out_intr+0x9a/0xa5
 [<c0311b24>] ide_do_request+0x6d5/0x871
 [<c013499e>] default_enable+0x12/0x1b
 [<c0134956>] check_irq_resend+0x12/0x48
 [<c0312dbd>] reset_pollfunc+0x0/0x188
 [<c0312392>] ide_timer_expiry+0x223/0x230
 [<c012a4af>] hrtimer_interrupt+0x188/0x1b1
 [<c031216f>] ide_timer_expiry+0x0/0x230
 [<c011f535>] run_timer_softirq+0xe0/0x12f
 [<c011c238>] __do_softirq+0x35/0x75
 [<c011c29a>] do_softirq+0x22/0x26
 [<c011c4c7>] irq_exit+0x29/0x58
 [<c0106912>] do_IRQ+0x87/0x9d
 [<c0105543>] common_interrupt+0x23/0x28
 [<c049963e>] __sched_text_start+0x49e/0x520
 [<c0499c23>] schedule_timeout+0x13/0x97
 [<c045cd4f>] unix_poll+0x25/0xa5
 [<c0159501>] do_sys_poll+0x253/0x325
 [<c0159f0e>] __pollwait+0x0/0xab
 [<c01160c3>] default_wake_function+0x0/0xc
 [<c011fcaa>] do_timer+0x5b3/0x702
 [<c0291acc>] mmx_clear_page+0x24/0x60
 [<c019bd7d>] journal_mark_dirty+0x184/0x286
 [<c0499624>] __sched_text_start+0x484/0x520
 [<c019799f>] pathrelse+0x18/0x2b
 [<c0127678>] autoremove_wake_function+0x0/0x35
 [<c019e180>] do_journal_end+0x335/0xb83
 [<c01153ff>] __activate_task+0x1c/0x28
 [<c01152d4>] __wake_up_common+0x31/0x4f
 [<c01152d4>] __wake_up_common+0x31/0x4f
 [<c0499e94>] mutex_lock+0xb/0x19
 [<c045dcde>] unix_stream_recvmsg+0x35f/0x40f
 [<c040667f>] sock_aio_read+0xc1/0xcd
 [<c0135774>] file_read_actor+0x0/0xd1
 [<c014fd43>] do_sync_read+0xc7/0x10a
 [<c0127678>] autoremove_wake_function+0x0/0x35
 [<c015053f>] vfs_read+0x9c/0x134
 [<c0159607>] sys_poll+0x34/0x37
 [<c0104b32>] sysenter_past_esp+0x5f/0x85
 =======================
BUG: soft lockup detected on CPU#0!
 [<c011fe65>] update_process_times+0x33/0x55
 [<c0129fdc>] hrtimer_sched_tick+0x5d/0x9e
 [<c012a445>] hrtimer_interrupt+0x11e/0x1b1
 [<c0107316>] timer_interrupt+0x1a/0x20
 [<c0133f99>] handle_IRQ_event+0x1a/0x3f
 [<c0134bb2>] handle_edge_irq+0xa5/0xd7
 [<c010690d>] do_IRQ+0x82/0x9d
 [<c016b277>] bio_add_page+0x31/0x37
 [<c0105543>] common_interrupt+0x23/0x28
 [<c03c1baa>] bitmap_daemon_work+0x48/0x251
 [<c03bf42c>] md_check_recovery+0x18/0x3f4
 [<c03162b9>] task_in_intr+0x0/0xe5
 [<c0133f99>] handle_IRQ_event+0x1a/0x3f
 [<c03aa7fb>] raid1d+0x24/0xc47
 [<c011c4de>] irq_exit+0x40/0x58
 [<c0106912>] do_IRQ+0x87/0x9d
 [<c03162af>] task_out_intr+0x93/0x9d
 [<c0499624>] __sched_text_start+0x484/0x520
 [<c0134bc6>] handle_edge_irq+0xb9/0xd7
 [<c0499c93>] schedule_timeout+0x83/0x97
 [<c011f6e9>] process_timeout+0x0/0x5
 [<c03c0d0e>] md_thread+0xc5/0xdb
 [<c0127678>] autoremove_wake_function+0x0/0x35
 [<c03c0c49>] md_thread+0x0/0xdb
 [<c012751b>] kthread+0xa0/0xc9
 [<c012747b>] kthread+0x0/0xc9
 [<c01056c3>] kernel_thread_helper+0x7/0x10
 =======================






=== START OF INFORMATION SECTION ===
Device Model:     Maxtor 6L300R0
Serial Number:    L60MDVEH
Firmware Version: BAH41E00
User Capacity:    300,090,728,448 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Mon Jan  8 02:12:10 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

Warning! SMART Attribute Thresholds Structure error: invalid SMART checksum.
=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
                                        without error or no self-test has ever 
                                        been run.
Total time to complete Offline 
data collection:                 (2343) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine 
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 119) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   182   182   063    Pre-fail  Always       -       27674
  4 Start_Stop_Count        0x0032   253   253   000    Old_age   Always       -       144
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  Always       -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  Offline      -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age   Always       -       0
  8 Seek_Time_Performance   0x0027   251   245   187    Pre-fail  Always       -       44375
  9 Power_On_Hours          0x0032   233   233   000    Old_age   Always       -       30303
 10 Spin_Retry_Count        0x002b   253   252   157    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x002b   252   252   223    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   253   253   000    Old_age   Always       -       38
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always       -       0
194 Temperature_Celsius     0x0032   035   253   000    Old_age   Always       -       30
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   Always       -       5376
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   Offline      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   Offline      -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   Always       -       0
202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always       -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always       -       0
207 Spin_High_Current       0x002a   253   252   000    Old_age   Always       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age   Always       -       0
209 Offline_Seek_Performnce 0x0024   241   241   000    Old_age   Offline      -       151
210 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
212 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0

Warning! SMART ATA Error Log Structure error: invalid SMART checksum.
SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%         2         -
# 2  Short offline       Completed without error       00%         0         -
# 3  Offline             Aborted by host               70%         0         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

