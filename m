Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWKEPwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWKEPwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 10:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWKEPwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 10:52:09 -0500
Received: from smtpa3.netcabo.pt ([212.113.174.18]:29012 "EHLO
	exch01smtp02.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932703AbWKEPwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 10:52:07 -0500
Message-ID: <454E0976.8030303@rncbc.org>
Date: Sun, 05 Nov 2006 15:55:34 +0000
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mike Galbraith <efault@gmx.de>, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org>
In-Reply-To: <454C714B.8030403@rncbc.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2006 15:52:05.0809 (UTC) FILETIME=[57C6F210:01C700F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a suggestion from Mike Galbraith, I now turned to pure and
original 2.6.18-rt7 and configured with:

CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
CONFIG_STACK_UNWIND=y

Nasty things still do happen, as the following capture can tell as evidence:

...
Oops: 0002 [#1]
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c02f8d2f>] __schedule+0x63f/0xea0
 [<c02f9700>] schedule+0x30/0x100
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 snd_seq_dummy
snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event edd snd_seq
button battery ac w83627hf hwmon_vid hwmon i2c_isa loop dm_mod usbhid
wacom intel_rng shpchp pci_hotplug snd_ice1712 snd_ice17xx_ak4xxx
snd_ak4xxx_adda snd_cs8427 ohci1394 snd_i2c ieee1394 snd_mpu401_uart
i8xx_tco ide_cd snd_cs46xx gameport snd_rawmidi snd_seq_device
snd_intel8x0 cdrom uhci_hcd snd_ac97_codec snd_ac97_bus snd_pcm sk98lin
i2c_i801 snd_timer snd i2c_core soundcore snd_page_alloc ehci_hcd
usbcore intel_agp agpgart ext3 jbd reiserfs fan thermal processor piix
ide_disk ide_core
CPU:    0
EIP:    0060:[<c011f4cb>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-rt7.0-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f708   ebx: c188f28c   ecx: 00000000   edx: dfd490d8
esi: dfd490b0   edi: c188edc0   ebp: c5729d74   esp: c5729d6c
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process sh (pid: 1693, ti=c5728000 task=dfc8d4b0 task.ti=c5728000)
Stack: c188edc0 dfd490b0 c5729d84 c011f551 00000001 dfd490b0 c5729de8
c01218c1
       00000000 c5729da8 c0168fd3 00000000 0000001f c5728000 00000001
00000000
       00000004 c5729dcc c0120550 c180edc0 00000001 c19e8bb0 c5729dcc
c02fb4c8
Call Trace:
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c02f9700>] schedule+0x30/0x100
 [<c012b04c>] do_wait+0x72c/0xbf0
 [<c012b542>] sys_wait4+0x32/0x40
 [<c012b577>] sys_waitpid+0x27/0x30
 [<c0105309>] sysenter_past_esp+0x56/0x79
 [<b7ef1410>] 0xb7ef1410
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 60 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011f4cb>] enqueue_task+0x2b/0x90 SS:ESP 0068:c5729d6c
 <6>note: sh[1693] exited with preempt_count 3
...

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
