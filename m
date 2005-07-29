Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVG2IvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVG2IvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVG2Iuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:50:52 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:4332 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S262525AbVG2Ise
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:48:34 -0400
Subject: Kernel BUG at "mm/rmap.c":493 OR corrupt swap partition
From: antoine <antoine@nagafix.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Nagafix Ltd
Date: Fri, 29 Jul 2005 09:47:52 +0100
Message-Id: <1122626872.4018.9.camel@dhcp-192-168-22-217.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My amd64 laptop running 2.6.13-rc3-git7 has rebooted overnight (it was
just running seti client), I found this in the logs:
(I hope this is useful to someone)

Jul 28 19:01:01 dhcp-192-168-22-217 crond(pam_unix)[20532]: session
closed for user root
Jul 28 19:14:52 dhcp-192-168-22-217 kernel: [ 8055.014116] warning: many
lost ticks.
Jul 28 19:14:52 dhcp-192-168-22-217 kernel: [ 8055.014121] Your time
source seems to be instable or some driver is hogging interupts
Jul 28 19:14:52 dhcp-192-168-22-217 kernel: [ 8055.014133] rip
handle_IRQ_event+0x1a/0x60 Jul 28 19:24:36 dhcp-192-168-22-217 kernel:
[ 8637.844075] general protection fault: 0000 [1] PREEMPT
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844081] CPU 0 Jul 28
19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844083] Modules linked in:
via82cxxx_audio uart401 sound ac97_codec parport_pc lp parport rfcomm
l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter
ip_tables dm_mod hotkey container tsdev usbhid yenta_socket
rsrc_nonstatic uhci_hcd ehci_hcd shpchp i2c_viapro i2c_core
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844099] Pid: 5049,
comm: cpufreq-applet Tainted: G   M  2.6.13-rc3-git7
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844102] RIP:
0010:[<ffffffff8019a8ba>] <ffffffff8019a8ba>{sys_poll+474}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844112] RSP:
0000:ffff810041a4fef8  EFLAGS: 00010282
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844116] RAX:
ffff5f74804ef680 RBX: ffff810041b883c0 RCX: 0000000000000304 Jul 28
19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844119] RDX:
0000000000000304 RSI: ffff810041b94070 RDI: 0000000000000001
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844124] RBP:
0000000000000020 R08: ffff810041a4e000 R09: ffff810043089580
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844128] R10:
00000000001b6852 R11: ffffffff803afa90 R12: ffff81003800d154
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844131] R13:
0000000000000009 R14: ffff81003800d100 R15: 000000000000000b
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844136] FS:
00002aaaaaae7da0(0000) GS:ffffffff80621800(0000) knlGS:00000000555919e0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844139] CS:  0010 DS:
0000 ES: 0000 CR0: 000000008005003b
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844142] CR2:
0000000056418000 CR3: 0000000041a51000 CR4: 00000000000006e0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844147] Process
cpufreq-applet (pid: 5049, threadinfo ffff810041a4e000, task
ffff810041a4d5e0)
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844149] Stack:
00000007419f5c00 0000000000000000 0000000000573000 0000000000573000
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844155]
0000000000000000 ffff81003800d100 ffffffff8019a110 ffff810006285000
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844161]
0000000000000000 ffffffff801119d7
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844165] Call
Trace:<ffffffff8019a110>{__pollwait+0}
<ffffffff801119d7>{syscall_trace_leave+55}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844179]
<ffffffff8010ed92>{tracesys+209}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844189]
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844190] Code: 48 8b
40 38 48 85 c0 74 0e 48 8b 74 24 20 48 89 df ff d0 89
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844201] RIP
<ffffffff8019a8ba>{sys_poll+474} RSP <ffff810041a4fef8>
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.844207]  <0>general
protection fault: 0000 [2] PREEMPT
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845297] CPU 0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845299] Modules
linked in: via82cxxx_audio uart401 sound ac97_codec parport_pc lp
parport rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack
iptable_filter ip_tables dm_mod hotkey container tsdev usbhid
yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp i2c_viapro i2c_core
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845313] Pid: 5049,
comm: cpufreq-applet Tainted: G   M  2.6.13-rc3-git7
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845316] RIP:
0010:[<ffffffff80182e49>] <ffffffff80182e49>{filp_close+57}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845324] RSP:
0000:ffff810041a4fd38  EFLAGS: 00010282
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845328] RAX:
ffff5f74804ef680 RBX: ffff810041b883c0 RCX: 0000000000e6fa88
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845332] RDX:
0000000000000000 RSI: ffff81004fe853c0 RDI: ffff810041b883c0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845336] RBP:
0000000000000024 R08: 00000000ffffffff R09: 00000000fffffffa
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845340] R10:
ffff810028cbbd78 R11: ffffffff801a1b90 R12: ffff81004fe853c0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845343] R13:
0000000000000000 R14: 0000000000000001 R15: 000000000000000b
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845348] FS:
00002aaaaaae7da0(0000) GS:ffffffff80621800(0000) knlGS:00000000555919e0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845351] CS:  0010 DS:
0000 ES: 0000 CR0: 000000008005003b
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845354] CR2:
0000000056418000 CR3: 0000000041a51000 CR4: 00000000000006e0
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845359] Process
cpufreq-applet (pid: 5049, threadinfo ffff810041a4e000, task
ffff810041a4d5e0)
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845361] Stack:
0000000000000001 0000000000000024 ffff81004fe853c0 ffffffff801384a4
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845367]
ffff81004fe853c0 0000000000000001 ffff810041a4d5e0 000000000000000b
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845372]
ffff81003800d100 ffffffff801396aa
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845376] Call
Trace:<ffffffff801384a4>{put_files_struct+116}
<ffffffff801396aa>{do_exit+554}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845388]
<ffffffff802b1a2e>{do_unblank_screen+110} <ffffffff80110555>{die+69}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845400]
<ffffffff8011097e>{do_general_protection+270}
<ffffffff8010f525>{error_exit+0}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845409]
<ffffffff803afa90>{unix_poll+0} <ffffffff8019a8ba>{sys_poll+474}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845422]
<ffffffff8019a8a4>{sys_poll+452} <ffffffff8019a110>{__pollwait+0}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845430]
<ffffffff801119d7>{syscall_trace_leave+55} <ffffffff8010ed92>{tracesys
+209}
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845439]
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845444]
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845445] Code: 48 8b
40 68 48 85 c0 74 06 ff d0 89 c5 eb 02 31 ed 4c 89 e6
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845456] RIP
<ffffffff80182e49>{filp_close+57} RSP <ffff810041a4fd38>
Jul 28 19:24:36 dhcp-192-168-22-217 kernel: [ 8637.845462]  <1>Fixing
recursive fault but reboot is needed!
Jul 28 19:33:13 dhcp-192-168-22-217 kernel: [ 9154.504760] swap_dup: Bad
swap file entry 880000000043be99
Jul 28 19:33:13 dhcp-192-168-22-217 kernel: [ 9154.506606] swap_free:
Bad swap file entry 880000000043be99
Jul 28 19:33:13 dhcp-192-168-22-217 su(pam_unix)[5085]: session closed
for user root
Jul 28 19:33:13 dhcp-192-168-22-217 kernel: [ 9154.650003] swap_free:
Bad swap file entry 583ddc0000000080
Jul 28 19:33:13 dhcp-192-168-22-217 gconfd (antoine-4914): Received
signal 15, shutting down cleanly
Jul 28 19:33:13 dhcp-192-168-22-217 gdm[4809]:
gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Jul 28 19:33:13 dhcp-192-168-22-217 gdm(pam_unix)[4809]: session closed
for user antoine
Jul 28 19:33:13 dhcp-192-168-22-217 dbus: avc:  1 AV entries and 1/512
buckets used, longest chain length 1
Jul 28 19:33:13 dhcp-192-168-22-217 gpm[4477]: *** info [mice.c(1766)]:
Jul 28 19:33:13 dhcp-192-168-22-217 gpm[4477]: imps2: Auto-detected
intellimouse PS/2
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325597] -----------
[cut here ] --------- [please bite here ] ---------
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325603] Kernel BUG at
"mm/rmap.c":493
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325606] invalid
operand: 0000 [3] PREEMPT
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325609] CPU 0
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325611] Modules
linked in: via82cxxx_audio uart401 sound ac97_codec parport_pc lp
parport rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack
iptable_filter ip_tables dm_mod hotkey container tsdev usbhid
yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp i2c_viapro i2c_core
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325625] Pid: 20108,
comm: evolution-data- Tainted: G   M  2.6.13-rc3-git7
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325629] RIP:
0010:[<ffffffff80178897>] <ffffffff80178897>{page_remove_rmap+39}
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325638] RSP:
0018:ffff81004b0a5c40  EFLAGS: 00010286
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325642] RAX:
00000000ffffffff RBX: 0000000000000020 RCX: ffffffff805a5fe0
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325646] RDX:
ffff810043fa9520 RSI: ffffffffffffffff RDI: ffff810001ed1a18
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325651] RBP:
ffff810001ed1a18 R08: ffffffffffffffff R09: ffff81004b0a5d38
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325654] R10:
0000000000000000 R11: 0000000000000246 R12: ffff8100414735c0
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325658] R13:
0000003c23ebd000 R14: 0000003c23eb8000 R15: 0000003c23ebd000
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325663] FS:
0000000041843960(0000) GS:ffffffff80621800(0000) knlGS:00000000555919e0
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325666] CS:  0010 DS:
0000 ES: 0000 CR0: 000000008005003b
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325669] CR2:
00000000408419f0 CR3: 000000004187b000 CR4: 00000000000006e0
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325674] Process
evolution-data- (pid: 20108, threadinfo ffff81004b0a4000, task
ffff810006e5d560)
Jul 28 19:33:23 dhcp-192-168-22-217 kernel: [ 9160.325676] Stack:
ffffffff80170d41 ffff81004b0a5d38 ffffffffffffffff 0000000000000000
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325683]
ffff8100414d0828 ffff81004cb07640 ffff81004b0a5d40 0000000000008000
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325689]
0000003c23ebd000 0000000000000000
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325692] Call
Trace:<ffffffff80170d41>{unmap_vmas+1121} <ffffffff80174b83>{exit_mmap
+131}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325707]
<ffffffff8013414f>{mm_release+47} <ffffffff80134980>{mmput+48}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325716]
<ffffffff80139653>{do_exit+467} <ffffffff80144b5e>{__dequeue_signal+558}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325724]
<ffffffff8013a298>{do_group_exit+280}
<ffffffff801455fe>{get_signal_to_deliver+1598}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325735]
<ffffffff8010e31d>{do_signal+157}
<ffffffff8015da70>{audit_filter_syscall+208}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325746]
<ffffffff801335d0>{default_wake_function+0}
<ffffffff8015ed26>{audit_syscall_exit+982}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325755]
<ffffffff8010ecb7>{sysret_signal+28}
<ffffffff8010ef9f>{ptregscall_common+103}
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325764]
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325771]
Jul 28 19:33:24 dhcp-192-168-22-217 kernel: [ 9160.325771] Code: 0f 0b
b8 41 40 80 ff ff ff ff ed 01 48 c7 c6 ff ff ff ff bf
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325782] RIP
<ffffffff80178897>{page_remove_rmap+39} RSP <ffff81004b0a5c40>Jul 28
19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325789]  <1>Fixing recursive
fault but reboot is needed!
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325793] scheduling
while atomic: evolution-data-/0x00000001/20108
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325795]
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325796] Call
Trace:<ffffffff803e18ca>{schedule+122} <ffffffff803e2e93>{__down_read
+51}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325806]
<ffffffff8010ffc4>{show_stack+212} <ffffffff80139596>{do_exit+278}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325816]
<ffffffff802b1a2e>{do_unblank_screen+110} <ffffffff80110555>{die+69}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325831]
<ffffffff80111093>{do_invalid_op+163}
<ffffffff80178897>{page_remove_rmap+39}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325840]
<ffffffff8010f525>{error_exit+0} <ffffffff80178897>{page_remove_rmap+39}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325855]
<ffffffff80170d41>{unmap_vmas+1121} <ffffffff80174b83>{exit_mmap+131}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325868]
<ffffffff8013414f>{mm_release+47} <ffffffff80134980>{mmput+48}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325876]
<ffffffff80139653>{do_exit+467} <ffffffff80144b5e>{__dequeue_signal+558}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325884]
<ffffffff8013a298>{do_group_exit+280}
<ffffffff801455fe>{get_signal_to_deliver+1598}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325894]
<ffffffff8010e31d>{do_signal+157}
<ffffffff8015da70>{audit_filter_syscall+208}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325905]
<ffffffff801335d0>{default_wake_function+0}
<ffffffff8015ed26>{audit_syscall_exit+982}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325914]
<ffffffff8010ecb7>{sysret_signal+28}
<ffffffff8010ef9f>{ptregscall_common+103}
Jul 28 19:33:25 dhcp-192-168-22-217 kernel: [ 9160.325923]
Jul 28 20:01:01 dhcp-192-168-22-217 crond(pam_unix)[21096]: session
opened for user root by (uid=0)


