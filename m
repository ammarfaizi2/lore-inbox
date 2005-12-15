Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVLOW0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVLOW0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVLOW0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:26:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1678 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751156AbVLOW0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:26:40 -0500
Message-ID: <43A1ECDF.9040200@nc.rr.com>
Date: Thu, 15 Dec 2005 17:23:27 -0500
From: William Cohen <wcohen@nc.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: William Cohen <wcohen@redhat.com>, perfctr-devel@lists.sourceforge.net,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.15-rc5-git3 perfmon2 new code base + libpfm
 available
References: <20051215104604.GA16937@frankl.hpl.hp.com> <43A1DE94.8050105@redhat.com> <20051215215921.GJ18331@frankl.hpl.hp.com>
In-Reply-To: <20051215215921.GJ18331@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Will,
> 
> 
> On Thu, Dec 15, 2005 at 04:22:28PM -0500, William Cohen wrote:
> 
>>Stephane Eranian wrote:
> 
> 
>>>I have released a new version of the perfmon base package.
>>>This release is relative to 2.6.15-rc5-git3.
>>>
>>>I have also updated the library, libpfm-3.2, to match the kernel
>>>level changes. 
>>
>>I downloaded the new version of perfmon and the matching libpfm. I built 
>>everything on a p6 based machine. The kernel booted fine. I tried the 
>>task_smpl_user in the libpfm examples. That crashed the kernel. What was 
>>on the xterm:
>>
>>$ ./task_smpl_user ls
>>measuring at plm=0x8
>>programming 2 PMCS and 2 PMDS
>>Segmentation fault
>>
> 
> I have not tried this particular test program in a long time. I nfact, I would
> like to remove it from the suite because it does not make any real sense.
> In any case, it should not crash the kernel. I will investigate this.
> I don't think it it related to you using a P6. This is more the case of
> an error in the cleanup code in case the context cannot be created properly.

If it just seg faulted the user space program I wouldn't care either, 
but when it crashed the kernel I thought that you might like to know 
about that.

> Does task_smpl work properly?

task_smpl gave data, but appeared to get a kernel oops. Output from xterm:

