Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbUKHHsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUKHHsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUKHHsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:48:50 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:43535 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261769AbUKHHsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:48:24 -0500
Message-ID: <418F255D.80409@mrv.com>
Date: Mon, 08 Nov 2004 09:50:53 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
In-Reply-To: <20041106155720.GA14950@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------030705090104000506080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705090104000506080600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.18 Real-Time Preemption patch, which can be
> downloaded from:
> 
>    http://redhat.com/~mingo/realtime-preempt/

I got the attached oops on 2.6.10-rc1-mm3-RT-V0.7.18 (probably during the
daily cron job). Later in the morning when I tried to access some 
filesystems
I got the attached deadlock report.
Relevant parts of the config:
...
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_REALTIME=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
...
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_PREEMPT_TIMING=y
# CONFIG_LATENCY_TRACE is not set
CONFIG_RT_DEADLOCK_DETECT=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set
...

-- 
Eran Mann
Tel: 972-4-9936297
Fax: 972-4-9890430

--------------030705090104000506080600
Content-Type: text/plain;
 name="oops2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops2"

Nov  8 04:19:32 eran kernel: BUG at include/linux/spinlock.h:767!
Nov  8 04:19:32 eran kernel: ------------[ cut here ]------------
Nov  8 04:19:32 eran kernel: kernel BUG at include/linux/spinlock.h:767!
Nov  8 04:19:32 eran kernel: invalid operand: 0000 [#1]
Nov  8 04:19:32 eran kernel: PREEMPT
Nov  8 04:19:32 eran kernel: Modules linked in: snd_via82xx snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore md5 ipv6 autofs 3c59x mii parport_pc parport nls_cp437 nls_iso8859_1 ntfs usbcore video thinkpad_acpi thermal processor fan button battery ac rtc
Nov  8 04:19:32 eran kernel: CPU:    0
Nov  8 04:19:32 eran kernel: EIP:    0060:[<c01e5a65>]    Not tainted VLI
Nov  8 04:19:32 eran kernel: EFLAGS: 00010286   (2.6.10-rc1-mm3-RT-V0.7.18)
Nov  8 04:19:32 eran kernel: EIP is at __try_to_free_cp_buf+0xc5/0xd0
Nov  8 04:19:32 eran kernel: eax: 00000025   ebx: ce29bfbc   ecx: 00000001   edx: 00000000
Nov  8 04:19:32 eran kernel: esi: 000002ff   edi: cf1f8760   ebp: cfa05d5c   esp: cfa05d48
Nov  8 04:19:32 eran kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Nov  8 04:19:32 eran kernel: Process kjournald (pid: 1445, threadinfo=cfa04000 task=cf9866c0)
Nov  8 04:19:32 eran kernel: Stack: c03ecd70 c03f40ba 000002ff ce55f20c ce55f1dc cfa05d88 c01e643d ce55f20c
Nov  8 04:19:32 eran kernel:        cfa04000 ce55f1dc 00000000 cf1f8760 cf1f8760 00000000 cd659880 00000000
Nov  8 04:19:32 eran kernel:        cfa05f28 c01e3563 cf4ebc00 cf1f8760 00000003 00009f35 cf3a7770 cf3a7770
Nov  8 04:19:32 eran kernel: Call Trace:
Nov  8 04:19:32 eran kernel:  [<c01080bf>] show_stack+0x7f/0xa0 (28)
Nov  8 04:19:32 eran kernel:  [<c0108275>] show_registers+0x165/0x1d0 (56)
Nov  8 04:19:32 eran kernel:  [<c010848c>] die+0xec/0x190 (64)
Nov  8 04:19:32 eran kernel:  [<c0108a5e>] do_invalid_op+0x11e/0x120 (192)
Nov  8 04:19:32 eran kernel:  [<c0107d07>] error_code+0x2b/0x30 (80)
Nov  8 04:19:32 eran kernel:  [<c01e643d>] __journal_clean_checkpoint_list+0x5d/0x90 (44)
Nov  8 04:19:32 eran kernel:  [<c01e3563>] journal_commit_transaction+0x273/0x1ac0 (416)
Nov  8 04:19:32 eran kernel:  [<c01e7d9d>] kjournald+0x18d/0x430 (196)
Nov  8 04:19:32 eran kernel:  [<c0105315>] kernel_thread_helper+0x5/0x10 (811573268)
Nov  8 04:19:32 eran kernel: Code: 4f 00 00 89 1c 24 e8 7b de f7 ff eb 9b c7 04 24 70 cd 3e c0 b9 ba 40 3f c0 be ff 02 00 00 89 74 24 08 89 4c 24 04 e8 2b 9f f3 ff <0f> 0b ff 02 ba 40 3f c0 eb bd 90 55 89 e5 57 56 53 83 ec 08 8b
Nov  8 04:19:32 eran kernel:  kjournald:1445 BUG: lock held at task exit time!
Nov  8 04:19:32 eran kernel:  [cf4ebc14] {&journal->j_state_lock}
Nov  8 04:19:32 eran kernel: .. held by:         kjournald/ 1445 [cf9866c0, 115]Nov  8 04:19:32 eran kernel: ... acquired at:  journal_commit_transaction+0xdf/0x1ac0
Nov  8 04:19:32 eran kernel: kjournald:1445 BUG: lock held at task exit time!
Nov  8 04:19:32 eran kernel:  [cf4ebe50] {&journal->j_list_lock}
Nov  8 04:19:32 eran kernel: .. held by:         kjournald/ 1445 [cf9866c0, 115]Nov  8 04:19:32 eran kernel: ... acquired at:  journal_commit_transaction+0x268/0x1ac0
Nov  8 07:20:22 eran kernel: IRQ#7 thread RT prio: 39.

2.6.10-rc1-mm3-RT-V0.7.18

--------------030705090104000506080600
Content-Type: text/plain;
 name="deadlock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="deadlock"

 [<c01080bf>] show_stack+0x7f/0xa0 (28)
 [<c0108275>] show_registers+0x165/0x1d0 (56)
 [<c010848c>] die+0xec/0x190 (64)
 [<c0108a5e>] do_invalid_op+0x11e/0x120 (192)
 [<c0107d07>] error_code+0x2b/0x30 (80)
 [<c01e643d>] __journal_clean_checkpoint_list+0x5d/0x90 (44)
 [<c01e3563>] journal_commit_transaction+0x273/0x1ac0 (416)
 [<c01e7d9d>] kjournald+0x18d/0x430 (196)
 [<c0105315>] kernel_thread_helper+0x5/0x10 (811573268)
Code: 4f 00 00 89 1c 24 e8 7b de f7 ff eb 9b c7 04 24 70 cd 3e c0 b9 ba 40 3f c0 be ff 02 00 00 89 74 24 08 89 4c 24 04 e8 2b 9f f3 ff <0f> 0b ff 02 ba 40 3f c0 eb bd 90 55 89 e5 57 56 53 83 ec 08 8b
 kjournald:1445 BUG: lock held at task exit time!
 [cf4ebc14] {&journal->j_state_lock}
.. held by:         kjournald/ 1445 [cf9866c0, 115]
... acquired at:  journal_commit_transaction+0xdf/0x1ac0
kjournald:1445 BUG: lock held at task exit time!
 [cf4ebe50] {&journal->j_list_lock}
.. held by:         kjournald/ 1445 [cf9866c0, 115]
... acquired at:  journal_commit_transaction+0x268/0x1ac0
IRQ#7 thread RT prio: 39.
 
============================================
[ BUG: circular locking deadlock detected! ]
--------------------------------------------
bash/3986 is deadlocking current task bash/10630
 
 
1) bash/10630 is trying to acquire this lock:
 [cdc048e0] {&inode->i_sem}
