Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUI2QBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUI2QBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUI2QBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:01:21 -0400
Received: from ls413.htnet.hr ([195.29.150.117]:11959 "EHLO ls413.htnet.hr")
	by vger.kernel.org with ESMTP id S268681AbUI2QAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:00:40 -0400
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc2: bad: scheduling while atomic!
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: ENAMETOOLONG
X-Operating-System: GNU/Linux 2.6.8
Mail-Copies-To: never
From: Miroslav Zubcic <mvz@nimium.com>
Date: Wed, 29 Sep 2004 18:00:30 +0200
Message-ID: <lzsm91rroh.fsf@devana.home.int>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: ls413.htnet.hr 1096473638 20472 194.152.206.241 (Wed, 29 Sep 2004 18:00:38 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System description:

Hardware:
==========
HP/Compaq ProLiant 320DL

Dual Pentium 4 CPU system, 3Ghz, 512 cache
2 GB memory
2 80GB WD IDE drives, 5 partitions - all in software RAID1 (mirror) -
  not using hardware RAID.

lspci:
----------------------------------------------------
00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
00:02.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0649 (rev 02)
00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:04.0 System peripheral: Compaq Computer Corporation Advanced System Management Controller
00:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 02)
00:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 02)
00:0f.0 ISA bridge: ServerWorks CSB6 South Bridge (rev a0)
00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0)
00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks GCLE-2 Host Bridge
----------------------------------------------------

Usual inserted modules:
---------------------------
nfsd                  201856  9 
exportfs                7040  1 nfsd
lockd                  63720  2 nfsd
sunrpc                156672  13 nfsd,lockd
parport_pc             35424  0 
lp                     12360  0 
parport                42976  2 parport_pc,lp
autofs4                21700  2 
ppp_synctty            11008  0 
ppp_async              12224  1 
crc_ccitt               2336  1 ppp_async
ppp_generic            32300  6 ppp_synctty,ppp_async
slhc                    7584  1 ppp_generic
dummy                   3300  0 
md5                     4224  1 
ipv6                  284484  65 
8021q                  20968  0 
tg3                    89216  0 
ip_nat_ftp              5456  0 
ip_conntrack_ftp       72500  1 ip_nat_ftp
ipt_MASQUERADE          4576  1 
iptable_nat            25124  3 ip_nat_ftp,ipt_MASQUERADE
ipt_REJECT              7424  2 
ipt_state               2272  2 
ip_conntrack           37508  5 ip_nat_ftp,ip_conntrack_ftp,ipt_MASQUERADE,iptable_nat,ipt_state
iptable_filter          3072  1 
ip_tables              19632  5 ipt_MASQUERADE,iptable_nat,ipt_REJECT,ipt_state,iptable_filter
microcode               7488  0 
capability              4680  0 
commoncap               7648  1 capability
pcspkr                  3852  0 
psmouse                20456  0 
rtc                    14120  0 
---------------------------

No proprietary or even _any_ third party modules.

Software:
=========

Kernel: 2.6.9 rc2 (vanilla)
Distribution: Red Hat ES release 3, Update 3

gcc: 3.2.3
util-linux: 2.11y
module-init-tools: 2.4.26
binutils: 2.14.90.0.4

CONFIG_PREEMPT is y.
CONFIG_SCHED_SMT is n.

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

# CONFIG_APM is not set

Problem description:
====================

Kernel 2.6.8.1 will lock down on this machine if snmpd(8) is turned on
and receiving authenticated v3 requests for memory or interface status
from nagios NMS over network. No trace, no panic, no oops, no log
entries ...  - nothing just silence.

So I have decided to try 2.6.9 rc2 to see if this bug is
fixed. 2.6.9rc2 will *not* freeze when receiving snmp request over
network, but kernel will start logging this (below) endless errors
over and over very soon early during boot process:

-----------------------------------------------------------
Sep 29 16:48:49 svarog kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 29 16:48:50 svarog kernel: ip_tables: (C) 2000-2002 Netfilter core team
Sep 29 16:48:50 svarog last message repeated 11 times
Sep 29 16:48:50 svarog kernel: ip_conntrack version 2.1 (8192 buckets, 65536 max) - 336 bytes per conntrack
Sep 29 16:48:50 svarog kernel: process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
Sep 29 16:48:53 svarog kernel: Warning: kfree_skb on hard IRQ c0306a80
Sep 29 16:48:53 svarog kernel: bad: scheduling while atomic!
Sep 29 16:48:53 svarog kernel:  [<c030b11c>] schedule+0x64c/0x660
Sep 29 16:48:53 svarog kernel:  [<c029fae8>] sys_socketcall+0x168/0x270
Sep 29 16:48:53 svarog kernel:  [<c01053a2>] work_resched+0x5/0x16
Sep 29 16:48:53 svarog kernel: Warning: kfree_skb on hard IRQ c0306a80
Sep 29 16:48:53 svarog last message repeated 4 times
Sep 29 16:48:53 svarog kernel: bad: scheduling while atomic!
Sep 29 16:48:53 svarog kernel:  [<c030b11c>] schedule+0x64c/0x660
Sep 29 16:48:53 svarog kernel:  [<c029fae8>] sys_socketcall+0x168/0x270
Sep 29 16:48:58 svarog kernel:  [<c01053a2>] work_resched+0x5/0x16
Sep 29 16:49:09 svarog kernel: Warning: kfree_skb on hard IRQ c0306a80
Sep 29 16:49:26 svarog kernel:  [<c0160172>] sys_fsync+0xa2/0xe0
Sep 29 16:49:32 svarog kernel:  [<c010537b>] syscall_call+0x7/0xb
Sep 29 16:49:36 svarog kernel: Warning: kfree_skb on hard IRQ c0306a80
Sep 29 16:49:38 svarog kernel: bad: scheduling while atomic!
Sep 29 16:49:41 svarog kernel:  [<c030b11c>] schedule+0x64c/0x660
Sep 29 16:49:42 svarog kernel:  [<c02319d5>] generic_make_request+0x115/0x1a0
Sep 29 16:49:44 svarog kernel:  [<c01b7af2>] find_revoke_record+0x72/0x90
Sep 29 16:49:46 svarog kernel:  [<c01b81f9>] journal_cancel_revoke+0x69/0x1f0
Sep 29 16:49:46 svarog kernel:  [<c030b204>] wait_for_completion+0x84/0xd0
Sep 29 16:49:49 svarog kernel:  [<c011bd30>] default_wake_function+0x0/0x20
Sep 29 16:49:51 svarog kernel:  [<c011bd30>] default_wake_function+0x0/0x20
Sep 29 16:49:54 svarog kernel:  [<c0292b83>] sync_page_io+0xa3/0xc0
Sep 29 16:49:56 svarog kernel:  [<c01a507e>] ext3_do_update_inode+0x16e/0x3c0
Sep 29 16:49:58 svarog kernel:  [<c0292ac0>] bi_complete+0x0/0x20
Sep 29 16:50:00 svarog kernel:  [<c029452b>] write_disk_sb+0x7b/0xc0
Sep 29 16:50:02 svarog kernel:  [<c02945a4>] sync_sbs+0x34/0x50
Sep 29 16:50:05 svarog kernel:  [<c029466e>] md_update_sb+0xae/0xe0
Sep 29 16:50:10 svarog kernel:  [<c011d8f0>] autoremove_wake_function+0x0/0x60
Sep 29 16:50:12 svarog kernel:  [<c01b305f>] journal_stop+0x21f/0x350
Sep 29 16:50:15 svarog kernel:  [<c011d8f0>] autoremove_wake_function+0x0/0x60
Sep 29 16:50:17 svarog kernel:  [<c0297b23>] md_write_start+0x93/0xa0
Sep 29 16:50:21 svarog kernel:  [<c0290c67>] make_request+0x1a7/0x300
Sep 29 16:50:23 svarog kernel:  [<c01a2d35>] ext3_ordered_commit_write+0xd5/0x100
Sep 29 16:50:27 svarog kernel:  [<c02319d5>] generic_make_request+0x115/0x1a0
Sep 29 16:50:31 svarog kernel:  [<c0141e41>] mempool_alloc+0x71/0x140
Sep 29 16:50:35 svarog kernel:  [<c011d8f0>] autoremove_wake_function+0x0/0x60
Sep 29 16:50:37 svarog kernel:  [<c0231ad1>] submit_bio+0x71/0x130
Sep 29 16:50:39 svarog kernel:  [<c0163a27>] bio_alloc+0xe7/0x1d0
Sep 29 16:50:41 svarog kernel:  [<c016323c>] submit_bh+0xdc/0x140
Sep 29 16:50:41 svarog kernel:  [<c0161952>] __block_write_full_page+0x1e2/0x3a0
Sep 29 16:50:46 svarog kernel:  [<c01630a0>] block_write_full_page+0x100/0x120
-----------------------------------------------------------

and so on and on until rebooted by plugging power off/on.



-- 
Many men would sooner die then think. In fact they do.
		-- Bertrand Russell