$ ./task_smpl ls
smpl_pmd_mask=0x3
programming 2 PMCS and 2 PMDS
context [3] buffer mapped @0xb7f8f000
hdr_cur_offs=112 version=1.0
ia32                 self               task
ia64                 self2              task_attach
Makefile             self2.c            task_attach.c
multiplex            self2.o            task_attach.o
multiplex2           self.c             task_attach_timeout
multiplex2.c         self.o             task_attach_timeout.c
multiplex2.o         self_standalone    task_attach_timeout.o
multiplex.c          self_standalone.c  task.c
multiplex.o          self_standalone.o  task.o
notify_self          self_view          task_smpl
notify_self2         self_view.c        task_smpl.c
notify_self2.c       self_view.o        task_smpl.o
notify_self2.o       set_notify         task_smpl_user
notify_self3         set_notify.c       task_smpl_user.c
notify_self3.c       set_notify.o       task_smpl_user.o
notify_self3.o       showreginfo        task_view
notify_self.c        showreginfo.c      task_view.c
notify_self.o        showreginfo.o      task_view.o
notify_standalone    smpl_standalone    whichpmu
notify_standalone.c  smpl_standalone.c  whichpmu.c
notify_standalone.o  smpl_standalone.o  whichpmu.o
rtop                 syst               x86_64
rtop.c               syst.c
rtop.o               syst.o
task terminated
entry 0 PID:2800 TID:2800 CPU:0 LAST_VAL: 100000 IIP:0x00000000c0105678
PMD1  = 0x0000000000003caa
entry 1 PID:2800 TID:2800 CPU:0 LAST_VAL: 100005 IIP:0x00000000003e94c2
PMD1  = 0x00000000000098a0
entry 2 PID:2800 TID:2800 CPU:0 LAST_VAL: 100067 IIP:0x000000000055093b
PMD1  = 0x00000000000088dc
entry 3 PID:2800 TID:2800 CPU:0 LAST_VAL: 100181 IIP:0x00000000004f7dd6
PMD1  = 0x0000000000006448
entry 4 PID:2800 TID:2800 CPU:0 LAST_VAL: 100020 IIP:0x000000000045ad51
PMD1  = 0x0000000000006281
entry 5 PID:2800 TID:2800 CPU:0 LAST_VAL: 100012 IIP:0x000000000040f490
PMD1  = 0x0000000000007e34
entry 6 PID:2800 TID:2800 CPU:0 LAST_VAL: 100212 IIP:0x00000000003e60d3
PMD1  = 0x0000000000005fd0
entry 7 PID:2800 TID:2800 CPU:0 LAST_VAL: 100076 IIP:0x00000000003ea871
PMD1  = 0x00000000000078c2
entry 8 PID:2800 TID:2800 CPU:0 LAST_VAL: 100149 IIP:0x0000000000424745
PMD1  = 0x00000000000064da
entry 9 PID:2800 TID:2800 CPU:0 LAST_VAL: 100051 IIP:0x000000000045b465
PMD1  = 0x000000000000c0aa
entry 10 PID:2800 TID:2800 CPU:0 LAST_VAL: 100070 IIP:0x000000000046677c
PMD1  = 0x00000000000075ca
entry 11 PID:2800 TID:2800 CPU:0 LAST_VAL: 100170 IIP:0x000000000046899e
PMD1  = 0x0000000000014808
entry 12 PID:2800 TID:2800 CPU:0 LAST_VAL: 100230 IIP:0x000000000046637a
PMD1  = 0x0000000000016b21
entry 13 PID:2800 TID:2800 CPU:0 LAST_VAL: 100011 IIP:0x00000000004682aa
PMD1  = 0x00000000000185b6
entry 14 PID:2800 TID:2800 CPU:0 LAST_VAL: 100045 IIP:0x000000000804ddfb
PMD1  = 0x0000000000016e3d
entry 15 PID:2800 TID:2800 CPU:0 LAST_VAL: 100092 IIP:0x000000000804ddff
PMD1  = 0x0000000000012b35
entry 16 PID:2800 TID:2800 CPU:0 LAST_VAL: 100005 IIP:0x000000000804d4cd
PMD1  = 0x000000000001544f
entry 17 PID:2800 TID:2800 CPU:0 LAST_VAL: 100067 IIP:0x000000000804c220
PMD1  = 0x000000000001761f
18 samples collected in 0 buffer overflows
real 0h00m00.007s user 0h00m00.000s sys 1141h33m30.134513s

Related information in /var/log/messages:

Dec 15 17:13:00 trek kernel: perfmon_p6: family=6 x86_model=8
Dec 15 17:13:00 trek kernel: P6 core PMU detected
Dec 15 17:13:00 trek kernel: perfmon: Intel P6 Family Processor PMU 
detected, 2 PMCs, 2 PMDs, 2 counters (31 bits) RW_max:2
Dec 15 17:13:00 trek kernel: Intel P6 Family Processor PMU installed
Dec 15 17:13:22 trek kernel: Debug: sleeping function called from 
invalid context at arch/i386/lib/usercopy.c:607
Dec 15 17:13:22 trek kernel: in_atomic():0, irqs_disabled():1
Dec 15 17:13:22 trek kernel:  [<c020e4e3>] copy_to_user+0x23/0x90
Dec 15 17:13:22 trek kernel:  [<c0205129>] pfm_read+0xa9/0x320
Dec 15 17:13:22 trek kernel:  [<c0121180>] default_wake_function+0x0/0x10
Dec 15 17:13:22 trek kernel:  [<c0205080>] pfm_read+0x0/0x320
Dec 15 17:13:22 trek kernel:  [<c01713e8>] vfs_read+0xb8/0x170
Dec 15 17:13:22 trek kernel:  [<c0171771>] sys_read+0x41/0x70
Dec 15 17:13:22 trek kernel:  [<c010569d>] syscall_call+0x7/0xb
Dec 15 17:13:22 trek kernel: Unable to handle kernel paging request at 
virtual address 6b6b6ba7
Dec 15 17:13:22 trek kernel:  printing eip:
Dec 15 17:13:22 trek kernel: c0202b51
Dec 15 17:13:22 trek kernel: *pde = 00000000
Dec 15 17:13:22 trek kernel: Oops: 0000 [#1]
Dec 15 17:13:22 trek kernel: SMP
Dec 15 17:13:22 trek kernel: Modules linked in: perfmon_p6 ipv6 lp 
autofs4 rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack 
nfnetlink iptable_filter ip_tables dm_mirror dm_mod video button battery 
ac parport_pc parport snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_cs46xx snd_emu10k1 snd_seq_dummy snd_seq_oss 
snd_seq_midi_event snd_seq snd_rawmidi snd_seq_device snd_ac97_codec 
snd_pcm_oss snd_ac97_bus snd_mixer_oss snd_util_mem snd_pcm snd_hwdep 
snd_timer floppy emu10k1_gp snd snd_page_alloc soundcore gameport 3c59x 
mii i2c_i801 i2c_core hw_random uhci_hcd shpchp ext3 jbd
Dec 15 17:13:22 trek kernel: CPU:    1
Dec 15 17:13:22 trek kernel: EIP:    0060:[<c0202b51>]    Not tainted VLI
Dec 15 17:13:22 trek kernel: EFLAGS: 00010282   (2.6.15-rc5-git3-perfop)
Dec 15 17:13:22 trek kernel: EIP is at pfm_smpl_fmt_put+0x11/0x60
Dec 15 17:13:22 trek kernel: eax: d61afab0   ebx: 6b6b6b6b   ecx: 
d8b3d7a0   edx: d8b3d900
Dec 15 17:13:22 trek kernel: esi: d1852000   edi: 00000001   ebp: 
00000001   esp: d1f37ee0
Dec 15 17:13:22 trek kernel: ds: 007b   es: 007b   ss: 0068
Dec 15 17:13:22 trek kernel: Process task_smpl (pid: 2799, 
threadinfo=d1f37000 task=d61afab0)
Dec 15 17:13:22 trek kernel: Stack: 00000001 c0205803 c0156569 6b000246 
c13163a4 d1f935a0 d1f93614 d22ebb78
Dec 15 17:13:22 trek kernel:        00000286 00000000 00000010 00000010 
d1f93614 d1f57d3c d22ebb78 c0172475
Dec 15 17:13:22 trek kernel:        00000000 d1f935a0 d7f8fb68 d1f57d3c 
d1e1011c d2789bcc d7e45dbc 00000001
Dec 15 17:13:22 trek kernel: Call Trace:
Dec 15 17:13:22 trek kernel:  [<c0205803>] pfm_close+0x113/0x3d0
Dec 15 17:13:22 trek kernel:  [<c0156569>] poison_obj+0x29/0x60
Dec 15 17:13:22 trek kernel:  [<c0172475>] __fput+0xb5/0x1a0
Dec 15 17:13:22 trek kernel:  [<c01625e9>] remove_vma+0x39/0x50
Dec 15 17:13:22 trek kernel:  [<c016477b>] exit_mmap+0xab/0x100
Dec 15 17:13:22 trek kernel:  [<c0123423>] mmput+0x33/0xa0
Dec 15 17:13:22 trek kernel:  [<c0128816>] do_exit+0xf6/0x3d0
Dec 15 17:13:22 trek kernel:  [<c0109da8>] do_syscall_trace+0x218/0x22a
Dec 15 17:13:22 trek kernel:  [<c0128b67>] do_group_exit+0x37/0xa0
Dec 15 17:13:22 trek kernel:  [<c010569d>] syscall_call+0x7/0xb
Dec 15 17:13:22 trek kernel: Code: 00 01 00 00 ff 00 b8 80 4c 44 c0 e8 
9a d2 16 00 89 d8 5b c3 31 db eb ee 89 f6 85 c0 53 89 c3 74 39 b8 80 4c 
44 c0 e8 5f d2 16 00 <8b> 53 3c 85 d2 74 1b b8 00 f0 ff ff 21 e0 8b 40 
10 c1 e0 07 8d

-Will