.. held by:              bash/ 3986 [c8c87890, 115]
... acquired at:  vfs_readdir+0x53/0xa0
... trying at:   vfs_readdir+0x53/0xa0
 
2) bash/3986 is blocked on this lock:
 [cf4ebc14] {&journal->j_state_lock}
.. held by:              bash/10630 [cf9866c0, 115]
... acquired at:  journal_commit_transaction+0xdf/0x1ac0
 
------------------------------
| showing all locks held by: |  (bash/10630 [cf9866c0, 115]):
------------------------------
 
------------------------------
| showing all locks held by: |  (bash/3986 [c8c87890, 115]):
------------------------------
 
#001:             [cdc048e0] {&inode->i_sem}
... acquired at:  vfs_readdir+0x53/0xa0
 
bash/3986's [blocked] stackdump:
 
c3873d70 00000086 c8c87890 c0560060 c04a0440 00000001 00000246 c8c87890
       c01451f9 00000001 c044f318 c044f318 00000001 00000000 24535cc0 000f7cf3
       c8c87a54 c3872000 c3872000 c8c87890 c3873d94 c03c981b c044f318 00000282
Call Trace:
 [<c03c981b>] schedule+0x3b/0x130 (36)
 [<c03cae11>] __down_mutex+0x311/0x3b0 (84)
 [<c0138091>] __spin_lock+0x31/0x40 (24)
 [<c01380b8>] _spin_lock+0x18/0x20 (16)
 [<c01dfb96>] start_this_handle+0x66/0x4f0 (152)
 [<c01e0136>] journal_start+0xc6/0xf0 (40)
 [<c01d41e8>] ext3_dirty_inode+0x38/0xd0 (36)
 [<c01855e1>] __mark_inode_dirty+0x1d1/0x1e0 (64)
 [<c017cde1>] update_atime+0xd1/0xe0 (52)
 [<c01747b3>] vfs_readdir+0x93/0xa0 (36)
 [<c0174bdb>] sys_getdents64+0x6b/0xb0 (48)
 [<c010720d>] sysenter_past_esp+0x52/0x71 (-8124)
 
