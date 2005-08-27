Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVH0LiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVH0LiE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 07:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVH0LiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 07:38:03 -0400
Received: from news.cistron.nl ([62.216.30.38]:61073 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1030360AbVH0LiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 07:38:02 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: Linux-2.6.13-rc7
Date: Sat, 27 Aug 2005 11:37:57 +0000 (UTC)
Organization: Cistron
Message-ID: <depjal$2ig$1@news.cistron.nl>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <demrrd$si6$1@news.cistron.nl> <den6p6$a34$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1125142677 2640 62.216.30.70 (27 Aug 2005 11:37:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I Wrote:
>After 53 hours and 31 minutes it crashed.
>dth      pts/1        zaphod.dth.net   Wed Aug 24 09:54 - crash (2+05:31)
>reboot   system boot  2.6.13-rc7       Wed Aug 24 09:51         (2+05:41)
>
>Prior to this kernel it had been running 2.6.12-mm1 without problems:
>reboot   system boot  2.6.12-mm1       Sun Aug 14 12:13 (9+21:36)
>
>I will now compile & run rc7-git1.

RC7-GIT7 barfed on me after some 20 hours:

root     ttyS0                         Fri Aug 26 16:32 - crash  (20:44)
reboot   system boot  2.6.13-rc7-git1  Fri Aug 26 16:32          (20:59)

I managed to get some information from the serial console:


scsi0: SCBPTR == 0x55, SCB_NEXT == 0xff80, SCB_NEXT2 == 0xff6e
CDB 0 0 0 0 0 0
STACK: 0x10c 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): NMI Watchdog detected LOCKUP on CPU0CPU 0
Modules linked in: rawfs rtc evdev hw_random i2c_amd8111 tg3 e100 mii w83627hf eeprom lm85 i2c_sensor i2c_isa i2c_amd756 i2c_core psmouse
Pid: 168, comm: scsi_eh_0 Not tainted 2.6.13-rc7-git1
RIP: 0010:[<ffffffff802644f9>] <ffffffff802644f9>{serial_in+105}
RSP: 0018:ffff81007fc17b80  EFLAGS: 00000002
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff80473a40
RBP: 0000000000002705 R08: 0000000000000020 R09: 0000000000007930
R10: 0000000000000034 R11: 000000000000000a R12: ffffffff80473a40
R13: ffffffff8045f6fe R14: 000000000000000d R15: 000000000000000d
FS:  00002aaaab3cbe90(0000) GS:ffffffff80485800(0000) knlGS:00000000556ada40
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000515970 CR3: 000000007dc27000 CR4: 00000000000006e0
Process scsi_eh_0 (pid: 168, threadinfo ffff81007fc16000, task ffff8100033607c0)
Stack: ffffffff8026682d 0000000500000002 ffffffff803ebc60 0000000000007931
       000000000000000d 0000000000000096 0000000000000010 0000000000000046
       ffffffff8012ed9c 000000000000793e
Call Trace:<ffffffff8026682d>{serial8250_console_write+413} <ffffffff8012ed9c>{__call_console_drivers+76}
       <ffffffff8012f053>{release_console_sem+339} <ffffffff8012fbc9>{vprintk+601}
       <ffffffff8012fbc9>{vprintk+601} <ffffffff8012fc3e>{printk+78}
       <ffffffff80325a40>{thread_return+0} <ffffffff8012fc3e>{printk+78}
       <ffffffff8028c235>{ahd_print_register+261} <ffffffff802abc34>{ahd_platform_dump_card_state+100}
       <ffffffff80296b0d>{ahd_dump_card_state+8973} <ffffffff802ad320>{ahd_linux_abort+624}
       <ffffffff802aa590>{ahd_linux_sem_timeout+0} <ffffffff80284f5c>{scsi_error_handler+1324}
       <ffffffff8010e396>{child_rip+8} <ffffffff80284a30>{scsi_error_handler+0}
       <ffffffff8010e38e>{child_rip+0}

Code: 0f b6 c0 c3 66 66 90 41 57 49 89 f7 41 56 41 55 41 bd 00 01
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


I don't know if this is enough information for the developers to go on.

For me it's back to 2.6.12-mm1 *snif*

Danny