bash/10630's [current] stackdump:
 
 [<c01080fe>] dump_stack+0x1e/0x30 (20)
 [<c0136313>] check_deadlock+0x1c3/0x2a0 (44)
 [<c0136a22>] task_blocks_on_lock+0x1b2/0x1d0 (48)
 [<c03ca976>] __down+0x226/0x350 (76)
 [<c0137abe>] down+0x2e/0x160 (48)
 [<c0174773>] vfs_readdir+0x53/0xa0 (36)
 [<c0174bdb>] sys_getdents64+0x6b/0xb0 (48)
 [<c010720d>] sysenter_past_esp+0x52/0x71 (-8124)
 
showing all tasks:
s            init/    1 [c1279770, 116] (not blocked)
s     ksoftirqd/0/    2 [c12791a0, 105] (not blocked)
s       desched/0/    3 [c1278bd0, 105] (not blocked)
s        events/0/    4 [c1278600,  98] (not blocked)
s         khelper/    5 [c1278030, 106] (not blocked)
s         kthread/   10 [cffdb790, 105] (not blocked)
s          kacpid/   18 [cffdb1c0, 115] (not blocked)
s           IRQ 9/   19 [cffdabf0, 115] (not blocked)
s       kblockd/0/   67 [cffda620, 105] (not blocked)
s         pdflush/  133 [cffda050, 116] (not blocked)
s         pdflush/  134 [cfebb7b0, 116] (not blocked)
s           aio/0/  136 [cfebac10, 106] (not blocked)
s         kswapd0/  135 [cfebb1e0, 116] (not blocked)
s          IRQ 12/  748 [cfeba070,  53] (not blocked)
s           IRQ 6/  763 [c13ab7d0,  50] (not blocked)
s         kseriod/  742 [cfeba640, 125] (not blocked)
s          IRQ 14/  786 [c13ab200,  51] (not blocked)
s          IRQ 15/  789 [c13aac30,  52] (not blocked)
s           IRQ 1/  819 [c13aa660,  54] (not blocked)
s      reiserfs/0/  824 [c13aa090, 105] (not blocked)
s           IRQ 8/ 1163 [cf987260,  55] (not blocked)
s           khubd/ 1357 [cf1b4820, 119] (not blocked)
s           IRQ 4/ 1604 [cf987830,  56] (not blocked)
s           IRQ 3/ 1605 [cfbb2700,  57] (not blocked)
s           IRQ 7/ 1637 [cf3a7770,  60] (not blocked)
s          IRQ 10/ 1970 [cf9860f0,  58] (not blocked)
s          IRQ 11/ 2044 [cf5c87a0,  59] (not blocked)
s          dhcpcd/ 2056 [cf5c8d70, 117] (not blocked)
s         syslogd/ 2097 [cfbb3870, 116] (not blocked)
s           klogd/ 2101 [cf2a39b0, 116] (not blocked)
s         portmap/ 2127 [cf1b5990, 116] (not blocked)
s       rpc.statd/ 2146 [cf1b53c0, 119] (not blocked)
s           rsync/ 2223 [cf2a2270, 118] (not blocked)
s             atd/ 2281 [cfd0c0b0, 116] (not blocked)
s          smartd/ 2291 [cf3a6600, 116] (not blocked)
s            sshd/ 2300 [cf1b4df0, 121] (not blocked)
s          xinetd/ 2313 [cd4a2bf0, 117] (not blocked)
s           dhcpd/ 2322 [cf2a33e0, 119] (not blocked)
s        sendmail/ 2339 [cf1b4250, 116] (not blocked)
s        sendmail/ 2347 [cfd0cc50, 117] (not blocked)
s             gpm/ 2357 [cd4a3790, 116] (not blocked)
s           crond/ 2366 [cfd0d7f0, 116] (not blocked)
s             xfs/ 2394 [cf986c90, 116] (not blocked)
s   dbus-daemon-1/ 2411 [cd4a31c0, 116] (not blocked)
s           cupsd/ 2422 [cfd0c680, 116] (not blocked)
s        mingetty/ 2632 [cfbb2cd0, 119] (not blocked)
s        mingetty/ 2633 [cf5c9910, 119] (not blocked)
s        mingetty/ 2634 [cf3a6bd0, 119] (not blocked)
s        mingetty/ 2635 [cf2a2e10, 118] (not blocked)
s        mingetty/ 2638 [cf5c9340, 118] (not blocked)
s        mingetty/ 2639 [cf2a2840, 118] (not blocked)
s      gdm-binary/ 2640 [cf5c81d0, 116] (not blocked)
s      gdm-binary/ 2875 [cc3271e0, 117] (not blocked)
s               X/ 2888 [cc366c30, 115] (not blocked)
s   gnome-session/ 2923 [cfd0d220, 115] (not blocked)
s       ssh-agent/ 2985 [cd4a2620, 116] (not blocked)
s        gconfd-2/ 2996 [cc366090, 116] (not blocked)
s bonobo-activati/ 3519 [c8d1ed10, 116] (not blocked)
s gnome-settings-/ 3521 [cc326070, 115] (not blocked)
s    xscreensaver/ 3917 [cc367200, 115] (not blocked)
s   gnome-smproxy/ 3944 [cc366660, 117] (not blocked)
s        metacity/ 3946 [cf3a6030, 115] (not blocked)
s     gnome-panel/ 3948 [c92ff260, 115] (not blocked)
s        nautilus/ 3950 [c92fec90, 115] (not blocked)
s        nautilus/ 3955 [cc3677d0, 116] (not blocked)
s        nautilus/ 3956 [cfbb32a0, 117] (not blocked)
s        nautilus/ 3957 [c892a230, 116] (not blocked)
s        nautilus/ 3958 [c8d1f2e0, 115] (not blocked)
s        nautilus/ 3959 [c8c86150, 117] (not blocked)
s        nautilus/ 3960 [c8d1f8b0, 116] (not blocked)
s        nautilus/ 3961 [c8d1e170, 116] (not blocked)
s        nautilus/ 3962 [c8d1e740, 116] (not blocked)
s        nautilus/ 3963 [cd4a2050, 116] (not blocked)
s        nautilus/ 3964 [cf3a71a0, 116] (not blocked)
s        magicdev/ 3952 [cc326640, 115] (not blocked)
R  gnome-terminal/ 3954 [c8ac4e50, 116] (not blocked)
s  mapping-daemon/ 3966 [c8ac4880, 116] (not blocked)
s gnome-pty-helpe/ 3985 [c8c86720, 116] (not blocked)
D            bash/ 3986 [c8c87890, 115] blocked on: [cf4ebc14] {&journal->j_state_lock}
.. held by:              bash/10630 [cf9866c0, 115]
... acquired at:  journal_commit_transaction+0xdf/0x1ac0
s notification-ar/ 3988 [c8c872c0, 115] (not blocked)
s            bash/ 3989 [c8c86cf0, 115] (not blocked)
s     wnck-applet/ 4029 [c892b970, 115] (not blocked)
s multiload-apple/ 4071 [c892a800, 116] (not blocked)
s    gkb-applet-2/ 4079 [c892b3a0, 115] (not blocked)
s            tail/ 4166 [c8ac42b0, 116] (not blocked)
s     thunderbird/10586 [cc3277b0, 118] (not blocked)
s  run-mozilla.sh/10598 [c92ff830, 119] (not blocked)
s thunderbird-bin/10603 [cc326c10, 115] (not blocked)
s thunderbird-bin/10604 [cfbb2130, 116] (not blocked)
s thunderbird-bin/10606 [c8ac5420, 116] (not blocked)
D            bash/10630 [cf9866c0, 115] (not blocked)
 
---------------------------
| showing all locks held: |
---------------------------
 
#001:             [c057a080] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#002:             [c0579c94] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#003:             [c0579e70] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#004:             [c057a6fc] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#005:             [c057a310] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#006:             [c057a4ec] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#007:             [c057ad78] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#008:             [c057a98c] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#009:             [c057ab68] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#010:             [c057b3f4] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#011:             [c057b008] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#012:             [c057b1e4] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#013:             [c057ba70] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#014:             [c057b684] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#015:             [c057b860] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#016:             [c057c0ec] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#017:             [c057bd00] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#018:             [c057bedc] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#019:             [c057c768] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#020:             [c057c37c] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#021:             [c057c558] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#022:             [c057cde4] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#023:             [c057c9f8] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#024:             [c057cbd4] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#025:             [c057d460] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#026:             [c057d074] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#027:             [c057d250] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#028:             [c057dadc] {&hwif->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x98/0x180
 
#029:             [c057d6f0] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#030:             [c057d8cc] {&drive->gendev_rel_sem}
.. held by:              init/    1 [c1279770, 116]
... acquired at:  init_hwif_data+0x16d/0x180
 
#031:             [cfd07cf0] {&tty->atomic_read}
.. held by:          mingetty/ 2632 [cfbb2cd0, 119]
... acquired at:  read_chan+0x6c9/0x720
 
#032:             [cc280cf0] {&tty->atomic_read}
.. held by:          mingetty/ 2633 [cf5c9910, 119]
... acquired at:  read_chan+0x6c9/0x720
 
#033:             [cc349cf0] {&tty->atomic_read}
.. held by:          mingetty/ 2638 [cf5c9340, 118]
... acquired at:  read_chan+0x6c9/0x720
 
#034:             [cc39fcf0] {&tty->atomic_read}
.. held by:          mingetty/ 2639 [cf2a2840, 118]
... acquired at:  read_chan+0x6c9/0x720
 
#035:             [cc32bcf0] {&tty->atomic_read}
.. held by:          mingetty/ 2635 [cf2a2e10, 118]
... acquired at:  read_chan+0x6c9/0x720
 
#036:             [cc3e1cf0] {&tty->atomic_read}
.. held by:          mingetty/ 2634 [cf3a6bd0, 119]
... acquired at:  read_chan+0x6c9/0x720
 
#037:             [c4031cf0] {&tty->atomic_read}
.. held by:              bash/ 3989 [c8c86cf0, 115]
... acquired at:  read_chan+0x6c9/0x720
 
#038:             [cdc048e0] {&inode->i_sem}
.. held by:              bash/ 3986 [c8c87890, 115]
... acquired at:  vfs_readdir+0x53/0xa0
=============================================
 
[ turning off deadlock detection. Please report this trace. ]
 


--------------030705090104000506080600--
